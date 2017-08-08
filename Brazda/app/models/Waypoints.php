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
                CASE WHEN w.waypoint_visibility = 'VW' THEN w.latitude
                     WHEN w.waypoint_visibility = 'HC' AND p.post_type != 'BON' AND lo.moment IS NOT NULL THEN w.latitude
                     WHEN w.waypoint_visibility = 'HC' AND p.post_type  = 'BON' AND lb.moment IS NOT NULL THEN w.latitude
                     WHEN w.waypoint_visibility = 'HW' AND p.post_type != 'BON' AND lo.moment IS NOT NULL THEN w.latitude
                     WHEN w.waypoint_visibility = 'HW' AND p.post_type  = 'BON' AND lb.moment IS NOT NULL THEN w.latitude
                     ELSE NULL END AS latitude,
                CASE WHEN w.waypoint_visibility = 'VW' THEN w.longitude
                     WHEN w.waypoint_visibility = 'HC' AND p.post_type != 'BON' AND lo.moment IS NOT NULL THEN w.longitude
                     WHEN w.waypoint_visibility = 'HC' AND p.post_Type  = 'BON' AND lb.moment IS NOT NULL THEN w.longitude
                     WHEN w.waypoint_visibility = 'HW' AND p.post_type != 'BON' AND lo.moment IS NOT NULL THEN w.longitude
                     WHEN w.waypoint_visibility = 'HW' AND p.post_type  = 'BON' AND lb.moment IS NOT NULL THEN w.longitude
                     ELSE NULL END AS longitude
                %else
                CASE waypoint_visibility WHEN 'VW' THEN w.latitude  ELSE NULL END AS latitude,
                CASE waypoint_visibility WHEN 'VW' THEN w.longitude ELSE NULL END AS longitude
                %end
             FROM waypoints w
             JOIN waypoint_types wt USING (waypoint_type)
             JOIN waypoint_visibilities wv USING (waypoint_visibility)
             JOIN posts p USING (post)
             %if", isset($team), "
             LEFT JOIN (
                SELECT post, moment
                FROM logs
                WHERE log_type = 'OUT'
                  AND team = %i", $team, "
             ) lo USING (post)
             LEFT JOIN (
                SELECT post, moment
                FROM logs
                WHERE log_type = 'BON'
                  AND team = %i", $team, "
             ) lb USING (post)
             %end
             %if", !empty($filter), " WHERE %and", $filter, "%end
             %if", !empty($orders), " ORDER BY %by", $order, "%end
             %if", !empty($limit),  " LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        ); // query()
    } // view()

    public function insert(array $values)
    {
        if (empty($values)) throw new \Exception('Missing values for waypoint insert.');
        self::checkType($values['waypoint_type']);
        self::checkVisibility($values['waypoint_visibility']);

        return $this->db->query(
            "INSERT INTO waypoints %v", $values,
            "RETURNING waypoint"
        )->fetchSingle('waypoint');
    } // insert()

    public function update(array $values, array $filter)
    {
        if (empty($filter)) throw new \Exception('Missing filter for waypoint update.');
        self::checkType($values['waypoint_type']);
        self::checkVisibility($values['waypoint_visibility']);

        return $this->db->query(
            "UPDATE waypoints
             SET %a", $values,
            "WHERE %and", $filter
        ); // query()
    } // update()

    public function delete(array $filter)
    {
        if (empty($filter)) throw new \Exception('Missing filter for waypoint delete.');

        return $this->db->query(
            "DELETE FROM waypoints
             WHERE %and", $filter
        ); // query()
    } // delete()

    public static function checkType($value)
    {
        $validTypes = [
            self::FINALE,
            self::STAGE,
            self::REFERENCE,
            self::PARKING,
            self::WAYPOINT
        ];

        $value = strtoupper($value);
        if (!in_array($value, $validTypes)) {
            throw new \Exception(sprintf('Invalid waypoint type %s.', $value));
        } // if
    } // checkType()

    public static function checkVisibility($value)
    {
        $validVisibilities = [
            self::VISIBLE,
            self::HIDDEN_COORDINATES,
            self::HIDDEN
        ];

        $value = strtoupper($value);
        if (!in_array($value, $validVisibilities)) {
            throw new \Exception(sprintf('Invalid waypoint visibility %s.', $value));
        } // if
    } // checkVisibility()

} // Waypoints
