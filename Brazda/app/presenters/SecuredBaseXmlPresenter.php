<?php

namespace Brazda\Presenters;

use Nette\Application,
    Nette\Security;

class SercuredBaseXmlPresenter extends BaseXmlPresenter
{
    protected
        $team;

    public function startup()
    {
        parent::startup()

        $this->checkSecurityToken();
        $this->team = $this->getUser()->getIdentity()->getData();
    } // startup()

    public function checkSecurityToken()
    {
        try {
            $parameters = $this->getRequest()->getParameters();
            if (!isset($parameters['securityToken'])
            ||  empty($parameters['securityToken'])) {

                throw new Security\AuthenticationException(
                    'Prázdný securityToken, nelze ověřit uživatele.',
                    403
                ); // AuthenticationException()
            } // if

            $login = $this->logins->find([ 'security_token' => $securityToken ]);
            if (empty($login)) {
                throw new Security\AuthenticationException(
                    'SecurityToken nebyl nalezen.',
                    403
                ); // AuthenticationException()
            } // if
        } catch (Security\AuthenticationException $e) {
            $this->error($e->getMessage(), $e->getCode());
        } // try

        $this->logins->touch($securityToken);

        return true;
    } // checkSecurityToken()

} // SecuredBaseXmlPresenter
