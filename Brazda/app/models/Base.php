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

    protected function normalizeFilter(array $filter, array $map = [])
    {
        if (empty($map)) return $filter;

        $newFilter = [];
        foreach ($filter as $key => $value) {
            if (!array_key_exists($key, $map)) {
                $newFilter[$key] = $value;
                continue;
            } // if

            $newKey = $map[$key];
            $newFilter[$newKey] = $value;
        } // foreach

        return $newFilter;
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

    protected function prepareFloat($value)
    {
        if (is_string($value))
            $value = str_replace(',', '.', $value);

        return (float) $value;
    } // prepareFloat()

    protected function prepareBoolean($value)
    {
        if (is_string($value)) {
            $value = strtoupper($value);
            switch ($value) {
                case 'ON':
                case 'T':
                case 'TRUE':
                    $value = 1;
                    break;

                case 'OFF':
                case 'F':
                case 'FALSE':
                    $value = 0;
                    break;
            } // switch
        } // if

        return (bool) $value;
    } // prepareBoolean()

    private function isAssoc(array $arr)
    {
        if (array() === $arr) return true;

        return array_keys($arr) !== range(0, count($arr) - 1);
    } // isAssoc

} // Base
