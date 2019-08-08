<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class PostAttributes extends Base
{
    public function view(array $filter = [], array $order = [], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        $limit  = $limit['limit'];
        $offset = $limit['offset'];

        return $this->db->query(
            "SELECT
                *
             FROM posts_has_attributes_view
             WHERE %and", $filter,
            "%if", !empty($order), " ORDER BY %by", $order, "%end",
            "%if", !empty($limit), " LIMIT %lmt", $limit, " OFFSET %ofs", $offset, "%end"
        ); // query()
    } // view()

    public function viewAll(array $filter = [], array $order = [], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        $limit  = $limit['limit'];
        $offset = $limit['offset'];

        return $this->db->query(
            "SELECT
                *
             FROM posts_has_attributes_all_view
             WHERE %and", $filter,
            "%if", !empty($order), " ORDER BY %by", $order, "%end",
            "%if", !empty($limit), " LIMIT %lmt", $limit, " OFFSET %ofs", $offset, "%end"
        ); // query()
    } // viewAll()

    public function save(array $values)
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro změnu atributu stanoviště');

        $postAttribute = $this->db->query(
            "SELECT *
             FROM posts_has_attributes
             WHERE %and", [ 'post' => $values['post'], 'attribute' => $values['attribute'] ],
            "LIMIT 1"
        )->fetch();

        if (!empty($postAttribute) && $values['status'] == null) {
            $this->delete([
                'post'      => $values['post'],
                'attribute' => $values['attribute']
            ]); // delete()
        } elseif (!empty($postAttribute) && $values['status'] !== false) {
            $this->update([
                'status'    => $values['status'],
            ], [
                'post'      => $values['post'],
                'attribute' => $values['attribute']
            ]); // update()
        } elseif (empty($postAttribute)) {
            $this->insert($values);
        } // if
    } // save()

    public function insert(array $values)
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro zápis atributu stanoviště');

        return $this->db->query(
            "INSERT INTO posts_has_attributes (post, `attribute`, status)
             VALUES %v", $values
        ); // query()
    } // insert()

    public function update(array $values, array $filter = [])
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro úpravu atributu stanoviště');

        $filter = $this->normalizeFilter($filter);

        return $this->db->query(
            "UPDATE posts_has_attributes
             SET %a", $values,
            "WHERE %and", $filter
        ); // query()

    } // update()

    public function delete(array $filter)
    {
        if (empty($filter))
            throw new \Exception('Chybí specifikace attributu stanoviště pro smazání.');

        $filter = $this->normalizeFilter($filter);

        return $this->db->query(
            "DELETE FROM posts_has_attributes",
            "WHERE %and", $filter
        ); // query()
    } // delete()

} // PostAttributes
