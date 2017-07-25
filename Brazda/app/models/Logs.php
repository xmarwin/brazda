<?php

namespace Brazda\Models;

use Nette;

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
                p.size,
                p.description,
                t.name AS team_name
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
                p.size,
                p.description,
                t.name AS team_name
             FROM logs l
             JOIN log_types lt USING (log_type)
             JOIN posts p USING (post)
             JOIN teams t USING (team)
             %if", !empty($filter), "WHERE %and", $filter, "%end
             %if", !empty($order), "ORDER BY %by", $order, "%end
             %if", !empty($limit), "LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        ); // query()
    } // view()

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

    public function nextLog($team, $post)
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

        return $lastErrorLogs[0]->expire;
    } // nextLog()
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
