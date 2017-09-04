<?php

require __DIR__ . '/../vendor/autoload.php';

$configurator = new Nette\Configurator;

$configurator->setDebugMode([ '79.127.215.114', '127.0.0.1']); // enable for your remote IP
$configurator->enableDebugger(realpath(__DIR__.'/../log/'));
//$configurator->enableTracy(realpath(__DIR__ . '/../log'));

$configurator->setTimeZone('Europe/Prague');
$configurator->setTempDirectory(realpath(__DIR__ . '/../temp'));

$configurator->createRobotLoader()
	->addDirectory(__DIR__)
	->register();

$configurator->addConfig(__DIR__ . '/config/config.neon');
$configurator->addConfig(__DIR__ . '/config/config.local.neon');

$container = $configurator->createContainer();

return $container;
