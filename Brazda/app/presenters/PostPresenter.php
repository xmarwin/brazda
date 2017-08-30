<?php

namespace Brazda\Presenters;

use Nette\Security,
    Brazda\Models,
    Drahak\Restful\Validation;

class PostPresenter extends SecuredBasePresenter
{
	protected
        $logs,
		$posts,
		$postTypes,
		$waypoints;

	public function startup()
	{
		parent::startup();

		$this->logs      = $this->context->getService('logs');
		$this->posts     = $this->context->getService('posts');
		$this->postTypes = $this->context->getService('postTypes');
		$this->waypoints = $this->context->getService('waypoints');
	} // startup()

	public function actionList(array $filter = [], array $order = [])
	{
		$viewFilter = [
            'team' => $this->team['team']
		];
		if (isset($filter['type']) && !empty($filter['type'])) {
			$types = explode(',', $filter['type']);
			$viewFilter[] = [ 'p.post_type IN %in', $types ];
		} // if

		if (isset($filter['color']) && !empty($filter['color'])) {
			$colors = explode(',', $filter['color']);
			$viewFilter[] = [ 'p.color IN %in', $colors ];
		} // if

		$this->resource = (array) $this->posts->view($viewFilter, $order)->fetchAll();
		foreach ($this->resource as $id => $post) {
            $this->resource[$id]['waypoints'] = $this->waypoints->view([
                'post' => (int) $post['post'],
                'team' => (int) $this->team['team']
            ])->fetchAll();
		} // foreach
		$this->sendResource($this->outputType);
	} // actionList()

	public function actionDetail($post)
	{
        $this->resource = (array) $this->posts->view([
            'team' => (int) $this->team['team'],
            'post' => (int) $post
        ])->fetch();
        $this->resource['waypoints'] = $this->waypoints->view([
            'post' => (int) $post,
            'team' => (int) $this->team['team']
        ])->fetchAll();
        $this->resource['visits'] = $this->logs->view([
            'post' => (int) $post,
            'team' => (int) $this->team['team']
        ])->fetchPairs('team', 'moment');
        $this->sendResource($this->outputType);
	} // actionDetail()

	public function actionHelp($post)
	{
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
        $this->sendResource($this->outputType);
	} // actionHelp()

	public function actionLog($post, $shibboleth)
	{
        $lastLog = $this->logs->find([
            'team'     => (int) $this->team['team'],
            'post'     => (int) $post,
            'log_type' => Models\Logs::DONE
        ]); // find()
        if (!empty($lastLog)) {
            $this->resource = [
                'status' => 'Already logged',
                'code'   => 304
            ];
            $this->sendResource($this->outputType);
        } // if

        $nextAttempt = $this->logs->nextLog($this->team['team'], $post);
        $nextTimeout = $nextAttempt - time();

        if (!$this->logs->canLog($this->team['team'], $post)) {
            $this->resource = [
                'status' => 'Waiting period',
                'code'   => 408,
                'next_timestamp' => $nextAttempt,
                'next_interval'  => $nextTimeout
            ];
            $this->sendResource($this->outputType);
        } // if

        $postShibboleth = $this->posts->getShibboleth($post);
        $shibboleth     = urldecode($shibboleth);
        if ($shibboleth != $postShibboleth) {
            $this->logs->insert([
                'team'     => (int) $this->team['team'],
                'post'     => (int) $post,
                'log_type' => Models\Logs::ERROR
            ]); // insert()
            $this->resource = [
                'status' => 'Wrong shibboleth',
                'code'   => 404
            ];
            $this->sendResource($this->outputType);
        } // if

        $this->logs->insert([
            'team'     => (int) $this->team['team'],
            'post'     => (int) $post,
            'log_type' => Models\Logs::DONE
        ]);
        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource($this->outputType);
	} // actionLog()

	public function actionBonus($post, $bonusCode)
	{
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
            $this->sendResource($this->outputType);
        } // if

        $nextAttempt = $this->logs->nextBonusLog($this->team['team'], $post);
        $nextTimeout = $nextAttempt - time();

        if (!$this->logs->canBonusLog($this->team['team'], $post)) {
            $this->resource = [
                'status' => 'Waiting period',
                'code'   => 408,
                'next_timestamp' => $nextAttempt,
                'next_interval'  => $nextTimeout
            ];
            $this->sendResource($this->outputType);
        } // if

