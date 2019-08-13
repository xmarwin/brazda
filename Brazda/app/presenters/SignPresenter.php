<?php

namespace Brazda\Presenters;

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
            /** Pokud uživatel není přihlášen */
			if (!$this->getUser()->isLoggedIn()) {
				$this->getUser()->login((int) $team, $password);
				$identity = $this->getUser()->getIdentity();
                if (empty($deviceId)) {
                    throw new \Exception('DeviceId je prázdné.', 400);
                } // if

				$login = $this->logins->login($identity->team, $deviceId);
				if (!empty($login)) {
                    $this->getUser()->getIdentity()->securityToken = $login->security_token;
				} // if
			} else {
				$identity = $this->getUser()->getIdentity();
				$login    = $this->logins->find([ [ 'security_token LIKE %sN', $identity->securityToken ] ]);
				//$login    = $this->logins->find([ 'team' => $identity['team'] ]);
				if (empty($login)) {
					throw new Security\AuthenticationException(sprintf(
						'Tým %s není přihlášen.',
						$team
					), // sprintf()
					403);
				} // if
			} // if
		} catch (\Exception $e) {
			if ($this->getUser()->isLoggedIn()) {
                $identity = $this->getUser()->getIdentity();
                $this->getUser()->logout();
                $this->logins->logout($identity->securityToken);
			} // if
			$this->sendErrorResource($e);
		} // try
/*
		$data  = (array) $identity->getData();
		$data += (array) $login;

		$this->resource = $data;
*/
        $identityData = $identity->getData();

        $this->resource = [
            'team'          => $identityData['team'],
            'name'          => $identityData['name'],
            'description'   => $identityData['description'],
            'role'          => $identityData['role'],
            'roleName'      => $identityData['role_name'],
            'active'        => $identityData['is_active'],
            'allowTracking' => $identityData['allow_tracking'],
            'telephone'     => $identityData['telephone'],
            'email'         => $identityData['email'],
            'securityToken' => $login->security_token,
            'deviceId'      => $login->device_id
        ];

		$this->sendResource();
	} // actionIn()

	public function actionOut($securityToken)
	{
		$this->getUser()->logout();
		$this->logins->logout($securityToken);

		$this->resource = [ 'logout' => true ];
		$this->sendResource();
	} // actionOut()

	public function actionTeamsList()
	{
		$teams = $this->teams->view([], [ 'name' => 'ASC' ]);
		foreach ($teams as $team) {
			$this->resource[] = [
				'team'        => $team['team'],
				'team_type'   => $team['role'],
				'name'        => $team['name'],
				'description' => $team['description'],
				'is_active'   => $team['active']
			];
		} // foreach

		$this->sendResource();
	} // actionTeamsList()

} // SignPresenter
