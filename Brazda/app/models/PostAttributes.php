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
        list($limit, $offset) = each($limit);

        return $this->db->query(
            "SELECT
                *
             FROM post_attributes_view
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
        list($limit, $offset) = each($limit);

        return $this->db->query(
            "SELECT
                *
             FROM post_attributes_all_view
             WHERE %and", $filter,
            "%if", !empty($order), " ORDER BY %by", $order, "%end",
            "%if", !empty($limit), " LIMIT %lmt", $limit, " OFFSET %ofs", $offset, "%end"
        ); // query()
    } // viewAll()

} // PostAttributes
