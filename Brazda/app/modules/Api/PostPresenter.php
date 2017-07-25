<?php

namespace Brazda\Module\Api\Presenters;

use Nette\Security,
    Brazda\Models;

class PostPresenter extends SecuredBasePresenter
{
	protected
        $logs,
		$posts,
		$waypoints;

	public function startup()
	{
		parent::startup();

		$this->logs = $this->context->getService('logs');
		$this->posts = $this->context->getService('posts');
		$this->waypoints = $this->context->getService('waypoints');
	}

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

        if (!$this->logs->canLog($this->team['team'], $post)) {
            $this->resource = [
                'status' => 'Waiting period',
                'code'   => 408,
                'next_attempt' => $this->logs->nextLog($this->team['team'], $post)
            ];
            $this->sendResource($this->outputType);
        } // if

        $postShibboleth = $this->posts->getShibboleth($post);
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

        if (!$this->logs->canLog($this->team['team'], $post)) {
            $this->resource = [
                'status' => 'Waiting period',
                'code'   => 408,
                'next_attempt' => $this->logs->nextLog($this->team['team'], $post)
            ];
            $this->sendResource($this->outputType);
        } // if

        $postBonusCode = $this->posts->getBonusCode($post);
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

} // PostPresenter
