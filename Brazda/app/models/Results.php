<?php

namespace Brazda\Models;

use Nette,
    Nette\DI;

class Results extends Base
{
    protected
        $settings;

    public function __construct(DI\Container $context)
    {
    	parent::__construct($context);

	$this->settings = $this->context->getService('settings');
    } // __construct()

    public function overview()
    {
        return $this->db->query(
            "SELECT *
             FROM results
             ORDER BY score DESC"
        )->fetchAll();
    } // overview()

    public function postResultView(array $filter, array $order = [], array $limit = [])
    {
        $filter = $this->normalizeFilter($filter);
	$order  = $this->normalizeOrder($order);
	$limit  = $this->normalizeLimit($limit);
	$offset = $limit['offset'];
	$limit  = $limit['limit'];

	$settings = $this->settings->enumeration();

	return $this->db->query(
           "SELECT
	        s.log_type,
                s.team,
                t.team_type,
                s.post,
                s.moment,
                s.with_help,
                ROW_NUMBER() OVER ( ORDER BY penalized_moment ) AS [order],
                p.max_score,
                COALESCE(p.max_score, 0) - ((row_number() OVER (ORDER BY penalized_moment ) - 1) * %i::integer)", $settings['orderPenalization'], " AS score
	    FROM (
	        SELECT
                    l.log_type,
		    l.team,
		    l.post,
                    l.moment,
		    CASE WHEN with_help IS TRUE
		    THEN l.moment + %s::interval", $settings['helpPenalization'], "
		    ELSE l.moment END AS penalized_moment,
		    twh.with_help
		FROM logs l
		LEFT JOIN (
                    SELECT
		        team,
                        post,
                        TRUE AS with_help
		    FROM logs
		    WHERE log_type = 'HLP'
		) twh USING (team, post)
                WHERE log_type = 'OUT'
                ORDER BY moment
	    ) s
	    JOIN posts p USING (post)
	    JOIN teams t USING (team)
	    WHERE t.is_active = true
	      AND t.is_disqualified = false
	      AND t.team_type != 'ORG'
	      AND %and", $filter,
	   "%if", !empty($order), "ORDER BY %by", $order, "%end",
	   "%if", !empty($limit), "LIMIT %lmt", $limit, " %ofs", $offset, "%end"
	)->fetchAll();
    } // postResultView()

