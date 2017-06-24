<?php

namespace Brazda\Models;

use Nette;

class Results extends Base
{
    public function overview()
    {
        return $this->db->query(
            "SELECT *
             FROM results
             ORDER BY score DESC"
        )->fetchAll();
    }
}