        $postBonusCode = $this->posts->getBonusCode($post);
        $bonusCode     = urldecode($bonusCode);
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
            $this->sendResource($this->outputType);
        } // if

        $this->logs->insert([
            'team'     => (int) $this->team['team'],
            'post'     => (int) $post,
            'log_type' => Models\Logs::BONUS
        ]);
        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource($this->outputType);
	} // actionBonus()

    public function actionCreate()
    {
        $this->checkAdministrator();

        $values = [
            'post_type'   => strtoupper($this->input->postType),
            'color'       => strtoupper($this->input->color),
            'name'        => $this->input->name,
            'max_score'   => (int) $this->input->maxScore,
            'difficulty'  => (float) $this->input->difficulty,
            'terrain'     => (float) $this->input->terrain,
            'shibboleth'  => $this->input->shibboleth,
            'latitude'    => $this->input->latitude,
            'longitude'   => $this->input->longitude
        ];

        if (isset($this->input->cacheType) && !empty($this->input->cacheType))
            $values['cache_type'] = strtoupper($this->input->cacheType);

        if (isset($this->input->cacheSize) && !empty($this->input->cacheSize))
            $values['cache_size'] = strtoupper($this->input->cacheSize);

        if (isset($this->input->withStaff) && !empty($this->input->withStaff))
            $values['with_staff'] = (bool) $this->input->withStaff;

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

        $result = [];
        $this->posts->begin();
        try {
            $result['post'] = (int) $this->posts->insert($values);
        } catch (\Exception $e) {
            $this->posts->rollback();
            $this->sendErrorResource($e, $this->outputType);
        } // try

        foreach ($this->input->waypoints as $wp) {
            $values = [
                'waypoint_type'       => strtoupper($wp['waypointType']),
                'waypoint_visibility' => strtoupper($wp['waypointVisibility']),
                'post'                => $result['post'],
                'name'                => $wp['name'],
                'description'         => $wp['description'],
                'latitude'            => (float) $wp['latitude'],
                'longitude'           => (float) $wp['longitude']
            ];

            try {
                $result['waypoints'][] = (int) $this->waypoints->insert($values);
            } catch (\Exception $e) {
                $this->posts->rollback();
                $this->sendErrorResource($e, $this->outputType);
            } // try
        } // foreach
        $this->posts->commit();

        $this->resource = [
            'status' => 'OK',
            'code'   => 201,
            'data'   => $result
        ];
        $this->sendResource($this->outputType);
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
            'difficulty'  => (float) $this->input->difficulty,
            'terrain'     => (float) $this->input->terrain,
            'shibboleth'  => $this->input->shibboleth,
            'latitude'    => $this->input->latitude,
            'longitude'   => $this->input->longitude
        ];

        if (isset($this->input->cacheType) && !empty($this->input->cacheType))
            $values['cache_type'] = strtoupper($this->input->cacheType);

        if (isset($this->input->cacheSize) && !empty($this->input->cacheSize))
            $values['cache_size'] = strtoupper($this->input->cacheSize);

        if (isset($this->input->withStaff) && !empty($this->input->withStaff))
            $values['with_staff'] = (bool) $this->input->withStaff;

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

        $this->posts->begin();
        try {
            $this->posts->update($values, $filter);
        } catch (\Exception $e) {
            $this->posts->rollback();
            $this->sendErrorResource($e, $this->outputType);
        } // try

        foreach ($this->input->waypoints as $wp) {
            $filter = [ 'waypoint' => (int) $wp['waypoint'] ];
            $values = [
                'waypoint_type'       => strtoupper($wp['waypointType']),
                'waypoint_visibility' => strtoupper($wp['waypointVisibility']),
                'post'                => $post,
                'name'                => $wp['name'],
                'description'         => $wp['description'],
                'latitude'            => (float) $wp['latitude'],
                'longitude'           => (float) $wp['longitude']
            ];

            try {
                $this->waypoints->update($values, $filter);
            } catch (\Exception $e) {
                $this->posts->rollback();
                $this->sendErrorResource($e, $this->outputType);
            } // try
        } // foreach
        $this->posts->commit();

        $this->resource = [
            'status' => 'OK',
            'code'   => 201
        ];
        $this->sendResource($this->outputType);
    } // actionUpdate()

    public function actionDelete()
    {
        $this->checkAdministrator();

        $filter = [ 'post' => (int) $this->input->post ];
        try {
            $this->posts->delete($filter);
        } catch (\Exception $e) {
            $this->sendErrorResource($e, $this->outputType);
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource($this->outputType);
    } // actionDelete()

} // PostPresenter
