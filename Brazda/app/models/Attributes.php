<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Attributes extends Base
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
             FROM `attributes_view`
             WHERE %and", $filter,
            "%if", !empty($order), " ORDER BY %by", $order, "%end
             %if", !empty($limit), " LIMIT %lmt", $limit, " %ofs", $offset, "%end"
        ); // query()
    } // view()

} // Attributes
