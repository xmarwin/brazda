<?php

namespace Brazda\Models;

use Nette,
    Nette\DI,
    Nette\Security;

class Authenticator extends Nette\Object implements Security\IAuthenticator
{
    public
        $teams;

    protected
        $context;

    public function __construct(DI\Container $context) {

        $this->context = $context;
        $this->teams = $this->context->getService('teams');
    } // __construct()

    public function authenticate(array $credentials) {

        list($name, $shibboleth) = $credentials;

        $team = $this->teams->findByName($name);
        if (empty($team)) {
            throw new Security\AuthenticationException(sprintf(
                    'Tým se jménem %s neexistuje.',
                    $name
                ), // sprintf()
                self::IDENTITY_NOT_FOUND
            ); // AuthenticationException()
        } // if

        if ($team->shibboleth !== $shibboleth) {
            throw new Security\AuthenticationException(sprintf(
                    'Špatné heslo pro tým %s.',
                    $name
                ), // sprintf()
                self::INVALID_CREDENTIAL
            ); // AuthenticationException()
        } // if

        $user = (array) $team;
        unset($user['shibboleth']);

        return new Security\Identity(
            $team->team,
            $team->team_type,
            $user
        ); // Identity()
    } // authenticate()

}
