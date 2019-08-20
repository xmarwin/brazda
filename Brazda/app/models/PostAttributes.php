<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class PostAttributes extends Base
{
    public function find(array $filter)
    {
        $filter = $this->normalizeFilter($filter);

        return $this->db->query(
            "SELECT *
             FROM posts_has_attributes
             WHERE %and", $filter,
            "LIMIT 1"
        )->fetch();
    } // find()

    public function view(array $filter = [], array $order = [ 'code' => 'ASC' ], array $limit = [])
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

    public function viewAll(array $filter = [], array $order = [ 'code' => 'ASC' ], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        $limit  = $limit['limit'];
        $offset = $limit['offset'];

        return $this->db->query(
            "SELECT
                a.attribute,
                a.code,
                a.name_on,
                a.name_off,
                '/assets/images/attributes/' || a.icon || '.png' AS icon,
                '/assets/images/attributes/' || a.icon || '-yes.png' AS icon_on,
                CASE WHEN a.status_count = 3 THEN '/assets/images/attributes/' || a.icon || '-no.png' ELSE NULL END AS icon_off,
                a.status_count,
                a.code,
                pha.post,
                pha.status
             FROM attributes a
             LEFT JOIN (
                SELECT
                    attribute,
                    post,
                    status
                FROM posts_has_attributes
                WHERE %and", $filter,
            ") pha USING (attribute)",
            "%if", !empty($order), " ORDER BY %by", $order, "%end",
            "%if", !empty($limit), " LIMIT %lmt", $limit, " OFFSET %ofs", $offset, "%end"
        ); // query()
    } // viewAll()

    public function save(array $values)
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro změnu atributu stanoviště');

        $postAttribute = $this->find([ 'post' => $values['post'], 'attribute' => $values['attribute'] ]);

        if ($postAttribute !== false && $values['status'] === null) {
            $this->delete([
                'post'      => $values['post'],
                'attribute' => $values['attribute']
            ]); // delete()
        } elseif ($postAttribute !== false && $values['status'] !== null) {
            $this->update([
                'status'    => $values['status'],
            ], [
                'post'      => $values['post'],
                'attribute' => $values['attribute']
            ]); // update()
        } elseif ($postAttribute === false && $values['status'] !== null) {
            $this->insert($values);
        } // if
    } // save()

    public function insert(array $values)
    {
        if (empty($values))
            throw new \Exception('Chybí hodnoty pro zápis atributu stanoviště');

        return $this->db->query(
            "INSERT INTO posts_has_attributes
             %v", $values
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
