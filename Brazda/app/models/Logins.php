<?php

namespace Brazda\Models;

use Nette,
    Nette\DI,
    Nette\Security;

class Logins extends Base implements Security\IAuthenticator
{
    protected
        $teams;

    public function __construct(DI\Container $context)
    {
        parent::__construct($context);

        $this->teams = $this->context->getService('teams');
    } // startup()

    public function find(array $filter)
    {
        $filter = $this->normalizeFilter($filter);

        return $this->db->query(
            "SELECT *
             FROM logins
             WHERE %and", $filter,
            "LIMIT 1"
        )->fetch();
    } // find()

    public function authenticate(array $credentials)
    {
        list($name, $shibboleth) = $credentials;

        $team = $this->teams->findByName($name);
        if (empty($team)) {
            throw new Security\AuthenticationException(sprintf(
                    'Tým se jménem %s neexistuje.',
                    $name
                ), // sprintf()
                404
            ); // AuthenticationException()
        } // if

        if ($team->shibboleth !== $shibboleth) {
            throw new Security\AuthenticationException(sprintf(
                    'Špatné heslo pro tým %s.',
                    $name
                ), // sprintf()
                401
            ); // AuthenticationException()
        } // if

        $user = (array) $team;
        unset($user['shibboleth']);

        return new Security\Identity(
            $team->team,
            $team->role,
            $user
        ); // Identity()
    } // authenticate()

    public function isLoggedIn($securityToken)
    {
        $login = $this->db->query(
            "SELECT *
             FROM logins
             WHERE security_token LIKE %s", $securityToken
        )->fetch();

        return (bool) !empty($login);
    } // isLoggedIn()

    public function login($team, $deviceId)
    {
        $securityToken = bin2hex(openssl_random_pseudo_bytes(16));

        $login = $this->db->query(
            "INSERT INTO logins (
                team,
                device_id,
                security_token
             ) VALUES (
                %i, ", $team,
               "%s, ", $deviceId,
               "%s ",  $securityToken,
            ') RETURNING login'
        )->fetchSingle('login');

        return $this->db->query(
            'SELECT
                device_id,
                security_token
             FROM logins
             WHERE login = ', $login
        )->fetch();
    } // login()

    public function logout($securityToken)
    {
        $this->db->query(
            "DELETE FROM logins
             WHERE security_token LIKE %s", $securityToken
        ); // query()
    } // logout()

    public function touch($securityToken)
    {
		$this->db->query(
			"UPDATE logins
			 SET last_activity_moment = now()
			 WHERE security_token LIKE %s", $securityToken
		); // query()
    }

} // Logins
