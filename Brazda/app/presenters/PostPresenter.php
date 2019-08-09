<?php

namespace Brazda\Presenters;

use Nette\Security,
    Brazda\Models,
    Dibi;

class PostPresenter extends SecuredBasePresenter
{
    use \Brazda\Encoding;

	protected
        $logs,
		$posts,
        $postAttributes,
		$postTypes,
		$waypoints;

	public function startup()
	{
		parent::startup();

		$this->logs           = $this->context->getService('logs');
		$this->posts          = $this->context->getService('posts');
		$this->postAttributes = $this->context->getService('postAttributes');
		$this->postTypes      = $this->context->getService('postTypes');
		$this->waypoints      = $this->context->getService('waypoints');
	} // startup()

	public function actionList(array $filter = [], array $order = [])
	{
        /** Vždy filtrujeme podle týmu */
		$viewFilter = [
			'team' => $this->team['team']
		];

		/** Pokud je nastaven filtr typu stanoviště nastavíme jej ve view */
		if (isset($filter['type']) && !empty($filter['type'])) {
			$types = explode(',', $filter['type']);
			$viewFilter[] = [ 'p.post_type IN %in', $types ];
		} // if

		/** Pokud je nastaven filtr barvy stanoviště, nastavíme jej ve view */
		if (isset($filter['color']) && !empty($filter['color'])) {
			$colors = explode(',', $filter['color']);
			$viewFilter[] = [ 'p.color IN %in', $colors ];
		} // if

		/** Pokud není nastaveno pořadí, nastavíme jej na rank, color, name */
		if (empty($order)) {
			$order = ['rank' => 'ASC', 'color' => 'ASC', 'name' => 'ASC'];
		} // if

		try {
            /** Vybereme data seznamu stanovišť */
			$this->resource = (array) $this->posts->listView($viewFilter, $order)->fetchAll();
			$rank = 0;

			/** Doplníme proměnnou rank pro přirozené řazení */
			foreach ($this->resource as $id => $post) {
				$this->resource[$id]['rank'] = $rank++;
			} // foreach
		} catch (Dibi\Exception $e) {
			$this->sendErrorResource($e);
		} // try

		/** Odešleme data */
		$this->sendResource();
	} // actionList()

	public function actionBonusList()
	{
		try {
			$viewBonusesFilter = [
				'team'      => $this->team['team'],
				[ 'post_type IN %in', [ Models\Posts::BONUS, Models\Posts::SUPERBONUS ] ]
			];
			$bonusPosts = $this->posts->view($viewBonusesFilter)->fetchAll();

			$viewPostsFilter = [
			    'team' => $this->team['team']
			];
			$allPosts = $this->posts->view($viewPostsFilter)->fetchAll();
			$this->resource = [];
			foreach ($bonusPosts as $bonusPost) {

			    $bonus = [
                    'post'        => $bonusPost->post,
                    'name'        => $bonusPost->name,
                    'is_unlocked' => $bonusPost->is_unlocked,
                    'is_done'     => $bonusPost->is_done,
                    'unlocked_moment'    => $bonusPost->log_bonus_moment,
                    'done_moment'        => $bonusPost->log_out_moment,
                    'password'           => $bonusPost->password,
                    'password_character' => $bonusPost->password_character,
                    'password_position'  => $bonusPost->password_position,
                    'time_estimate'      => $bonusPost->time_estimate,
                    'color'       => [
                        'name'    => $bonusPost->color_name,
                        'code'    => $bonusPost->color_code
                    ]
                ];
                if ($bonusPost->is_unlocked) {
                    $bonus['bonus_code'] = $bonusPost->bonus_code;
                } // if
                if ($bonusPost->is_done) {
                    $bonus['shibboleth'] = $bonusPost->shibboleth;
                } // if

                $this->resource[] = $bonus;
            } // foreach
        } catch (Dibi\Exception $e) {
            $this->sendErrorResource($e);
        } // try

        /** Odešleme data */
        $this->sendResource();
    } // actionBonusList()

