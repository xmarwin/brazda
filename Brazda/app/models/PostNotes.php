<?php

namespace Brazda\Models;

use Nette;

class PostNotes extends Base
{
    public function find(array $filter = [])
    {
        return $this->db->query(
            "SELECT *
             FROM post_notes
             WHERE %and", $filter
        )->fetch();
    } // find()

    public function insert(array $values)
    {
        if (empty($values)) throw new \Exception('Chybí hodnoty pro zápis poznámky.');

        return $this->db->query(
            "INSERT INTO post_notes %v", $values,
            "RETURNING post_note"
        )->fetchSingle('post_note');
    } // insert()

    public function update(array $values, array $filter)
    {
        if (empty($values)) throw new \Exception('Chybí hodnoty pro úpravy poznámky.');

        return $this->db->query(
            "UPDATE post_notes
             SET %a", $values,
            "WHERE %and", $filter
        ); // query()
    } // update()

    public function delete(array $filter)
    {
        if (empty($filter)) throw new \Exception('Chybí specifikace poznámky pro smazání.');

        return $this->db->query(
            "DELETE FROM post_notes
             WHERE %and", $filter
        ); // query()
    } // delete()

} // PostNotes
