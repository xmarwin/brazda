<?php

namespace Brazda\Tests\Presenters;

use Nette\Application,
    Tester\Assert;

class RoleAnonCase extends \Tester\TestCase
{
	protected
		$container,
		$presenterFactory;

	public function __construct($container)
	{
		$this->container = $container;
		$this->presenterFactory = $container->getByType('Nette\Application\IPresenterFactory');
	} // __construct()

	protected function getPresenter($name, $autoCanonicalize = false)
	{
		global $presenterFactory;

		$presenter = $this->presenterFactory->createPresenter($name);
		$presenter->autoCanonicalize = $autoCanonicalize;

		return $presenter;
	} // getPresenter()

	protected function createRequest($action, $method = 'GET', $get = [], $post = [], $files = [], $flags = [])
	{
        $name = $this->presenter->getName();
        $get['action'] = $action;

		return new Application\Request($name, $method, $get, $post, $files, $flags);
	} // createRequest()

} // RoleAnonCase