    public function actionDetail($post)
    {
        try {
            /** Vybereme informace o stanovišti pro tým */
            $this->resource = (array) $this->posts->view([
                'team' => (int) $this->team['team'],
                'post' => (int) $post
            ])->fetch();

            /** Pokud je informace pro závodníky */
            if (in_array($this->team['role'], [ Models\Teams::COMPETITORS, Models\Teams::KIDSCOMPETITORS ])) {
                /** Vybereme informace o atributech stanoviště */
                $this->resource['attributes'] = $this->postAttributes->view([
                    'post' => (int) $post
                ])->fetchAll();

            /** jinak */
            } else {
                /** Vybereme informace o všech možných a nastavených atributech stanoviště */
                $this->resource['attributes'] = $this->postAttributes->viewAll([
                    'post' => (int) $post
                ])->fetchAll();
            } // if

			/** Vybereme informace o waypointech stanoviště pro tým */
			$this->resource['waypoints'] = $this->waypoints->view([
			    'post' => (int) $post,
			    'team' => (int) $this->team['team']
			])->fetchAll();

                /** Vybereme informací o lozích stanoviště pro tým */
			$this->resource['visits'] = $this->logs->view([
			    'post' => (int) $post,
			    'team' => (int) $this->team['team']
			])->fetchPairs('team', 'moment');
		} catch (Dibi\Exception $e) {
			$this->sendErrorResource($e);
		} // try

		/** Odešleme data */
		$this->sendResource();
	} // actionDetail()

	public function actionHelp($post)
	{
		try {
			$previousLog = $this->logs->find([
			    'team'     => (int) $this->team['team'],
			    'post'     => (int) $post,
			    'log_type' => Models\Logs::HELP
			]); // find()
			if (empty($previousLog)) {
			    $this->logs->insert([
				'team'     => (int) $this->team['team'],
				'post'     => (int) $post,
				'log_type' => Models\Logs::HELP
			    ]); // insert()
			} // if
			$post = $this->posts->find($post);
			$this->resource['help'] = $post['help'];
		} catch (Dibi\Exception $e) {
			$this->sendErrorResource($e);
		} // try
		$this->sendResource();
	} // actionHelp()

	public function actionLog($post, $shibboleth)
	{
		try {
			// Odstartoval tým závod?
			if (!$this->logs->isStarted($this->team['team'], $post)) {
			    $this->resource = [
				'status' => 'nelze logovat stanoviště dokud jste neodstartovali',
				'code'   => 401
			    ];
			    $this->sendResource();
			} // if

			// Neskončil zatím tým závod?
			if ($this->logs->isFinished($this->team['team'])) {
			    $this->resource = [
				'status' => 'nelze logovat stanoviště po skončení závodu',
				'code'   => 403
			    ];
			    $this->sendResource();
			} // if

			// Nemá stanoviště už zalogované?
			$lastLog = $this->logs->find([
			    'team'     => (int) $this->team['team'],
			    'post'     => (int) $post,
			    'log_type' => Models\Logs::DONE
			]); // find()
			if (!empty($lastLog)) {
			    $this->resource = [
				'status' => 'stanoviště jste už zalogovali',
				'code'   => 304
			    ];
			    $this->sendResource();
			} // if

			// Nesnaží se tým logovat příliš brzy po minulém nezdařeném pokusu?
			if (!$this->logs->canLog($this->team['team'], $post)) {
			    $nextAttempt   = $this->logs->nextLog($this->team['team'], $post);
			    $nextTimestamp = (int) $nextAttempt->getTimestamp();
			    $nextTimeout   = $nextTimestamp - time();
			    $this->resource = [
				'status' => 'musíte počkat',
				'code'   => 408,
				'next_timestamp' => date('H:i:s', $nextTimestamp),
				'next_interval'  => $nextTimeout
			    ];
			    $this->sendResource();
			} // if

			// Zjistíme heslo stanoviště a připravíme jej na porovnání
			$postShibboleth = mb_strtolower($this->posts->getShibboleth($post));
			$shibboleth     = mb_strtolower(urldecode($shibboleth));

			// Je heslo stanoviště správné?
			if ($shibboleth != $postShibboleth) {
			    $this->logs->insert([
				'team'     => (int) $this->team['team'],
				'post'     => (int) $post,
				'log_type' => Models\Logs::ERROR
			    ]); // insert()
			    $this->resource = [
				'status' => 'špatné heslo stanoviště',
				'code'   => 404
			    ];
			    $this->sendResource();
			} // if

			$postData = $this->posts->find($post);
			switch ($postData->post_type) {
			    case Models\Posts::BEGIN:
				$logType = Models\Logs::START;
				break;

			    case Models\Posts::END:
				$logType = Models\Logs::FINISH;
				break;

			    default:
			    case Models\Posts::ACTIVITY:
			    case Models\Posts::CIPHER:
			    case Models\Posts::CACHE:
			    case Models\Posts::BONUS:
			    case Models\Posts::SUPERBONUS:
				$logType = Models\Logs::DONE;
				break;
			} // switch

			// Zalogujeme stanoviště jako hotové
			$this->logs->insert([
			    'team'     => (int) $this->team['team'],
			    'post'     => (int) $post,
			    'log_type' => $logType
			]);
			$this->resource = [
			    'status' => 'OK',
			    'code'   => 200,
			    'password' => (array) $this->posts->getPassword($post, $this->team['team'])
			];
		} catch (Dibi\Exception $e) {
			$this->sendErrorResource($e);
		} // try
		$this->sendResource();
	} // actionLog()

