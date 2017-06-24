<?php

namespace Brazda\Module\Api\Presenters;

use Nette\Security;

class TeamPresenter extends BasePresenter
{
	public function actionLogin($login, $password, $type)
	{
		try {
			$identity = $this->getUser()->login($login, $password);
		} catch (Security\AuthenticationException $e) {
		} // try
	} // actionLogin()

} // TeamPresenter