    public function resultsView($teamType)
    {
	$settings = $this->settings->enumeration();

        // vybere stanoviste
    	$posts = $this->db->query(
            "SELECT post, name
             FROM posts
             WHERE post_type NOT IN ('BEG', 'END', 'ORG')
             ORDER BY post"
	)->fetchPairs('post', 'name');

        // vybereme tymy
	$teams = $this->db->query(
            "SELECT team, name
             FROM teams
             WHERE team_type = %s", $teamType,
            "ORDER BY team"
	)->fetchPairs('team', 'name');

	// pro kazde stanoviste pripravime vysledky pro dane typy tymu
	$postResults = [];
	$teamsResult = [];
        foreach ($posts as $post => $postName) {

            // vytvorime pole s vysledky tymu pro toto stanoviste inicializovanymi na null
            $teamResults = [];
            foreach ($teams as $team => $teamName) {
                $teamResults[$team] = null;
	    } // foreach

	    // vybereme bodove vysledky pro dane stanoviste a typy tymu
            $postResult = $this->postResultView([ 'post' => $post, 'team_type' => $teamType ]);

	    // pro kazdy existujici vysledek tymu 
	    foreach ($postResult as $postResultRow) {

	        // zapiseme skore k tomuto tymu 
                $teamResults[$postResultRow->team] = [
                    'score' => $postResultRow->score,
                    'time'  => date('c', strtotime($postResultRow->moment))
                ];

                // zalozime/pricteme k celkovemu skore
		if (isset($teamsResult[$postResultRow->team])) {
                    $teamsResult[$postResultRow->team] += $postResultRow->score;
                } else {
                    $teamsResult[$postResultRow->team] = $postResultRow->score;
                } // if
            } // foreach

	    // zapiseme vysledek tymu do seznamu vysledku stanovist
	    $postResults[$post] = $teamResults;
        } // foreach

	// zjistime, kdy startovaly jednotlive tymy
        $teamsStarts = $this->db->query(
            "SELECT team, moment
             FROM logs
             WHERE log_type = 'STR'"
        )->fetchPairs('team', 'moment');

        // nacteme cas zacatku zavodu pro dany typ tymu
        $raceStart = date('c', strtotime($settings['raceStart_'.$teamType]));

        // nacteme cas konce zavodu pro dany typ tymu
        $raceEnd = date('c', strtotime($settings['raceEnd_'.$teamType]));

	// vypocteme cas pro diskvalifikaci
        $disqualificationTime = date('c', strtotime($raceEnd.' + '.$settings['disqualificationTime']));

	// zjistime, kdy jednotlive tymy skoncily zavod
        $teamsEnds = $this->db->query(
            "SELECT team, moment
             FROM logs
             WHERE log_type = 'FIN'"
        )->fetchPairs('team', 'moment');

        // vybereme si diskvalifikace tymu
        $teamsDisqualification = $this->db->query(
            "SELECT team, is_disqualified
             FROM teams
             WHERE team_type NOT IN ('ORG')"
        )->fetchPairs('team', 'is_disqualified');

	// projdeme jednotlive vysledky tymu a sestavime finalni vysledky
        $teamResults = [];
        foreach ($teamsResult as $team => $teamResult) {

	    // zakladni struktura vysledku jednoho tymu
            $teamResult = [
                'name' => $teams[$team],
                'order' => null,
                'score' => [
                    'posts' => $teamsResult[$team],
                    'penalization' => 0,
		    'final' => $teamsResult[$team],
		    'disqualified' => $teamsDisqualification[$team]
                ],
                'time' => [
                    'start' => null,
                    'end' => null
                ],
		'posts' => []
            ];
           
	    // pokud zname cas zahajeni zavodu pro dany tym vyplnime jej
            if (!empty($teamsStarts[$team])) {
                $teamResult['time']['start'] = date('c', strtotime($teamsStarts[$team]));
            } // if

	    // pokud zname cas ukonceni zavodu pro dany tym vyplnime jej
            if (!empty($teamsEnds[$team])) {
                $teamResult['time']['end'] = $teamsEnds[$team]->format('c');
            } // if

            // vypocteme penalizacni cas pro tym   
            $penalizationTime = !empty($teamsEnds[$team])
                ? ceil(($teamsEnds[$team]->getTimestamp() - strtotime($raceEnd)) / 60)
                : 0;

            // pokud ma tym penalizaci
            if ($penalizationTime > 0) {
                // vypocteme pocet penalizacnich bodu
                $teamResult['score']['penalization'] = $penalizationTime * $settings['timePenalization'];
		// odecteme penalizovane body od celkoveho skore
                $teamResult['score']['final'] = $teamResult['score']['posts'] - $teamResult['score']['penalization'];
            } // if

            // pokud tym skoncil pozdeji nez je diskvalifikacni cas nebo byl tym diskvalifikovan
	    if (!empty($teamsEnds[$team])
	    && ($teamsDisqualification[$team]
	    ||  $teamsEnds[$team]->getTimestamp() >= strtotime($disqualificationTime))) {

                // nastavime mu priznak diskvalifikace
                $teamResult['score']['disqualified'] = true;
            } // if

            // projdeme vysledky jednotlivych stanovist pro dany tym
            foreach ($postResults as $post => $score) {
                // ulozime k identifikatoru a nazvu stanoviste i dosazene skore a cas zalogovani
                $teamResult['posts'][] = [
                    'post'  => $post,
                    'name'  => $posts[$post],
                    'score' => $score[$team]['score'],
                    'time'  => $score[$team]['time']
                ];
            } // if

            // vlozime vysledky tymu k ostatnim vysledkum
            $teamResults[$team] = $teamResult;
	} // foreach

	// seradime vysledky podle finalniho skore
        usort($teamResults, function ($item1, $item2) {

            return $item2['score']['final'] <=> $item1['score']['final'];
        }); // usort()

        // sestavime kompletni vysledky vcetne hlavicky zavodu a parametru zavodu
	$results = [
            'title' => $settings['raceTitle'],
            'category' => $teamType === 'KID'
                ? 'Dětská kategorie'
                : 'Dospělá kategorie',
	    'time'  => [
                'start' => $raceStart,
                'end'   => $raceEnd,
                'disqualification' => $disqualificationTime
            ],
	    'results' => []
	];

	// doplnime poradi k jednotlivym tymum
        foreach ($teamResults as $index => $teamResult) {
            $order = ++$index;
	    $teamResult['order'] = $order;
	    $results['results'][] = $teamResult;
        } // foreach

	// vvratime vysledky
        return $results;
    } // resultsView()

} // Results
