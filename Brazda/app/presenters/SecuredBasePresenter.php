<?php

namespace Brazda\Presenters;

use Nette\Security;

class SecuredBasePresenter extends BasePresenter
{
	protected
		$resource,
		$input,

		$logins,

		$team;

    public function startup()
    {
        parent::startup();

        $this->logins = $this->context->getService('logins');

        $this->checkSecurityToken();
        $this->team = !empty($this->getUser()->getIdentity())
			? $this->getUser()->getIdentity()->getData()
			: [];

		$this->input = $this->getInput();
    } // startup()

    public function checkSecurityToken()
    {
		$parameters = $this->getRequest()->getParameters();
		if (!isset($parameters['securityToken'])
		||  empty($parameters['securityToken'])) {

			$this->sendErrorResource(
				new Security\AuthenticationException(
					'Prázdný securityToken, nelze ověřit uživatele.',
					403
				) // AuthenticationException()
			); // sendErrorResource()
		} // if
		$securityToken = $parameters['securityToken'];

		$login = $this->logins->find([ 'security_token' => $securityToken ]);
		if (empty($login)) {
			$this->sendErrorResource(
				new Security\AuthenticationException(
					'SecurityToken nebyl nalezen.',
					403
				) // AuthenticationException()
			); // sendErrorResource()
		} // if

		$this->logins->touch($securityToken);

		return true;
    } // checkSecurityToken()

    public function checkAdministrator()
    {
        if (!$this->getUser()->isInRole('ORG')) {
            $this->sendErrorResource(
                new Security\AuthenticationException(
                    'Nemáte oprávnění pro volání této metody.',
                    401
                ) // AuthenticationException()
            ); // sendErrorResource()
        } // if

        return true;
    } // checkAdministrator()

} // SecuredBasePresenter
