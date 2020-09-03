<?php

require __DIR__ . '/../vendor/autoload.php';

$configurator = new Nette\Configurator;

$configurator->setDebugMode([
	'127.0.0.1',
	'79.127.215.114',
	'213.194.221.57',
	'213.194.220.50',
	'213.194.220.50',
	'::1',
	'2001:470:1f0b:3ff:12c3:7bff:fea2:7f2b',
	'2a0a:1c01:0:1002:d4f5:e0ac:c817:7834',
	'2a0a:1c01:0:1405:a8cf:efff:fe07:4e30',
	'2a0a:1c01:0:1405:aa5e:45ff:fee1:8899'
]); // enable for your remote IP
$configurator->enableDebugger(realpath(__DIR__.'/../log/'));

$configurator->setTimeZone('Europe/Prague');
$configurator->setTempDirectory(realpath(__DIR__ . '/../temp'));

$configurator->createRobotLoader()
	->addDirectory(__DIR__)
	->register();

$configurator->addConfig(__DIR__ . '/config/config.neon');
$configurator->addConfig(__DIR__ . '/config/config.local.neon');

$container = $configurator->createContainer();

return $container;
