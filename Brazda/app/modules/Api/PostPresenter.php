<?php

namespace Brazda\Module\Api\Presenters;

use Nette\Security;

class PostPresenter extends SecuredBasePresenter
{
	protected
		$posts;

	public function startup()
	{
		parent::startup();

		$this->posts = $this->context->getService('posts');
	}

	public function actionList(array $filter = [], array $order = [])
	{
		$viewFilter = [];
		if (isset($filter['type']) && !empty($filter['type'])) {
			$types = explode(',', $filter['type']);
			$viewFilter[] = [ 'p.post_type IN %in', $types ];
		} // if

		if (isset($filter['color']) && !empty($filter['color'])) {
			$colors = explode(',', $filter['color']);
			$viewFilter[] = [ 'p.color IN %in', $colors ];
		} // if

		$this->resource = $this->posts->view($filter, $order);
		$this->sendResource($this->outputType);
	} // actionList()

} // PostPresenter
