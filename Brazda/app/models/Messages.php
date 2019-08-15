<?php

namespace Brazda\Models;

class Messages extends Base
{
    public function show($team, $message = null)
    {
        if (!empty($message)) {
            $result = $this->db->query(
                'SELECT *
                 FROM messages
                 WHERE message = %i', $message
            )->fetch();
        } else {
            $result = $this->db->query(
                'SELECT *
                 FROM messages
                 WHERE message NOT IN (
                    SELECT message
                    FROM teams_has_messages
                    WHERE team = %i', $team,
                ") ORDER BY moment
                 LIMIT 1"
            )->fetch();
        } // if

        $record = [
            'team'    => $team,
            'message' => $message
        ];

        $this->db->query(
            'INSERT INTO teams_has_messages
             %v', $record,
            'ON CONFLICT (team, message) DO NOTHING'
        ); // query()

        return $result;
    } // show()

    public function enumeration($team, $all = false)
    {
        if ($all) {
            $results = $this->db->query(
                "SELECT *
                 FROM messages
                 ORDER BY message"
            )->fetchAll();
        } else {
            $results = $this->db->query(
                'SELECT *
                 FROM messages
                 WHERE message NOT IN (
                    SELECT message
                    FROM teams_has_messages
                    WHERE team = %i', $team,
                ') ORDER BY message'
            )->fetchAll();
        } // if

        if (!empty($results)) {
            $records = [
                'team'    => [],
                'message' => []
            ];
            foreach ($results as $result) {
                $records['team'][] = $team;
                $records['message'][] = $result->message;
            } // foreach

            $this->db->query(
                "INSERT INTO teams_has_messages %m", $records,
                "ON CONFLICT (team, message) DO NOTHING"
            ); // query()
        } // if

        return $results;
    } // enumeration()

    public function count($team, $all = false)
    {
        return $all
            ? $this->db->query(
                'SELECT count(*) AS count
                 FROM messages'
              )->fetchSingle('count')
            : $this->db->query(
                'SELECT count(*) AS count
                 FROM messages
                 WHERE message NOT IN (
                    SELECT message
                    FROM teams_has_messages
                    WHERE team = %i', $team,
                ');'
              )->fetchSingle('count');
    } // count()

    public function find(array $filter)
    {
        $filter = $this->normalizeFilter($filter);

        return $this->db->query(
            'SELECT *
             FROM messages
             WHERE %and', $filter,
            'LIMIT 1'
        )->fetch();
    } // find()

    public function view(array $filter = [], array $order = [], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        $limit  = $limit['limit'];
        $offset = $limit['offset'];

        return $this->db->query(
            "SELECT *
             FROM messages
             WHERE TRUE
             %if", !empty($filter), "AND %and", $filter, "%end
             %if", !empty($order), "ORDER BY %by", $order, "%end
             %if", !empty($limit), "LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        )->fetchAll();
    } // view()

    public function insert(array $values)
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro zápis zprávy.');

        return $this->db->query(
            "INSERT INTO messages %v", $values,
            "RETURNING message"
        )->fetchSingle('message');
    } // insert()

} // Messages
