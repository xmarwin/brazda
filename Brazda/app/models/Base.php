<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Base extends Nette\Object
{
    protected
        $context,
        $db;

    public function __construct(DI\Container $context)
    {
        $this->context = $context;
        $this->db      = $this->context->getService('database');
    } // __construct()

    public function begin($savepoint = null)
    {
        $this->db->begin($savepoint);
    } // begin()

    public function commit($savepoint = null)
    {
        $this->db->commit($savepoint);
    } // commit()

    public function rollback($savepoint = null)
    {
        $this->db->rollback($savepoint);
    } // rollback()

    public function isInTransaction()
    {
        return $this->inTransaction;
    } // isInTransaction()

    protected function normalizeFilter(array $filter)
    {
        return $filter;
    } // normalizeFilter()

    protected function normalizeOrder(array $order)
    {
        foreach ($order as $key => $value) {
            if (!$this->isAssoc($order)) {
                $order[$value] = 'ASC';
                unset($order[$key]);
            } // if
            if (empty($value)) {
                $value[$value] = 'ASC';
            } // if

            $value = strtoupper($value);

            if (!in_array($value, ['ASC', 'DESC'])) {
                $order[$value] = 'ASC';
            } // if
        } // foreach

        return $order;
    } // normalizeOrder()

    protected function normalizeLimit(array $limit)
    {
        if (!$this->isAssoc($limit)) {
            list($limit['limit'], $limit['offset']) = each($limit);
            unset($limit[0], $limit[1]);
        } // if

        return $limit;
    } // normalizeLimit()

    private function isAssoc(array $arr)
    {
        if (array() === $arr) return true;

        return array_keys($arr) !== range(0, count($arr) - 1);
    } // isAssoc

} // Base
