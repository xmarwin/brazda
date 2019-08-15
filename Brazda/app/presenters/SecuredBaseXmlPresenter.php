<?php

namespace Brazda\Presenters;

use Nette\Application,
    Nette\Security;

class SecuredBaseXmlPresenter extends BaseXmlPresenter
{
    protected
        $logins,
        $teams,

        $team;

    public function startup()
    {
        parent::startup();

        $this->logins = $this->context->getService('logins');
        $this->teams  = $this->context->getService('teams');

        $this->checkSecurityToken();

        $parameters = $this->getRequest()->getParameters();
        $login      = $this->logins->find([ 'security_token' => $parameters['securityToken'] ]);
        $team       = (array) $this->teams->find([ 'team' => $login->team ]);
        $this->team = !empty($team)
            ? $team
            : [];
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

            $login = $this->logins->find([ 'security_token' => $parameters['securityToken'] ]);
            if (empty($login)) {
                throw new Security\AuthenticationException(
                    'SecurityToken nebyl nalezen.',
                    403
                ); // AuthenticationException()
            } // if
        } catch (Security\AuthenticationException $e) {
            $this->error($e->getMessage(), $e->getCode());
        } // try

        $this->logins->touch($parameters['securityToken']);

        return true;
    } // checkSecurityToken()

} // SecuredBaseXmlPresenter
