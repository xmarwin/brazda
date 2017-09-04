<?php

namespace Brazda\Models;

use dibi,
    Nette;

class Logs extends Base
{
    const START  = 'STR';
    const FINISH = 'FIN';
    const DONE   = 'OUT';
    const BONUS  = 'BON';
    const ERROR  = 'ERR';
    const HELP   = 'HLP';

    public function find(array $filter)
    {
        $logType = self::checkLogType($filter['log_type']);

        return $this->db->query(
            "SELECT
                l.*,
                lt.name AS log_type_name,
                p.post_type,
                p.color,
                p.name,
                p.difficulty,
                p.terrain,
                p.cache_size,
                p.description,
                p.max_score,
                t.name AS team_name,
                t.team_type
             FROM logs l
             JOIN log_types lt USING (log_type)
             JOIN posts p USING (post)
             JOIN teams t USING (team)
             WHERE %and", $filter,
            "LIMIT 1"
        )->fetch();
    } // find()

    public function view(array $filter = [], array $order = [ 'moment' => 'ASC' ], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        list($limit, $offset) = each($limit);

        return $this->db->query(
            "SELECT
                l.*,
                lt.name AS log_type_name,
                p.post_type,
                p.color,
                p.name,
                p.difficulty,
                p.terrain,
                p.cache_size,
                p.description,
                p.max_score,
                t.name AS team_name,
                t.team_type
             FROM logs l
             JOIN log_types lt USING (log_type)
             JOIN posts p USING (post)
             JOIN teams t USING (team)
             %if", !empty($filter), "WHERE %and", $filter, "%end
             %if", !empty($order), "ORDER BY %by", $order, "%end
             %if", !empty($limit), "LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        ); // query()
    } // view()

    public function resultView(array $filter = [], array $order = [ 'moment' => 'ASC' ], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        list($limit, $offset) = each($limit);

        return $this->db->query(
            "SELECT
                l.log,
                l.moment,
                l.team,
                l.log_type,
                lo.moment AS log_out_moment,
                lh.moment AS log_help_moment,
                lb.moment AS log_bonus_moment,
                CASE WHEN lo.moment IS NOT NULL THEN TRUE ELSE FALSE END AS is_done,
                CASE WHEN lh.moment IS NOT NULL THEN TRUE ELSE FALSE END AS use_help,
                CASE WHEN lb.moment IS NOT NULL THEN TRUE ELSE FALSE END AS is_unlocked,
                p.post,
                p.name AS post_name,
                p.post_type,
                p.color,
                p.max_score,
                t.team,
                t.name,
                t.team_type
             FROM logs l
             JOIN posts p USING (post)
             JOIN teams t USING (team)
             LEFT JOIN (
                SELECT team, post, moment, log_type
                FROM logs
                WHERE log_type = 'OUT'
                ORDER BY moment
             ) lo USING (team, post)
             LEFT JOIN (
                SELECT team, post, moment, log_type
                FROM logs
                WHERE log_type = 'BON'
                ORDER BY moment
             ) lb USING (team, post)
             LEFT JOIN (
                SELECT team, post, moment, log_type
                FROM logs
                WHERE log_type = 'HLP'
                ORDER BY moment
             ) lh USING (team, post)
             WHERE l.log_type NOT IN ('ERR', 'HLP')
             %if", !empty($filter), " AND %and", $filter, "%end
             %if", !empty($order), "ORDER BY %by", $order, "%end
             %if", !empty($limit), "LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        ); // query()
    } // resultView()

    public function insert(array $values)
    {
        $values['log_type'] = self::checkLogType($values['log_type']);

        $record = [
            'log_type' => $values['log_type'],
            'team'     => (int) $values['team'],
            'post'     => (int) $values['post']
        ];

        return $this->db->query(
            "INSERT INTO logs %v", $record,
            "RETURNING log"
        )->fetchSingle('log');
    } // insert()

