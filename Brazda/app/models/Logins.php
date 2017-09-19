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
            "ORDER BY moment
             LIMIT 1"
        )->fetch();
    } // find()

    public function authenticate(array $credentials)
    {
        list($teamId, $shibboleth) = $credentials;

        if (!is_integer($teamId)) {
            throw new \Exception(sprintf(
                    '%d není platné id týmu.',
                    $teamId
                ), // printf()
                400
            ); // \Exception()
        } // if

        $team = $this->teams->find([ 'team' => $teamId ]);
        if (empty($team)) {
            throw new Security\AuthenticationException(sprintf(
                    'Tým %d neexistuje.',
                    $teamId
                ), // sprintf()
                200
            ); // AuthenticationException()
        } // if

        if ($team->shibboleth !== $shibboleth) {
            throw new Security\AuthenticationException(sprintf(
                    'Špatné heslo pro tým %d.',
                    $teamId
                ), // sprintf()
                200
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

    public function getTeam($securityToken)
    {
        return $this->find([ [ 'security_token LIKE %s', $securityToken ] ]);
    } // getTeam()

    public function isLoggedIn($securityToken)
    {
        $login = $this->find([ [ 'security_token LIKE %s', $securityToken ] ]);

        return (bool) !empty($login);
    } // isLoggedIn()

    public function login($team, $deviceId)
    {
        $securityToken = bin2hex(openssl_random_pseudo_bytes(16));

        $login = $this->db->query(
            "SELECT *
             FROM logins
             WHERE team = %i", $team,
            "  AND device_id LIKE %s", $deviceId
        )->fetch();

        if (!empty($login)) {
/*
            throw new Security\AuthenticationException(sprintf(
                    'Někdo se za tento tým zalogoval ze stejného zařízení již v %s.', date('j. n. Y H:i', strtotime($login->moment))
                ), // sprintf()
                200
            ); // AuthenticationException()
*/
            $this->db->query(
                "DELETE FROM logins
                 WHERE team = %i", $team, "
                   AND device_id LIKE %s", $deviceId
            ); // query()
        } // if

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
