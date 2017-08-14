<?php

namespace Brazda\Models;


class Positions extends Base
{
    public function view(array $filter = [], array $order = [ 'team' => 'ASC', 'moment' => 'ASC' ], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->noramlizeLimit($limit);
        list($limit, $offset) = each($limit);

        return $this->db->query(
            "SELECT *
             FROM positions
             %if", !empty($filter), "WHERE %and", $filter, "%end
             %if", !empty($order), "ORDER BY %by", $order, "%end
             %if", !empty($limit), "LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        ); // query()
    } // view()

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

    public function insert(array $values)
    {
        $team = (int) $values['team'];
        $moment = is_numeric($values['moment'])
            ? (int) $values['moment']
            : strtotime($values['moment']);
        $latitude = (float) $values['latitude'];
        $longitude = (float) $values['longitude'];

        $record = [
            'team'      => $team,
            'device_id' => $values['device_id'],
            'moment'    => $moment,
            'location'  => "({$latitude}, {$longitude})"
        ];

        return $this->db->query(
            "INSERT INTO positions %v", $record,
            "RETURNING position"
        )->fetchSingle('position');
    } // insert()

} // Positions
