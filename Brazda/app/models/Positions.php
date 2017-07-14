<?php

namespace Brazda\Models;


class Positions extends Base
{

    public function lastPosition($team)
    {
        $team = (int) $team;

        return $this->db->query(
           "SELECT
                moment,
                position
            FROM positions
            WHERE team = %i", $team, "
            ORDER BY moment DESC
            LIMIT 1"
        )->fetchRow();
    } // lastPosition()

} // Positions
