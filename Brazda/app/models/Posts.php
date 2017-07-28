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

    public function find($post)
    {
        $post = (int) $post;

        return $this->db->query(
            "SELECT *
             FROM posts
             WHERE post = %i", $post
        )->fetch();
    }

    public function view(array $filter = [], array $order = [ 'post_type' => 'ASC', 'color' => 'ASC', 'name' => 'ASC' ], array $limit = []) {

		$filter = $this->normalizeFilter($filter);
		$order  = $this->normalizeOrder($order);
		$limit  = $this->normalizeLimit($limit);
		list($limit, $offset) = each($limit);

		if (isset($filter['team']) && !empty($filter['team'])) {
            $team = (int) $filter['team'];
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
                p.size,
                p.hint,
                CASE WHEN p.help NOT LIKE '' THEN TRUE ELSE FALSE END AS has_help,
                %if", isset($team), "
                CASE WHEN (lo.moment IS NOT NULL AND p.post_type != 'BON') THEN p.shibboleth
                     WHEN (lo.moment IS NOT NULL AND p.post_type = 'BON') THEN p.bonus_code
                ELSE NULL END AS shibboleth,
                CASE WHEN lh.moment IS NOT NULL THEN p.help ELSE NULL END AS help,
                %end
                p.description,
                p.cache_type,
                p.max_score,
                p.open_from,
                p.open_to,
                p.latitude,
                p.longitude,
                pc.name AS color_name,
                pc.code AS color_code,
                pt.name AS type_name,
                ps.name AS size_name,
                ct.name AS cache_name %if,", isset($team), "
                lo.moment AS log_out_moment,
                lb.moment AS log_bonus_moment,
                lh.moment AS log_help_moment,
                CASE WHEN lb.moment IS NOT NULL THEN TRUE ELSE FALSE END as is_unlocked,
                CASE WHEN lo.moment IS NOT NULL THEN TRUE ELSE FALSE END AS is_done
                %end
             FROM posts p
             JOIN post_colors pc USING (color)
             JOIN post_types pt USING (post_type)
             JOIN post_sizes ps USING (size)
             LEFT JOIN cache_types ct USING (cache_type)
             %if", isset($team), "
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
        if (empty($values)) throw new \Exception('Missing values for post insert.');
        self::checkType($values['post_type']);
        self::checkColor($values['color']);
        self::checkTerrain($values['terrain']);
        self::checkDifficulty($values['difficulty']);
        self::checkCacheSize($values['size']);
        self::checkCacheType($values['cache_type']);

        return $this->db->query(
            "INSERT INTO posts %v", $values,
            "RETURNING post"
        )->fetchSingle('post');
    } // insert()

    public function update(array $values, array $filter)
    {
        if (empty($filter)) throw new \Exception('Missing filter for post update.');
        self::checkType($values['post_type']);
        self::checkColor($values['color']);
        self::checkTerrain($values['terrain']);
        self::checkDifficulty($values['difficulty']);
        self::checkCacheSize($values['size']);
        self::checkCacheType($values['cache_type']);

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

    public static function checkType($value)
    {
        $validTypes = [
            self::BEGIN,
            self::END,
            self::ORGANIZATION,
            self::ACTIVITY,
            self::CIPHER,
            self::CACHE,
            self::BONUS
        ];

        $value = strtoupper($value);
        if (!in_array($value, $validTypes)) {
            throw new \Exception(sprintf('Invalid post type %s.', $value));
        } // if
    } // checkType()

    public static function checkColor($value)
    {
        $validColors = [
            self::TRANSPARENT,
            self::RED,
            self::YELLOW,
            self::GREEN,
            self::BLUE,
            self::VIOLET
        ];

        $value = strtoupper($value);
        if (!in_array($value, $validColors)) {
            throw new \Exception(sprintf('Invalid post color %s.', $value));
        } // if
    } // checkColor()

    public static function checkCacheSize($value)
    {
        $validCacheSizes = [
            '',
            self::MICRO,
            self::SMALL,
            self::REGULAR,
            self::LARGE,
            self::OTHER
        ];

        $value = strtoupper($value);
        if (!in_array($value, $validCacheSizes)) {
            throw new \Exception(sprintf('Invalid cache size %s.', $value));
        } // if
    } // checkCacheSize()

    public static function checkCacheType($value)
    {
        $validCacheTypes = [
            '',
            self::TRADITIONAL,
            self::MULTICACHE,
            self::MYSTERY,
            self::EARTHCACHE,
            self::WHEREIGO
        ];

        $value = strtoupper($value);
        if (!in_array($value, $validCacheTypes)) {
            throw new \Exception(sprintf('Invalid cache type %s.', $value));
        } // if
    } // checkCacheType()

    public static function checkTerrain($value)
    {
        $validTerrains = [ 1, 1.5, 2,  2.5, 3, 3.5, 4, 4.5, 5 ];

        $value = floatval($value);
        if (!in_array($value, $validTerrains)) {
            throw new \Exception(sprintf('Invalid post terrain %f.', $value));
        } // if
    } // checkTerrain()

    public static function checkDifficulty($value)
    {
        $value = floatval($value);
        $validDifficulties = [ 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5 ];

        if (!in_array($value, $validDifficulties)) {
            throw new \Exception(sprintf('Invalid post difficulty %f.', $value));
        } // if
    } // checkDifficulty()

} // Posts