	public function actionBonus($post, $bonusCode)
	{
		try {
			// Odstartoval tým závod?
			if (!$this->logs->isStarted($this->team['team'], $post)) {
			    $this->resource = [
				'status' => 'Not started',
				'code'   => 401
			    ];
			    $this->sendResource();
			} // if

			// Neskončil zatím tým závod?
			if ($this->logs->isFinished($this->team['team'])) {
			    $this->resource = [
				'status' => 'Already finished',
				'code'   => 403
			    ];
			    $this->sendResource();
			} // if

			// Nemá stanoviště už zalogované?
			$lastLog = $this->logs->find([
			    'team'     => (int) $this->team['team'],
			    'post'     => (int) $post,
			    'log_type' => Models\Logs::BONUS
			]); // find()
			if (!empty($lastLog)) {
			    $this->resource = [
				'status' => 'Already logged',
				'code'   => 304
			    ];
			    $this->sendResource();
			} // if

			// Nesnaží se tým logovat příliš brzy po minulém nezdařeném pokusu?
			if (!$this->logs->canBonusLog($this->team['team'], $post)) {
			    $nextAttempt   = $this->logs->nextBonusLog($this->team['team'], $post);
			    $nextTimestamp = (int) $nextAttempt->getTimestamp();
			    $nextTimeout   = $nextTimestamp - time();
			    $this->resource = [
				'status' => 'Waiting period',
				'code'   => 408,
				'next_timestamp' => date('H:i:s', $nextTimestamp),
				'next_interval'  => $nextTimeout
			    ];
			    $this->sendResource();
			} // if

			// Zjistíme bonusový kód stanoviště a připravíme jej na porovnání
			$postBonusCode = mb_strtolower($this->posts->getBonusCode($post));
			$bonusCode     = mb_strtolower(urldecode(self::toAscii($bonusCode)));

			// Je bonusový kód stanoviště správné?
			if ($bonusCode != $postBonusCode) {
			    $this->logs->insert([
				'team'     => (int) $this->team['team'],
				'post'     => (int) $post,
				'log_type' => Models\Logs::ERROR
			    ]); // insert()
			    $this->resource = [
				'status' => 'Wrong bonus code',
				'code'   => 404
			    ];
			    $this->sendResource();
			} // if

			// Zalogujeme stanoviště jako odemčené
			$this->logs->insert([
			    'team'     => (int) $this->team['team'],
			    'post'     => (int) $post,
			    'log_type' => Models\Logs::BONUS
			]);
			$this->resource = [
			    'status' => 'OK',
			    'code'   => 200
			];
		} catch (Dibi\Exception $e) {
			$this->sendErrorResource($e);
		} // try

		$this->sendResource();
	} // actionBonus()

