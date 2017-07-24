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

    public function view(array $filter = [], array $order = [], array $limit = [])
    {
		$filter = $this->normalizeFilter($filter);
		$order  = $this->normalizeOrder($order);
		$limit  = $this->normalizeLimit($limit);
		list($limit, $offset) = each($limit);

		if (isset($filter['team']) && !empty($filter['team'])) {
            $team = (int) $filter['team'];
            unset($filter['team']);
		} // if

        return $this->db->query(
            "SELECT
                w.waypoint,
                w.post,
                w.name,
                w.description,
                w.waypoint_type,
                wt.name AS waypoint_type_name,
                wt.rank AS waypoint_type_rank,
                w.waypoint_visibility,
                wv.name AS waypoint_visibility_name,
                %if", isset($team), "
                CASE WHEN (waypoint_visibility = 'VW') OR (waypoint_visibility = 'HC' AND lo.moment IS NOT NULL) THEN w.latitude ELSE NULL END AS latitude,
                CASE WHEN (waypoint_visibility = 'VW') OR (waypoint_visibility = 'HC' AND lo.moment IS NOT NULL) THEN w.longitude ELSE NULL END AS longitude
                %else
                CASE waypoint_visibility WHEN 'VW' THEN w.latitude ELSE NULL END AS altitude,
                CASE waypoint_visibility WHEN 'VW' THEN w.longitude ELSE NULL END AS longitude
                %end
             FROM waypoints w
             JOIN waypoint_types wt USING (waypoint_type)
             JOIN waypoint_visibilities wv USING (waypoint_visibility)
             %if", isset($team), "
             LEFT JOIN (
                SELECT post, moment
                FROM logs
                WHERE log_type = 'OUT'
                  AND team = %i", $team, "
             ) lo USING (post)
             %end
             %if", !empty($filter), " WHERE %and", $filter, "%end
             %if", !empty($orders), " ORDER BY %by", $order, "%end
             %if", !empty($limit),  " LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        ); // query()
    } // view()

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
