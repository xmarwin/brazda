<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Waypoints extends Base
{
    const FINALE = 'FIN';
    const STAGE = 'STA';
    const REFERENCE = 'REF';
    const PARKING = 'PAR';
    const WAYPOINT = 'WAY';

    const VISIBLE = 'VW';
    const HIDDEN_COORDINATES = 'HC';
    const HIDDEN = 'HW';

    public function overview($post = 0)
    {
        $post = (int) $post;

        return $this->db->query(
            "SELECT
                w.waypoint,
                w.waypoint_type,
                w.waypoint_visibility,
                w.post,
                w.name,
                w.description,
                w.latitude,
                w.longitude,
                wt.name AS waypoint_type_name,
                wt.rank AS waypoint_type_rank,
                wv.name AS waypoint_visibility_name
             FROM waypoints w
             JOIN waypoint_types wt USING (waypoint_type)
             JOIN waypoint_visibilities wv USING (waypoint_visibility)
             %if", $post > 0, "WHERE w.post = %i", $post, "%end",
             "ORDER BY wt.rank, w.name"
        );
    } // overview()

} // Waypoints
