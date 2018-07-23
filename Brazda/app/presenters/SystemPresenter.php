<?php

namespace Brazda\Presenters;

use Nette\Utils;

class SystemPresenter extends SecuredBasePresenter
{
	protected
		$messages,
		$settings;

	public function startup()
	{
		parent::startup();

		$this->messages = $this->context->getService('messages');
		$this->settings = $this->context->getService('settings');
	} // startup()

	public function actionDefault()
	{
		$parameters  = $this->context->getParameters();
		$versionFile = realpath($parameters['appDir'].
			DIRECTORY_SEPARATOR.'..'.
			DIRECTORY_SEPARATOR.'version'
		); // realpath()

		$settings = $this->settings->enumeration();
		$settings['version'] = $versionFile
			? trim(Utils\FileSystem::read($versionFile))
			: null;

		$settings['newMessages'] = $this->messages->count($this->team['team']);

		$this->resource = $settings;

		$this->sendResource($this->outputType);
	} // actionDefault()

	public function actionStart()
	{
		$this->checkAdministrator();

		$raceStart = date('Y-m-d H:i:s');
		$this->settings->set('raceStart', $raceStart);

		$this->resource = [ 'raceStart' => $raceStart ];

		$this->sendResource($this->outputType);
	} // actionStart()

	public function actionSet()
	{
		$this->checkAdministrator();

		$settings = $this->input->getData();
		unset($settings['securityToken']);

		foreach ($settings as $setting => $value) {
			$this->settings->set($setting, $value);
		} // foreach

		$this->resource = [
			'status' => 'OK',
			'code'   => 201
		];
		$this->sendResource($this->outputType);
	} // actionSet()

} // SystemPresenter
