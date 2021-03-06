<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Teams extends Base
{
    const ORGANIZATION = 'ORG';
    const COMPETITORS = 'COM';
    const KIDSCOMPETITORS = 'KID';

    const START = 'STR';
    const COMPETITION = 'CMP';
    const FINISH = 'FIN';

    protected
        $positions;

    public function find(array $filter)
    {
        $filter = $this->normalizeFilter($filter);
        $filter['is_active'] = true;

        return $this->db->query(
           "SELECT
                t.team,
                t.name,
                t.description,
                t.team_type AS role,
                tt.name AS role_name,
                t.is_active AS is_active,
                t.tracking_allowed AS allow_tracking,
                t.is_disqualified AS is_disqualified,
                t.team_status,
                t.shibboleth,
                t.telephone,
                t.email,
                ts.name AS status_name,
                p.moment AS position_moment,
                p.location AS position_location
            FROM teams t
            JOIN team_types tt USING (team_type)
            JOIN team_statuses ts USING (team_status)
            LEFT JOIN (
                SELECT
                    team,
                    moment,
                    location
                FROM positions
                ORDER BY moment DESC
                LIMIT 1
            ) p USING (team)
            WHERE %and", $filter
        )->fetch();
    } // find()

    public function view(array $filter = [], array $order = [], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        $offset = $limit['offset'];
        $limit  = $limit['limit'];

        return $this->db->query(
           "SELECT
                t.team,
                t.name,
                t.description,
                t.team_type AS role,
                tt.name AS roleName,
                t.is_active AS active,
                t.tracking_allowed AS allow_tracking,
                t.is_disqualified AS is_disqualified,
                t.team_status,
                t.shibboleth,
                t.telephone,
                t.email,
                ts.name AS status_name,
                p.moment AS position_moment,
                p.location AS position_location
            FROM teams t
            JOIN team_types tt USING (team_type)
            JOIN team_statuses ts USING (team_status)
            LEFT JOIN (
                SELECT
                    team,
                    moment,
                    location
                FROM positions
                ORDER BY moment DESC
                LIMIT 1
            ) p USING (team)
            WHERE TRUE
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
                t.is_disqualified AS is_disqualified,
                t.team_status,
                t.shibboleth,
                t.telephone,
                t.email,
                ts.name AS status_name,
                p.moment AS position_moment,
                p.location AS position_location
            FROM teams t
            JOIN team_types tt USING (team_type)
            JOIN team_statuses ts USING (team_status)
            LEFT JOIN (
                SELECT
                    team,
                    moment,
                    location
                FROM positions
                ORDER BY moment DESC
                LIMIT 1
            ) p USING (team)
            WHERE t.name ILIKE %~like~", $name
        )->fetch();
    } // findByName()

    public function insert(array $values)
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro zápis týmu.');

        self::checkType($values['team_type']);

        $values['is_active'] = $this->prepareBoolean($values['is_active']);
        if (isset($values['tracking_allowed']))
            $values['tracking_allowed'] = $this->prepareBoolean($values['tracking_allowed']);

        return $this->db->query(
            "INSERT INTO teams %v", $values,
            "RETURNING team"
        )->fetchSingle('team');
    } // insert()

    public function update(array $values, array $filter)
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro úpravu týmu.');

        if (!empty($values['team_type']))
            self::checkType($values['team_type']);

        $filter = $this->normalizeFilter($filter);

        return $this->db->query(
            "UPDATE teams
             SET %a", $values,
            "WHERE %and", $filter
        ); // query()
    } // update()

    public function delete(array $filter)
    {
        if (empty($filter))
            throw new \Exception('Chybí specifikace týmu pro smazání.');

        $filter = $this->normalizeFilter($filter);

        return $this->db->query(
            "DELETE FROM teams",
            "WHERE %and", $filter
        ); // query()
    } // delete()

    public static function checkType($value)
    {
        $validTypes = [
            self::ORGANIZATION,
            self::COMPETITORS,
            self::KIDSCOMPETITORS
        ];

        $value = strtoupper($value);
        if (!in_array($value, $validTypes)) {
            throw new \Exception(sprintf('Neplatný typ týmu %s.', $value));
        } // if
    } // checkType()

} // Teams