    public function actionCreate()
    {
        $this->checkAdministrator();

        $values = [
            'post_type'   => strtoupper($this->input->postType),
            'color'       => strtoupper($this->input->color),
            'name'        => $this->input->name,
            'max_score'   => (int) $this->input->maxScore,
            'difficulty'  => $this->input->difficulty,
            'terrain'     => $this->input->terrain,
            'latitude'    => $this->input->latitude,
            'longitude'   => $this->input->longitude
        ];

        if (isset($this->input->cacheType) && !empty($this->input->cacheType))
            $values['cache_type'] = strtoupper($this->input->cacheType);

        if (isset($this->input->cacheSize) && !empty($this->input->cacheSize))
            $values['cache_size'] = strtoupper($this->input->cacheSize);

        if (isset($this->input->withStaff) && !empty($this->input->withStaff))
            $values['with_staff'] = $this->input->withStaff;

        if (isset($this->input->hint) && !empty($this->input->hint))
            $values['hint'] = $this->input->hint;

        if (isset($this->input->help) && !empty($this->input->help))
            $values['help'] = $this->input->help;

        if (isset($this->input->description) && !empty($this->input->description))
            $values['description'] = $this->input->description;

        if (isset($this->input->bonusCode) && !empty($this->input->bonusCode))
            $values['bonus_code'] = $this->input->bonusCode;

        if (isset($this->input->openFrom) && !empty($this->input->openFrom))
            $values['open_from'] = $this->input->openFrom;

        if (isset($this->input->openTo) && !empty($this->input->openTo))
            $values['open_to'] = $this->input->openTo;

		if (isset($this->input->shibboleth) && !empty($this->input->shibboleth))
			$values['shibboleth'] = $this->input->shibboleth;

		if (isset($this->input->passwordCharacter) && !empty($this->input->passwordCharacter))
			$values['password_character'] = $this->input->passwordCharacter;

		if (isset($this->input->passwordPosition) && !empty($this->input->passwordPosition))
			$values['password_position'] = $this->input->passwordPosition;

		if (isset($this->input->timeEstimate) && !empty($this->input->timeEstimate))
			$values['time_estimate'] = $this->input->time_estimate;

        $result = [];
        $this->posts->begin();
        try {
            $result['post'] = (int) $this->posts->insert($values);

            if (!empty($this->input->waypoints)) {
                foreach ($this->input->waypoints as $wp) {
                    $waypointValues = [
                        'waypoint_type'       => strtoupper($wp->waypointType),
                        'waypoint_visibility' => strtoupper($wp->waypointVisibility),
                        'post'                => $result['post'],
                        'name'                => $wp->name,
                        'latitude'            => (float) $wp->latitude,
                        'longitude'           => (float) $wp->longitude
                    ];

                    if (isset($wp->description) &&  !empty($wp->description))
                        $waypointValues['description'] = $wp->description;

                    $result['waypoints'][] = (int) $this->waypoints->insert($waypointValues);
                } // foreach
            } // if

            if (!empty($this->input->attributes)) {
                foreach ($this->input->attributes as $attributeName => $attributeValue) {
                    $attributeValues = [
                        'post'      => $post,
                        'attribute' => $attributeName,
                        'status'    => $attributeValue
                    ];

                    $result['attributes'][] = (int) $this->waypoints->save($attributeValues);
                } // foreach
            } // if

            $this->posts->commit();
        } catch (Dibi\Exception $e) {
            $this->posts->rollback();
            $this->sendErrorResource($e);
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201,
            'data'   => $result
        ];
        $this->sendResource();
    } // actionCreate()

