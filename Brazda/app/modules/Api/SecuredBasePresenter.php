<?php

namespace Brazda\Module\Api\Presenters;

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

		$logins,

		$team;

    public function startup()
    {
        parent::startup();

        $this->logins = $this->context->getService('logins');

        $this->checkSecurityToken();
        $this->team = $this->getUser()->getIdentity()->getData();
    } // startup()

    public function checkSecurityToken()
    {
		$parameters = $this->getRequest()->getParameters();
		if (!isset($parameters['securityToken'])
		||  empty($parameters['securityToken'])) {

			$this->sendErrorResource(
				new Security\AuthenticationException(
					'Prázdný securityToken, nelze ověřit uživatele.',
					400
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
					400
				), // AuthenticationException()
				$this->outputType
			); // sendErrorResource()
		} // if

		$this->logins->touch($securityToken);

		return true;
    } // checkSecurityToken()

} // SecuredBasePresenter
