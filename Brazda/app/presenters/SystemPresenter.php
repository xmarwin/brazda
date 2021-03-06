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

        $settings['newMessages'] = isset($this->team['team'])
            ? $this->messages->count($this->team['team'])
            : 0;

        $this->resource = $settings;

        $this->sendResource();
    } // actionDefault()

    public function actionStart($role = null)
    {
        $this->checkAdministrator();

        $raceStart = date('Y-m-d H:i:s');
        switch (strtoupper($role)) {
            case 'KID':
                $this->settings->set('raceStart_KID', $raceStart);
		break;

            case 'COM':
                $this->settings->set('raceStart_COM', $raceStart);
		break;

            default:
                $this->settings->set('raceStart_KID', $raceStart);
                $this->settings->set('raceStart_COM', $raceStart);
		break;
                
	} // switch

        $this->resource = [ 'raceStart' => $raceStart ];

        $this->sendResource();
    } // actionStart()

    public function actionSet()
    {
        $this->checkAdministrator();

        $settings = $this->input;
        unset($settings['securityToken']);
	if (isset($settings['raceStart_COM'])) unset($settings['raceStart_COM']);
	if (isset($settings['raceStart_KID'])) unset($settings['raceStart_KID']);

        foreach ($settings as $setting => $value) {
            $this->settings->set($setting, $value);
        } // foreach

        $this->resource = [
            'status' => 'OK',
            'code'   => 201
        ];
        $this->sendResource();
    } // actionSet()

} // SystemPresenter
