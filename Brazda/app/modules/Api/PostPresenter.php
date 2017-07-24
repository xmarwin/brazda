<?php

namespace Brazda\Module\Api\Presenters;

use Nette\Security;

class PostPresenter extends SecuredBasePresenter
{
	protected
		$posts,
		$waypoints;

	public function startup()
	{
		parent::startup();

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
                'post' => $post['post'],
                'team' => $this->team['team']
            ])->fetchAll();
		} // foreach
		$this->sendResource($this->outputType);
	} // actionList()

} // PostPresenter
