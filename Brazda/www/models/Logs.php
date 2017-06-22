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

    public function findLog($team, $post = 0, $logType = '')
    {
        $team = (int) $team;
        $post = (int) $post;
        $logType = $this->checkLogType($logType);

        return $this->db->query(
            "SELECT
                l.*,
                p.post_type,
                p.color,
                p.name,
                p.difficulty,
                p.terrain,
                p.size,
                p.description,
                t.name,
                t.description
             FROM logs l
             JOIN log_types lt USING (log_type)
             JOIN posts p USING (post)
             JOIN teams t USING (team)
             WHERE l.team = %i", $team,
              "%if", $post > 0, "AND l.post = %i", $post, "%end",
              "%if", !empty($logType), "AND l.log_type LIKE %s", $logType, "%end",
            "ORDER BY l.moment DESC
             LIMIT 1"
        )->fetch();
    } // findLog()

    public function view($team, $post = 0, $logType = '')
    {
        $team = (int) $team;
        $post = (int) $post;
        $logType = $this->checkLogType($logType);

        return $this->db->query(
            "SELECT
                l.*,
                p.post_type,
                p.color,
                p.name,
                p.difficulty,
                p.terrain,
                p.size,
                p.description,
                t.name,
                t.description
             FROM logs l
             JOIN log_types lt USING (log_type)
             JOIN posts p USING (post)
             JOIN teams t USING (team)
             WHERE l.team = %i", $team,
              "%if", $post > 0, "AND l.post = %i", $post, "%end",
              "%if", !empty($logType), "AND l.log_type LIKE %s", $logType, "%end",
            "ORDER BY l.moment DESC"
        ); // query()
    } // findLog()

    public function log($team, $post, $logType)
    {
        $team = (int) $team;
        $post = (int) $post;
        $logType = $this->checkLogType($logType);

        return $this->db->query(
            "INSERT INTO logs %v RETURNING log", [
                'team' => $team,
                'post' => $post,
                'log_type' => $logType
            ]
        )->fetchSingle('log');
    } // log()

    public function canLog($team, $post)
    {
        $team = (int) $team;
        $post = (int) $post;

        $parameters = $this->context->getParameters();
        $errorInterval = $parameters['errorInterval'];
        $interval = "{$errorInterval} minutes";

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
            throw new \UnexpectedValueException(sprintf(
                'Hodnota typu logu %s je neznámá',
                $logType
            )); // \UnexpectedValueException()
        } // if
    } // checkLogType()

} // Logs
