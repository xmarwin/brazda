<?php

namespace Brazda\Models;


use Nette,
    Nette\DI;

class Teams extends Base
{
    const ORGANIZATION = 'ORG';
    const COMPETITORS = 'COM';

    const START = 'STR';
    const COMPETITION = 'CMP';
    const FINISH = 'FIN';

    protected
        $positions;

    public function find($team)
    {
        $team = (int) $team;

        return $this->db->query(
           "SELECT
                t.team,
                t.name,
                t.description,
                t.team_type AS role,
                tt.name AS roleName,
                t.is_active AS active,
                t.allow_tracking AS allowTracking,
                t.status,
                t.shibboleth,
                ts.name AS statusName,
                p.positionMoment,
                p.positionLocation
            FROM teams t
            JOIN team_types tt ON (team_type)
            JOIN team_statuses ts ON (team_status)
            LEFT JOIN (
                SELECT
                    team,
                    moment,
                    location
                FROM positions
                ORDER BY moment DESC,
                LIMIT 1
            ) p ON (team)
            WHERE t.is_active IS TRUE
              AND t.team = %i", $team
        )->fetch();
    } // find();

    public function view(array $filter = [], array $order = [], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        list($limit, $offset) = each($limit);

        return $this->db->query(
           "SELECT
                t.team,
                t.name,
                t.description,
                t.team_type AS role,
                tt.name AS roleName,
                t.is_active AS active,
                t.tracking_allowed AS allow_tracking,
                t.status,
                ts.name AS status_name,
                p.moment AS position_moment,
                p.location AS position_location
            FROM teams t
            JOIN team_types tt USING (team_type)
            JOIN team_statuses ts ON (t.status = ts.team_status)
            LEFT JOIN (
                SELECT
                    team,
                    moment,
                    location
                FROM positions
                ORDER BY moment DESC
                LIMIT 1
            ) p USING (team)
            WHERE t.is_active IS TRUE
            %if", !empty($filter), "AND %and", $filter, "%end
            %if", !empty($order), "ORDER BY %by", $order, "%end
            %if", !empty($limit), "LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        )->fetchAll();
    } // view()

    public function findByName($name)
    {
        return $this->db->query(
           "SELECT
                t.team,
                t.name,
                t.description,
                t.team_type AS role,
                tt.name AS roleName,
                t.is_active AS active,
                t.tracking_allowed AS allow_tracking,
                t.status,
                t.shibboleth,
                ts.name AS status_name,
                p.moment AS position_moment,
                p.location AS position_location
            FROM teams t
            JOIN team_types tt USING (team_type)
            JOIN team_statuses ts ON (t.status = ts.team_status)
            LEFT JOIN (
                SELECT
                    team,
                    moment,
                    location
                FROM positions
                ORDER BY moment DESC
                LIMIT 1
            ) p USING (team)
            WHERE t.is_active IS TRUE
              AND t.name ILIKE %~like~", $name
        )->fetch();
    } // findByName()

} // Teams
