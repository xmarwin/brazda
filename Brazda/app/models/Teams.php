<?php

namespace Brazda\Models;


use Nette;

class Teams extends Base
{
    const ORGANIZATION = 'ORG';
    const COMPETITORS = 'COM';

    public function find($team)
    {
        $team = (int) $team;

        return $this->db->query(
            "SELECT *
             FROM teams
             WHERE team = %i", $team
        )->fetch();
    }

    public function view($teamType = self::COMPETITORS)
    {
        return $this->db->query(
            "SELECT *
             FROM teams
             %if", !empty($teamType), "WHERE team_type = %s", $teamType, "%end
             ORDER BY name"
        ); // query()
    }

    public function findByName($name)
    {
        return $this->db->query(
            "SELECT *
             FROM teams
             WHERE name ILIKE %~like~", $name
        )->fetch();
    } // findByName()

} // Teams