    public function actionUpdate()
    {
        $this->checkAdministrator();

        $post = (int) $this->input->post;
        $filter = [ 'post' => $post ];
        $values = [
            'post_type'   => strtoupper($this->input->postType),
            'color'       => strtoupper($this->input->color),
            'name'        => $this->input->name,
            'max_score'   => (int) $this->input->maxScore,
            'difficulty'  => $this->input->difficulty,
            'terrain'     => $this->input->terrain,
            'latitude'    => $this->input->latitude,
            'longitude'   => $this->input->longitude
        ];

        if (isset($this->input->cacheType) && !empty($this->input->cacheType))
            $values['cache_type'] = strtoupper($this->input->cacheType);

        if (isset($this->input->cacheSize) && !empty($this->input->cacheSize))
            $values['cache_size'] = strtoupper($this->input->cacheSize);

        if (isset($this->input->withStaff) && !empty($this->input->withStaff))
            $values['with_staff'] = $this->input->withStaff;

        if (isset($this->input->hint) && !empty($this->input->hint))
            $values['hint'] = $this->input->hint;

        if (isset($this->input->help) && !empty($this->input->help))
            $values['help'] = $this->input->help;

        if (isset($this->input->description) && !empty($this->input->description))
            $values['description'] = $this->input->description;

        if (isset($this->input->bonusCode) && !empty($this->input->bonusCode))
            $values['bonus_code'] = $this->input->bonusCode;

        if (isset($this->input->openFrom) && !empty($this->input->openFrom))
            $values['open_from'] = $this->input->openFrom;

        if (isset($this->input->openTo) && !empty($this->input->openTo))
            $values['open_to'] = $this->input->openTo;

		if (isset($this->input->shibboleth) && !empty($this->input->shibboleth))
			$values['shibboleth'] = $this->input->shibboleth;

		if (isset($this->input->passwordCharacter) && !empty($this->input->passwordCharacter))
			$values['password_character'] = $this->input->passwordCharacter;

		if (isset($this->input->passwordPosition) && !empty($this->input->passwordPosition))
			$values['password_position'] = $this->input->passwordPosition;

		if (isset($this->input->timeEstimate) && !empty($this->input->timeEstimate))
			$values['time_estimate'] = $this->input->time_estimate;

        $this->posts->begin();
        try {
            $this->posts->update($values, $filter);
        } catch (Dibi\Exception $e) {
            $this->posts->rollback();
            $this->sendErrorResource($e);
        } // try

        try {
            $this->waypoints->delete(['post' => $filter['post']]);
        } catch (Dibi\Exception $e) {
            $this->posts->rollback();
            $this->sendErrorResource($e);
        } // try

        $result = [];
        foreach ($this->input->waypoints as $wp) {
            try {
                $filter = isset($wp['waypoint']) && !empty($wp['waypoint'])
                        ? [ 'waypoint' => (int) $wp['waypoint'] ]
                        : null;
                $values = [
                    'waypoint_type'       => strtoupper($wp['waypointType']),
                    'waypoint_visibility' => strtoupper($wp['waypointVisibility']),
                    'post'                => $post,
                    'name'                => $wp['name'],
                    'latitude'            => (float) $wp['latitude'],
                    'longitude'           => (float) $wp['longitude']
                ];
                if (isset($wp['description']) &&  !empty($wp['description']))
                    $waypointValues['description'] = $wp['description'];

                $result[] = (int) $this->waypoints->insert($values);
            } catch (Dibi\Exception $e) {
                $this->posts->rollback();
                $this->sendErrorResource($e);
            } // try
        } // foreach
        $this->posts->commit();

        $this->resource = [
            'status' => 'OK',
            'code'   => 201,
            'data'   => $result
        ];
        $this->sendResource();
    } // actionUpdate()

    public function actionDelete()
    {
        $this->checkAdministrator();

        $filter = [ 'post' => (int) $this->input->post ];
        try {
            $this->posts->delete($filter);
        } catch (\Exception $e) {
            $this->sendErrorResource($e);
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource();
    } // actionDelete()

} // PostPresenter
