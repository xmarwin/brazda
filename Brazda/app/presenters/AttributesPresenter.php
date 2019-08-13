<?php

namespace Brazda\Presenters;

use Brazda\Models;

class AttributesPresenter extends SecuredBasePresenter
{
	use \Brazda\Encoding;

	protected
		$attributes;

	public function startup()
	{
		parent::startup();

		$this->attributes = $this->context->getService('attributes');
	} // startup()

	public function actionDefault()
	{
		$this->checkAdministrator();

		try {
			$this->resource = $this->attributes->view()->fetchAll();
		} catch (\Exception $e) {
			$this->sendErrorResource($e);
		} // try

		$this->sendResource();
	} // actionDefault()

} // AttributesPresenter
