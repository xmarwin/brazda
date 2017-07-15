<?php

namespace Brazda\Module\Api\Presenters;

use Nette\Security;

class SignPresenter extends BasePresenter
{
	protected
		$teams;

	public function startup()
	{
		parent::startup();

		$this->teams = $this->context->getService('teams');
	} // startup()

	public function actionIn($team, $password, $deviceId)
	{
		try {
			if (!$this->getUser()->isLoggedIn()) {
				$this->getUser()->login($team, $password);
				$identity = $this->getUser()->getIdentity()->getData();
				$login    = $this->logins->login($identity['team'], $deviceId);
			} else {
				$identity = $this->getUser()->getIdentity()->getData();
				$login    = $this->logins->find([ 'team' => $identity['team'] ]);
				if (empty($login)) {
					throw new Security\AuthenticationException(sprintf(
						'Tým %s není přihlášen.',
						$team
					), // sprintf()
					3);
				} // if
			} // if
		} catch (Security\AuthenticationException $e) {
			$this->sendErrorResource($e, $this->outputType);
		} // try

		$data  = (array) $identity;
		$data += (array) $login;

		$this->resource = $data;
		$this->sendResource($this->outputType);
	} // actionIn()

	public function actionOut($securityToken)
	{
		$this->getUser()->logout();
		$this->logins->logout($securityToken);

		$this->resource = [ 'logout' => true ];
		$this->sendResource($this->outputType);
	} // actionOut()

} // SignPresenter
