<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Posts extends Base
{
    const BEGIN = 'BEG';
    const END = 'END';
    const ORGANIZATION = 'ORG';
    const ACTIVITY = 'ACT';
    const CIPHER = 'CIP';
    const CACHE = 'CGC';
    const BONUS = 'BON';

    const MICRO = 'M';
    const SMALL = 'S';
    const REGULAR = 'R';
    const LARGE = 'L';
    const OTHER = 'O';

    const TRADITIONAL = 'TRA';
    const MULTICACHE = 'MLT';
    const MYSTERY = 'MYS';
    const EARTHCACHE = 'ERT';
    const WHEREIGO = 'WIG';

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
                CASE lh.moment WHEN NULL THEN p.hint ELSE NULL END AS hint,
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
                lh.moment AS log_help_moment, %end
                CASE WHEN (p.post_type = 'BON' AND lb.moment IS NOT NULL) OR (lo.moment IS NOT NULL) THEN TRUE ELSE FALSE END AS is_done
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
/*
    public function overview($team, $postType = null)
    {
        $team = (int) $team;

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
                p.description,
                p.cache_type,
                p.max_score,
                p.open_from,
                p.open_to,
                pc.name AS color_name,
                pc.code AS color_code,
                pt.name AS type_name,
                ps.name AS size_name,
                ct.name AS cache_name,
                ll.moment AS log_out_moment,
                lb.moment AS log_bonus_moment
            FROM posts p
            JOIN post_colors pc USING (color)
            JOIN post_types pt USING (post_type)
            JOIN post_sizes ps USING (size)
            LEFT JOIN cache_types ct USING (cache_type)
            LEFT JOIN logs AS ll
                ON ll.post = p.post AND (ll.log_type = 'OUT') AND ll.team = %i
            LEFT JOIN logs AS lb
                ON l.post = p.post AND (lb.log_type = 'BON') AND lb.team = %i", $team,
           "ORDER BY is_logged, p.post_type, p.color, l.moment, p.name"
        )->fetchAll();
    } // overview()
*/
    public function detail($post)
    {
        $post = (int) $post;

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
                p.description,
                p.max_score,
                p.open_from,
                p.open_to,
                (p.help <> '') AS have_help,
                pc.name AS color_name,
                pc.code AS color_code,
                pt.name AS type_name,
                ps.name AS size_name
              FROM posts p
              JOIN post_colors pc USING (color)
              JOIN post_types pt USING (post_type)
              JOIN post_sizes ps USING (size)
             WHERE p.post = %i", $post
        )->fetch();
    } // detail()

    public function getHelp($post)
    {
        $post = (int) $post;

        return $this->db->query(
            "SELECT p.help
             FROM posts p
            WHERE p.post = %i", $post
        )->fetchSingle('help');
    } // getHelp()

    public function bonusOverview($team)
    {
        $team = (int) $team;

        return $this->db->query(
            "SELECT
                p.post,
                p.post_type,
                p.name,
                p.shibboleth,
                p.bonus_code,
                p.color,
                pc.name AS color_name,
                pc.code AS color_code,
                l.log_type,
                bp.post AS bonus_post,
                bp.name AS bonus_name,
                bp.color AS bonus_color
             FROM posts p
             JOIN post_colors pc USING (color)
             JOIN logs l USING (post)
             JOIN (
                 SELECT p.post, p.name, p.color
                 FROM posts p
                 WHERE post_type = 'BON'
             ) bp USING (color)
             WHERE l.team = %i", $team,
              "AND (l.log_type = 'OUT' OR l.log_type = 'BON')",
            "ORDER BY p.color, l.moment ASC"
        )->fetchAssoc('color,#');
    } // bonusOverview()

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

    public function getWaypoints($post = 0)
    {
        return $this->context
            ->getService('waypoints')
            ->overview($post);
    }

    public function findByType($postType)
    {
		return $this->db->query(
			"SELECT *
			 FROM posts
			 WHERE post_type LIKE %s", $postType
		); // query()
    } // findByType()

} // Posts
