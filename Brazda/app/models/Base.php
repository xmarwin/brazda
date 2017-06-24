<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Base extends Nette\Object
{
    protected
        $context,
        $db;

    public function __construct(DI\Container $context) {

        $this->context = $context;
        $this->db      = $this->context->getService('database');
    } // __construct()

    public function begin($savepoint = null) {

        $this->db->begin($savepoint);
    } // begin()

    public function commit($savepoint = null) {

        $this->db->commit($savepoint);
    } // commit()

    public function rollback($savepoint = null) {

        $this->db->rollback($savepoint);
    } // rollback()

    public function isInTransaction() {

        return $this->inTransaction;
    } // isInTransaction()

} // Base
