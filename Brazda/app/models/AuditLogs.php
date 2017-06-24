<?php

namespace Brazda\Models;

use Brazda\Models\Logs,
    Nette;;

class AuditLogs extends Base
{

    public function view($team = null, $logType = null, $newerThan = null)
    {
        return $this->db->query(
            "SELECT *
             FROM audit_logs
             WHERE TRUE
             %if", is_numeric($team), "AND team = %i", (int) $team, "%end",
            "%if", Logs::checkLogType($logType), "AND log_type = %s %end",
            "ORDER BY moment DESC"
        ); // query()
    } // view()

    public function log($team, $message, $logType)
    {
        $team = (int) $team;

        return $this->db->query(
            "INSERT INTO audit_logs %v RETURNING audit_log", [
                'team' => $team,
                'message' => $message,
                'log_type' => $logType
            ]
        )->fetchSingle('audit_log');
    } // log()

} // AuditLogs
