<?php

namespace Brazda;

use Nette;
use Nette\Application\Routers\RouteList;
use Nette\Application\Routers\Route;


class RouterFactory
{
	use Nette\StaticClass;

	/**
	 * @return Nette\Application\IRouter
	 */
	public static function createRouter()
	{
		$router = new RouteList;
		//$router[] = new Route('<presenter>/<action>[/<id>]', 'Homepage:default');
		$router[] = new Route('index.php', 'Front:Default:default', Route::ONE_WAY);

		$router[] = $apiRouter = new RouteList('Api');
		$apiRouter[] = new Route('api/<presenter>/<action>[/<id>]', 'Default:default');
		
		$router[] = $frontRouter = new RouteList('Front');
		$frontRouter[] = new Route('<presenter>/<action>[/<id>]', 'Default:default');

		return $router;
	}

}
