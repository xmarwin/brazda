<?php

require __DIR__.'/../vendor/autoload.php';
/*
global
	$configurator,
	$container,
	$presenter,
	$presenterFactory;
*/
Tester\Environment::setup();
date_default_timezone_set('Europe/Prague');

define('BASE_DIR', realpath(__DIR__.'/..').'/');

$configurator = new Nette\configurator;

$configurator->setDebugMode(true);
$configurator->setTempDirectory(realpath(BASE_DIR.'temp/tests/'));

$configurator->createRobotLoader()
	->addDirectory(BASE_DIR.'/app/')
	->register();

$configurator->addConfig(BASE_DIR.'app/config/config.neon');
$configurator->addConfig(BASE_DIR.'app/config/config.test.neon');

$container = $configurator->createContainer();

return $container;
