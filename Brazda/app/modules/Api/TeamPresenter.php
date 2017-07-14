<?php

namespace Brazda\Module\Api\Presenters;

use Nette\Security;

class TeamPresenter extends BasePresenter
{
    protected
        $teams;

    public function startup()
    {
        parent::startup();

        $this->teams = $this->context->getService('teams');
    } // startup()

	public function actionLogin($login, $password, $type)
	{
		try {
			$identity = $this->getUser()->login($login, $password);
		} catch (Security\AuthenticationException $e) {
		} // try
	} // actionLogin()

	public function actionList()
	{
        $this->resource->teams = $this->teams->view();

        $this->sendResource($this->typeMap['json']);
	} // actionList()

} // TeamPresenter
