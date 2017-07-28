<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class PostTypes extends Base
{
    public function view(array $filter = [], array $order = [ 'post_type' => 'ASC' ], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        list($limit, $offset) = each($limit);

        return $this->db->query(
            "SELECT *
             FROM post_types
             %if", !empty($filter), "WHERE %and", $filter, "%end
             %if", !empty($order), "ORDER BY %by", $order, "%end
             %if", !empty($limit), "LIMIT %lmt, %ofs", $limit, $offset, "%end"
        ); // query()
    } // view()

} // PostTypes
