<?php

namespace Brazda\Presenters;

use Nette\Utils;

class VersionPresenter extends BasePresenter
{
	public function actionDefault()
	{
		$parameters = $this->context->getParameters();

		$versionFile = realpath($parameters['appDir'].DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR.'version');

		$this->resource = $versionFile
			? [ 'version' => trim(Utils\FileSystem::read($versionFile)) ]
			: [ 'version' => null ];

		$this->sendResource($this->outputType);
	} // actionDefault()

} // VersionPresenter