    public function canLog($team, $post)
    {
        $team = (int) $team;
        $post = (int) $post;

        $parameters = $this->context->getParameters();
        $interval = "{$parameters['logInterval']} minutes";

        $lastErrorLogs = $this->db->query(
            "SELECT *,
                (moment::timestamp + %s::interval", $interval, ") AS expire
             FROM logs
             WHERE team = %i", $team,
            "AND post = %i", $post,
            "AND log_type LIKE %s", self::ERROR,
            "ORDER BY moment DESC"
        )->fetchAll();

        return !(count($lastErrorLogs) > 1
            &&   time() < $lastErrorLogs[0]->expire->getTimestamp());
    } // canLog()

    public function canBonusLog($team, $post)
    {
        $team = (int) $team;
        $post = (int) $post;

        $parameters = $this->context->getParameters();
        $interval = "{$parameters['bonusInterval']} minutes";

        $lastErrorLogs = $this->db->query(
            "SELECT *,
                (moment::timestamp + %s::interval", $interval, ") AS expire
             FROM logs
             WHERE team = %i", $team,
            "AND post = %i", $post,
            "AND log_type LIKE %s", self::ERROR,
            "ORDER BY moment DESC"
        )->fetchAll();

        return !(count($lastErrorLogs) > 1
            &&   time() < $lastErrorLogs[0]->expire->getTimestamp());
    } // canBonusLog()

    public function nextLogTimeout()
    {
        $parameters = $this->context->getParameters();

        return "{$parameters['logInterval']} minutes";
    } // nextLogTimeout()

    public function nextLog($team, $post)
    {
        $team = (int) $team;
        $post = (int) $post;

        $interval = $this->nextLogTimeout();

        $lastErrorLogs = $this->db->query(
            "SELECT *,
                (moment::timestamp + %s::interval", $interval, ") AS expire
             FROM logs
             WHERE team = %i", $team,
            "AND post = %i", $post,
            "AND log_type LIKE %s", self::ERROR,
            "ORDER BY moment DESC"
        )->fetchAll();

        return (is_array($lastErrorLogs) && isset($lastErrorLogs[0]))
            ? $lastErrorLogs[0]->expire
            : null;
    } // nextLog()

    public function nextBonusLogTimeout()
    {
        $parameters = $this->context->getParameters();

        return "{$parameters['bonusInterval']} minutes";
    } // nextBonusLogTimeout()

    public function nextBonusLog($team, $post)
    {
        $team = (int) $team;
        $post = (int) $post;

        $interval = $this->nextBonusLogTimeout();

        $lastErrorLogs = $this->db->query(
            "SELECT *,
                (moment::timestamp + %s::interval", $interval, ") AS expire
             FROM logs
             WHERE team = %i", $team,
            "AND post = %i", $post,
            "AND log_type LIKE %s", self::ERROR,
            "ORDER BY moment DESC"
        )->fetchAll();

        return (is_array($lastErrorLogs) && isset($lastErrorLogs[0]))
            ? $lastErrorLogs[0]->expire
            : null;
    } // nextBonusLog()
/*
    public function deleteLog($team, $post, $logType)
    {
        $team = (int) $team;
        $post = (int) $post;

        return $this->db->query(
            "DELETE
             FROM logs
             WHERE team = %i", $team,
            "AND post = %i", $post,
            "AND log_type = %s", $logType
        ); // query()
    }
*/
    public static function checkLogType($logType)
    {
        $validLogTypes = [
            '',
            self::START,
            self::FINISH,
            self::DONE,
            self::BONUS,
            self::ERROR,
            self::HELP
        ]; // $validLogTypes

        $logType = trim($logType);
        if (in_array($logType, $validLogTypes)) {

            return $logType;
        } else {
            throw new \UnexpectedValueException(
                sprintf(
                    'Hodnota typu logu %s je neznámá',
                    $logType
                ),
                400
            ); // \UnexpectedValueException()
        } // if
    } // checkLogType()

} // Logs
