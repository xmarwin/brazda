<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Posts extends Base
{
    const BEGIN        = 'BEG';
    const END          = 'END';
    const ORGANIZATION = 'ORG';
    const ACTIVITY     = 'ACT';
    const CIPHER       = 'CIP';
    const CACHE        = 'CGC';
    const BONUS        = 'BON';

    const MICRO   = 'M';
    const SMALL   = 'S';
    const REGULAR = 'R';
    const LARGE   = 'L';
    const OTHER   = 'O';

    const TRADITIONAL = 'TRA';
    const MULTICACHE  = 'MLT';
    const MYSTERY     = 'MYS';
    const EARTHCACHE  = 'ERT';
    const WHEREIGO    = 'WIG';

    const TRANSPARENT = 'TRA';
    const RED         = 'RED';
    const YELLOW      = 'YEL';
    const GREEN       = 'GRN';
    const BLUE        = 'BLU';
    const VIOLET      = 'VLT';

    protected
        $teams;

    public function __construct(DI\Container $container)
    {
        parent::__construct($container);

        $this->teams = $this->context->getService('teams');
    } // __construct()

    public function find($post)
    {
        $post = (int) $post;

        return $this->db->query(
            "SELECT *
             FROM posts
             WHERE post = %i", $post
        )->fetch();
    } // find()

    public function view(array $filter = [], array $order = [ 'post_type' => 'ASC', 'color' => 'ASC', 'name' => 'ASC' ], array $limit = []) {

        $filter = $this->normalizeFilter($filter);
        $order  = $this->normalizeOrder($order);
        $limit  = $this->normalizeLimit($limit);
        list($limit, $offset) = each($limit);

        if (isset($filter['team']) && !empty($filter['team'])) {
            $team = (int) $filter['team'];

            $role = $this->teams->find(['team' => $team])->role;

            unset($filter['team']);
        } // if

        return $this->db->query(
            "SELECT
                p.post,
                p.post_type,
                p.color,
                p.name,
                p.difficulty,
                p.terrain,
                p.cache_size,
                cs.name AS size_name,
                p.description,
                p.cache_type,
                ct.name AS cache_name,
                p.hint,
                CASE WHEN p.help NOT LIKE '' THEN TRUE ELSE FALSE END AS has_help,
                %if", isset($team) && $role == Teams::COMPETITORS, "
                CASE WHEN lo.moment IS NOT NULL THEN p.shibboleth ELSE NULL END AS shibboleth,
                CASE WHEN lb.moment IS NOT NULL THEN p.bonus_code ELSE NULL END AS bonus_code,
                CASE WHEN lh.moment IS NOT NULL THEN p.help ELSE NULL END AS help,
                %else
                p.shibboleth,
                p.bonus_code,
                p.help,
                %end
                p.max_score,
                p.with_staff,
                to_char(p.open_from, 'HH24:MI') AS open_from,
                to_char(p.open_to, 'HH24:MI') AS open_to,
                p.latitude,
                p.longitude,
                pc.name AS color_name,
                pc.code AS color_code,
                pt.name AS type_name
                %if,", isset($team) && $role == Teams::COMPETITORS, "
                lo.moment AS log_out_moment,
                lb.moment AS log_bonus_moment,
                lh.moment AS log_help_moment,
                CASE WHEN lb.moment IS NOT NULL THEN TRUE ELSE FALSE END as is_unlocked,
                CASE WHEN lo.moment IS NOT NULL THEN TRUE ELSE FALSE END AS is_done
                %end
             FROM posts p
             JOIN post_colors pc USING (color)
             JOIN post_types pt USING (post_type)
             LEFT JOIN cache_sizes cs USING (cache_size)
             LEFT JOIN cache_types ct USING (cache_type)
             %if", isset($team) && $role == Teams::COMPETITORS, "
             LEFT JOIN (
                SELECT post, moment
                FROM logs
                WHERE log_type = 'OUT'
                  AND team = %i", $team, "
             ) lo USING (post)
             LEFT JOIN (
                SELECT post, moment
                FROM logs
                WHERE log_type = 'BON'
                  AND team = %i", $team, "
             ) lb USING (post)
             LEFT JOIN (
                SELECT post, moment
                FROM logs
                WHERE log_type = 'HLP'
                  AND team = %i", $team, "
             ) lh USING (post)
             %end
             %if", !empty($filter), "WHERE %and", $filter, "%end",
            "%if", !empty($order), " ORDER BY %by", $order, " %end",
            "%if", !empty($limit), " LIMIT %lmt", $limit, " %ofs", $offset
        );
    } // view()

    public function getHelp($post)
    {
        $post = (int) $post;

        return $this->db->query(
            "SELECT p.help
             FROM posts p
            WHERE p.post = %i", $post
        )->fetchSingle('help');
    } // getHelp()

    public function getShibboleth($post)
    {
        $post = (int) $post;

        return $this->db->query(
            "SELECT shibboleth
             FROM posts
             WHERE post = %i", $post
        )->fetchSingle('shibboleth');
    } // getShibboleth()

    public function getBonusCode($post)
    {
        $post = (int) $post;

        return $this->db->query(
            "SELECT bonus_code
             FROM posts
             WHERE post = %i", $post
        )->fetchSingle('bonus_code');
    } // getBonusCode()

    public function insert(array $values)
    {
        if (empty($values))
            throw new \Exception('Missing values for post insert.');

        if (isset($values['cache_type']) && !empty($values['cacheType']))
            $this->checkCacheType($values['cache_type']);

        if (isset($values['cache_size']) && !empty($values['cacheSize']))
            $this->checkCacheSize($values['cache_size']);

        $this->checkType($values['post_type']);
        $this->checkColor($values['color']);
        $this->checkTerrain($values['terrain']);
        $this->checkDifficulty($values['difficulty']);

        $values['difficulty'] = $this->prepareFloat($values['difficulty']);
        $values['terrain']    = $this->prepareFloat($values['terrain']);

        if (isset($values['with_staff']) && !empty($values['with_staff']))
            $values['with_staff'] = $this->prepareBoolean($values['with_staff']);

        return $this->db->query(
            "INSERT INTO posts %v", $values,
            "RETURNING post"
        )->fetchSingle('post');
    } // insert()

    public function update(array $values, array $filter)
    {
        if (empty($filter))
            throw new \Exception('Missing filter for post update.');

        if (isset($values['cache_type']) && !empty($values['cacheType']))
            $this->checkCacheType($values['cache_type']);

        if (isset($values['cache_size']) && !empty($values['cacheSize']))
            $this->checkCacheSize($values['cache_size']);

        $this->checkType($values['post_type']);
        $this->checkColor($values['color']);
        $this->checkTerrain($values['terrain']);
        $this->checkDifficulty($values['difficulty']);

        $values['difficulty'] = $this->prepareFloat($values['difficulty']);
        $values['terrain']    = $this->prepareFloat($values['terrain']);

        if (isset($values['with_staff']) && !empty($values['with_staff']))
            $values['with_staff'] = $this->prepareBoolean($values['with_staff']);

        return $this->db->query(
            "UPDATE posts
             SET %a", $values,
            "WHERE %and", $filter
        ); // query()
    } // update()

    public function delete(array $filter)
    {
        if (empty($filter)) throw new \Exception('Missing filter for post delete.');

        return $this->db->query(
            "DELETE FROM posts
             WHERE %and", $filter
        ); // query()
    } // delete()

    public function getTypes()
    {
        return $this->db->query(
            "SELECT *
             FROM post_types
             ORDER BY name"
        )->fetchPairs('post_type', 'name');
    } // getTypes()

    public function checkType($value)
    {
        $validTypes = array_keys($this->getTypes());

        $value = strtoupper($value);
        if (!in_array($value, $validTypes)) {
            throw new \Exception(sprintf('Invalid post type %s.', $value));
        } // if
    } // checkType()

    public function getColors()
    {
        return $this->db->query(
            "SELECT *
             FROM post_colors
             ORDER BY name"
        )->fetchPairs('color', 'name');
    } // getColors()

    public function checkColor($value)
    {
        $validColors = array_keys($this->getColors());

        $value = strtoupper($value);
        if (!in_array($value, $validColors)) {
            throw new \Exception(sprintf('Invalid post color %s.', $value));
        } // if
    } // checkColor()

    public function getCacheSizes()
    {
        return $this->db->query(
            "SELECT *
             FROM cache_sizes
             ORDER BY name"
        )->fetchPairs('cache_size', 'name');
    } // getCacheSizes()

    public function checkCacheSize($value)
    {
        $validCacheSizes = array_keys($this->getCacheSizes());
        $validCacheSizes[''] = '';

        $value = strtoupper($value);
        if (!in_array($value, $validCacheSizes)) {
            throw new \Exception(sprintf('Invalid cache size %s.', $value));
        } // if
    } // checkCacheSize()

    public function getCacheTypes()
    {
        return $this->db->query(
            "SELECT *
             FROM cache_types
             ORDER BY name"
        )->fetchPairs('cache_type', 'name');
    } // getCacheTypes()

    public function checkCacheType($value)
    {
        $validCacheTypes = array_keys($this->getCacheTypes());
        $validCacheTypes[''] = '';

        $value = strtoupper($value);
        if (!in_array($value, $validCacheTypes)) {
            throw new \Exception(sprintf('Invalid cache type %s.', $value));
        } // if
    } // checkCacheType()

    public function getTerrains()
    {
        return [ 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5 ];
    } // getTerrains()

    public function checkTerrain($value)
    {
        $validTerrains = $this->getTerrains();

        $value = floatval($value);
        if (!in_array($value, $validTerrains)) {
            throw new \Exception(sprintf('Invalid post terrain %0.1f.', $value));
        } // if
    } // checkTerrain()

    public function getDifficulties()
    {
        return [ 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5 ];
    } // getDifficulties()

    public function checkDifficulty($value)
    {
        $validDifficulties = $this->getDifficulties();

        $value = floatval($value);
        if (!in_array($value, $validDifficulties)) {
            throw new \Exception(sprintf('Invalid post difficulty %0.1f.', $value));
        } // if
    } // checkDifficulty()

} // Posts
