<?php

namespace Brazda\Presenters;

use Drahak\Restful\IResource,
    Drahak\Restful\Application\UI\SecuredResourcePresenter,
    Nette\Security;

class SecuredBasePresenter extends SecuredResourcePresenter
{
	protected
		$typeMap = [
			'json' => IResource::JSON,
			'xml'  => IResource::XML
		],
		$outputType = IResource::JSON,
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
				), // AuthenticationException()
				$this->outputType
			); // sendErrorResource()
		} // if
		$securityToken = $parameters['securityToken'];

		$login = $this->logins->find([ 'security_token' => $securityToken ]);
		if (empty($login)) {
			$this->sendErrorResource(
				new Security\AuthenticationException(
					'SecurityToken nebyl nalezen.',
					403
				), // AuthenticationException()
				$this->outputType
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
                ), // AuthenticationException()
                $this->outputType
            ); // sendErrorResource()
        } // if

        return true;
    } // checkAdministrator()

} // SecuredBasePresenter
