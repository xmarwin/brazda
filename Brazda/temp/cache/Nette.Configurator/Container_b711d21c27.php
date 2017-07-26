<?php
// source: C:\Users\Martin\Source\Repos\Brazda\Brazda\app/config/config.neon 
// source: C:\Users\Martin\Source\Repos\Brazda\Brazda\app/config/config.local.neon 

class Container_b711d21c27 extends Nette\DI\Container
{
	protected $meta = [
		'types' => [
			'Nette\Application\Application' => [1 => ['application.application']],
			'Nette\Application\IPresenterFactory' => [1 => ['application.presenterFactory']],
			'Nette\Application\LinkGenerator' => [1 => ['application.linkGenerator']],
			'Nette\Caching\Storages\IJournal' => [1 => ['cache.journal']],
			'Nette\Caching\IStorage' => [1 => ['cache.storage']],
			'Nette\Http\RequestFactory' => [1 => ['http.requestFactory']],
			'Nette\Http\IRequest' => [1 => ['http.request']],
			'Nette\Http\Request' => [1 => ['http.request']],
			'Nette\Http\IResponse' => [1 => ['http.response']],
			'Nette\Http\Response' => [1 => ['http.response']],
			'Nette\Http\Context' => [1 => ['http.context']],
			'Nette\Bridges\ApplicationLatte\ILatteFactory' => [1 => ['latte.latteFactory']],
			'Nette\Application\UI\ITemplateFactory' => [1 => ['latte.templateFactory']],
			'Nette\Mail\IMailer' => [1 => ['mail.mailer']],
			'Nette\Application\IRouter' => [1 => ['routing.router']],
			'Nette\Security\IUserStorage' => [1 => ['security.userStorage']],
			'Nette\Security\User' => [1 => ['security.user']],
			'Nette\Http\Session' => [1 => ['session.session']],
			'Tracy\ILogger' => [1 => ['tracy.logger']],
			'Tracy\BlueScreen' => [1 => ['tracy.blueScreen']],
			'Tracy\Bar' => [1 => ['tracy.bar']],
			'Nette\Object' => [
				1 => [
					'restful.responseFactory',
					'restful.resourceFactory',
					'restful.methodOptions',
					'restful.xmlMapper',
					'restful.jsonMapper',
					'restful.queryMapper',
					'restful.dataUrlMapper',
					'restful.nullMapper',
					'restful.mapperContext',
					'restful.inputFactory',
					'restful.httpResponseFactory',
					'restful.requestFilter',
					'restful.methodHandler',
					'restful.validator',
					'restful.validationScopeFactory',
					'restful.validationScope',
					'restful.objectConverter',
					'restful.dateTimeConverter',
					'restful.camelCaseConverter',
					'restful.pascalCaseConverter',
					'restful.snakeCaseConverter',
					'restful.resourceConverter',
					'restful.security.hashCalculator',
					'restful.security.hashAuthenticator',
					'restful.security.timeoutAuthenticator',
					'restful.security.nullAuthentication',
					'restful.security.securedAuthentication',
					'restful.security.basicAuthentication',
					'restful.security.authentication',
					'restful.routeAnnotation',
					'restful.routeListFactory',
					'restful.cachedRouteListFactory',
					'restful.panel',
					'logins',
					'logs',
					'posts',
					'teams',
					'waypoints',
				],
			],
			'Drahak\Restful\Application\IResponseFactory' => [1 => ['restful.responseFactory']],
			'Drahak\Restful\Application\ResponseFactory' => [1 => ['restful.responseFactory']],
			'Drahak\Restful\IResourceFactory' => [1 => ['restful.resourceFactory']],
			'Drahak\Restful\ResourceFactory' => [1 => ['restful.resourceFactory']],
			'Drahak\Restful\IResource' => [1 => ['restful.resource']],
			'Drahak\Restful\Application\MethodOptions' => [1 => ['restful.methodOptions']],
			'Drahak\Restful\Mapping\IMapper' => [
				1 => [
					'restful.xmlMapper',
					'restful.jsonMapper',
					'restful.queryMapper',
					'restful.dataUrlMapper',
					'restful.nullMapper',
				],
			],
			'Drahak\Restful\Mapping\XmlMapper' => [1 => ['restful.xmlMapper']],
			'Drahak\Restful\Mapping\JsonMapper' => [1 => ['restful.jsonMapper']],
			'Drahak\Restful\Mapping\QueryMapper' => [1 => ['restful.queryMapper']],
			'Drahak\Restful\Mapping\DataUrlMapper' => [1 => ['restful.dataUrlMapper']],
			'Drahak\Restful\Mapping\NullMapper' => [1 => ['restful.nullMapper']],
			'Drahak\Restful\Mapping\MapperContext' => [1 => ['restful.mapperContext']],
			'Drahak\Restful\Http\InputFactory' => [1 => ['restful.inputFactory']],
			'Drahak\Restful\Http\ResponseFactory' => [1 => ['restful.httpResponseFactory']],
			'Drahak\Restful\Http\ApiRequestFactory' => [1 => ['restful.httpRequestFactory']],
			'Drahak\Restful\Utils\RequestFilter' => [1 => ['restful.requestFilter']],
			'Drahak\Restful\Application\Events\MethodHandler' => [1 => ['restful.methodHandler']],
			'Drahak\Restful\Validation\IValidator' => [1 => ['restful.validator']],
			'Drahak\Restful\Validation\Validator' => [1 => ['restful.validator']],
			'Drahak\Restful\Validation\IValidationScopeFactory' => [1 => ['restful.validationScopeFactory']],
			'Drahak\Restful\Validation\ValidationScopeFactory' => [1 => ['restful.validationScopeFactory']],
			'Drahak\Restful\Validation\IValidationScope' => [1 => ['restful.validationScope']],
			'Drahak\Restful\Validation\ValidationScope' => [1 => ['restful.validationScope']],
			'Drahak\Restful\Converters\IConverter' => [
				1 => [
					'restful.objectConverter',
					'restful.dateTimeConverter',
					'restful.camelCaseConverter',
					'restful.pascalCaseConverter',
					'restful.snakeCaseConverter',
				],
			],
			'Drahak\Restful\Converters\ObjectConverter' => [1 => ['restful.objectConverter']],
			'Drahak\Restful\Converters\DateTimeConverter' => [1 => ['restful.dateTimeConverter']],
			'Drahak\Restful\Converters\CamelCaseConverter' => [1 => ['restful.camelCaseConverter']],
			'Drahak\Restful\Converters\PascalCaseConverter' => [1 => ['restful.pascalCaseConverter']],
			'Drahak\Restful\Converters\SnakeCaseConverter' => [1 => ['restful.snakeCaseConverter']],
			'Drahak\Restful\Converters\ResourceConverter' => [1 => ['restful.resourceConverter']],
			'Drahak\Restful\Security\IAuthTokenCalculator' => [1 => ['restful.security.hashCalculator']],
			'Drahak\Restful\Security\HashCalculator' => [1 => ['restful.security.hashCalculator']],
			'Drahak\Restful\Security\Authentication\IRequestAuthenticator' => [
				1 => [
					'restful.security.hashAuthenticator',
					'restful.security.timeoutAuthenticator',
				],
			],
			'Drahak\Restful\Security\Authentication\HashAuthenticator' => [1 => ['restful.security.hashAuthenticator']],
			'Drahak\Restful\Security\Authentication\TimeoutAuthenticator' => [1 => ['restful.security.timeoutAuthenticator']],
			'Drahak\Restful\Security\Process\AuthenticationProcess' => [
				1 => [
					'restful.security.nullAuthentication',
					'restful.security.securedAuthentication',
					'restful.security.basicAuthentication',
				],
			],
			'Drahak\Restful\Security\Process\NullAuthentication' => [1 => ['restful.security.nullAuthentication']],
			'Drahak\Restful\Security\Process\SecuredAuthentication' => [1 => ['restful.security.securedAuthentication']],
			'Drahak\Restful\Security\Process\BasicAuthentication' => [1 => ['restful.security.basicAuthentication']],
			'Drahak\Restful\Security\AuthenticationContext' => [1 => ['restful.security.authentication']],
			'Drahak\Restful\Application\IAnnotationParser' => [1 => ['restful.routeAnnotation']],
			'Drahak\Restful\Application\RouteAnnotation' => [1 => ['restful.routeAnnotation']],
			'Drahak\Restful\Application\IRouteListFactory' => [1 => ['restful.routeListFactory', 'restful.cachedRouteListFactory']],
			'Drahak\Restful\Application\RouteListFactory' => [1 => ['restful.routeListFactory']],
			'Drahak\Restful\Application\CachedRouteListFactory' => [1 => ['restful.cachedRouteListFactory']],
			'Tracy\IBarPanel' => [1 => ['restful.panel', 'dibipanel']],
			'Drahak\Restful\Diagnostics\ResourceRouterPanel' => [1 => ['restful.panel']],
			'Dibi\Bridges\Tracy\Panel' => [1 => ['dibipanel']],
			'Dibi\Connection' => [1 => ['database']],
			'Brazda\Models\Base' => [1 => ['logins', 'logs', 'posts', 'teams', 'waypoints']],
			'Nette\Security\IAuthenticator' => [1 => ['logins']],
			'Brazda\Models\Logins' => [1 => ['logins']],
			'Brazda\Models\Logs' => [1 => ['logs']],
			'Brazda\Models\Posts' => [1 => ['posts']],
			'Brazda\Models\Teams' => [1 => ['teams']],
			'Brazda\Models\Waypoints' => [1 => ['waypoints']],
			'Drahak\Restful\Application\UI\ResourcePresenter' => [
				1 => [
					'application.1',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
				],
			],
			'Nette\Application\UI\Presenter' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\Application\UI\Control' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\Application\UI\Component' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\ComponentModel\Container' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\ComponentModel\Component' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Drahak\Restful\Application\IResourcePresenter' => [
				1 => [
					'application.1',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
				],
			],
			'Nette\Application\UI\IRenderable' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\ComponentModel\IContainer' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\ComponentModel\IComponent' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\Application\UI\ISignalReceiver' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\Application\UI\IStatePersistent' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'ArrayAccess' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.12',
				],
			],
			'Nette\Application\IPresenter' => [
				[
					'application.1',
					'application.2',
					'application.3',
					'application.4',
					'application.5',
					'application.6',
					'application.7',
					'application.8',
					'application.9',
					'application.10',
					'application.11',
					'application.12',
					'application.13',
					'application.14',
				],
			],
			'Brazda\Module\Api\Presenters\BasePresenter' => [1 => ['application.1', 'application.5']],
			'Brazda\Module\Base\Presenters\BasePresenter' => [1 => ['application.2', 'application.8']],
			'Brazda\Module\Api\Presenters\DefaultPresenter' => [1 => ['application.2']],
			'Brazda\Module\Api\Presenters\SecuredBasePresenter' => [1 => ['application.3', 'application.4', 'application.6']],
			'Drahak\Restful\Application\UI\SecuredResourcePresenter' => [1 => ['application.3', 'application.4', 'application.6']],
			'Brazda\Module\Api\Presenters\PostPresenter' => [1 => ['application.3']],
			'Brazda\Module\Api\Presenters\SignPresenter' => [1 => ['application.5']],
			'Brazda\Module\Api\Presenters\TeamPresenter' => [1 => ['application.6']],
			'Brazda\Module\Front\Presenters\BasePresenter' => [1 => ['application.7', 'application.9']],
			'Brazda\Module\Front\Presenters\DefaultPresenter' => [1 => ['application.8']],
			'Brazda\Module\Front\Presenters\SignPresenter' => [1 => ['application.9']],
			'App\Presenters\Error4xxPresenter' => [1 => ['application.10']],
			'App\Presenters\ErrorPresenter' => [1 => ['application.11']],
			'App\Presenters\HomepagePresenter' => [1 => ['application.12']],
			'NetteModule\ErrorPresenter' => [1 => ['application.13']],
			'NetteModule\MicroPresenter' => [1 => ['application.14']],
			'Nette\DI\Container' => [1 => ['container']],
		],
		'services' => [
			'application.1' => 'Brazda\Module\Api\Presenters\BasePresenter',
			'application.10' => 'App\Presenters\Error4xxPresenter',
			'application.11' => 'App\Presenters\ErrorPresenter',
			'application.12' => 'App\Presenters\HomepagePresenter',
			'application.13' => 'NetteModule\ErrorPresenter',
			'application.14' => 'NetteModule\MicroPresenter',
			'application.2' => 'Brazda\Module\Api\Presenters\DefaultPresenter',
			'application.3' => 'Brazda\Module\Api\Presenters\PostPresenter',
			'application.4' => 'Brazda\Module\Api\Presenters\SecuredBasePresenter',
			'application.5' => 'Brazda\Module\Api\Presenters\SignPresenter',
			'application.6' => 'Brazda\Module\Api\Presenters\TeamPresenter',
			'application.7' => 'Brazda\Module\Front\Presenters\BasePresenter',
			'application.8' => 'Brazda\Module\Front\Presenters\DefaultPresenter',
			'application.9' => 'Brazda\Module\Front\Presenters\SignPresenter',
			'application.application' => 'Nette\Application\Application',
			'application.linkGenerator' => 'Nette\Application\LinkGenerator',
			'application.presenterFactory' => 'Nette\Application\IPresenterFactory',
			'cache.journal' => 'Nette\Caching\Storages\IJournal',
			'cache.storage' => 'Nette\Caching\IStorage',
			'container' => 'Nette\DI\Container',
			'database' => 'Dibi\Connection',
			'dibipanel' => 'Dibi\Bridges\Tracy\Panel',
			'http.context' => 'Nette\Http\Context',
			'http.request' => 'Nette\Http\Request',
			'http.requestFactory' => 'Nette\Http\RequestFactory',
			'http.response' => 'Nette\Http\Response',
			'latte.latteFactory' => 'Latte\Engine',
			'latte.templateFactory' => 'Nette\Application\UI\ITemplateFactory',
			'logins' => 'Brazda\Models\Logins',
			'logs' => 'Brazda\Models\Logs',
			'mail.mailer' => 'Nette\Mail\IMailer',
			'posts' => 'Brazda\Models\Posts',
			'restful.cachedRouteListFactory' => 'Drahak\Restful\Application\CachedRouteListFactory',
			'restful.camelCaseConverter' => 'Drahak\Restful\Converters\CamelCaseConverter',
			'restful.dataUrlMapper' => 'Drahak\Restful\Mapping\DataUrlMapper',
			'restful.dateTimeConverter' => 'Drahak\Restful\Converters\DateTimeConverter',
			'restful.httpRequestFactory' => 'Drahak\Restful\Http\ApiRequestFactory',
			'restful.httpResponseFactory' => 'Drahak\Restful\Http\ResponseFactory',
			'restful.inputFactory' => 'Drahak\Restful\Http\InputFactory',
			'restful.jsonMapper' => 'Drahak\Restful\Mapping\JsonMapper',
			'restful.mapperContext' => 'Drahak\Restful\Mapping\MapperContext',
			'restful.methodHandler' => 'Drahak\Restful\Application\Events\MethodHandler',
			'restful.methodOptions' => 'Drahak\Restful\Application\MethodOptions',
			'restful.nullMapper' => 'Drahak\Restful\Mapping\NullMapper',
			'restful.objectConverter' => 'Drahak\Restful\Converters\ObjectConverter',
			'restful.panel' => 'Drahak\Restful\Diagnostics\ResourceRouterPanel',
			'restful.pascalCaseConverter' => 'Drahak\Restful\Converters\PascalCaseConverter',
			'restful.queryMapper' => 'Drahak\Restful\Mapping\QueryMapper',
			'restful.requestFilter' => 'Drahak\Restful\Utils\RequestFilter',
			'restful.resource' => 'Drahak\Restful\IResource',
			'restful.resourceConverter' => 'Drahak\Restful\Converters\ResourceConverter',
			'restful.resourceFactory' => 'Drahak\Restful\ResourceFactory',
			'restful.responseFactory' => 'Drahak\Restful\Application\ResponseFactory',
			'restful.routeAnnotation' => 'Drahak\Restful\Application\RouteAnnotation',
			'restful.routeListFactory' => 'Drahak\Restful\Application\RouteListFactory',
			'restful.security.authentication' => 'Drahak\Restful\Security\AuthenticationContext',
			'restful.security.basicAuthentication' => 'Drahak\Restful\Security\Process\BasicAuthentication',
			'restful.security.hashAuthenticator' => 'Drahak\Restful\Security\Authentication\HashAuthenticator',
			'restful.security.hashCalculator' => 'Drahak\Restful\Security\HashCalculator',
			'restful.security.nullAuthentication' => 'Drahak\Restful\Security\Process\NullAuthentication',
			'restful.security.securedAuthentication' => 'Drahak\Restful\Security\Process\SecuredAuthentication',
			'restful.security.timeoutAuthenticator' => 'Drahak\Restful\Security\Authentication\TimeoutAuthenticator',
			'restful.snakeCaseConverter' => 'Drahak\Restful\Converters\SnakeCaseConverter',
			'restful.validationScope' => 'Drahak\Restful\Validation\ValidationScope',
			'restful.validationScopeFactory' => 'Drahak\Restful\Validation\ValidationScopeFactory',
			'restful.validator' => 'Drahak\Restful\Validation\Validator',
			'restful.xmlMapper' => 'Drahak\Restful\Mapping\XmlMapper',
			'routing.router' => 'Nette\Application\IRouter',
			'security.user' => 'Nette\Security\User',
			'security.userStorage' => 'Nette\Security\IUserStorage',
			'session.session' => 'Nette\Http\Session',
			'teams' => 'Brazda\Models\Teams',
			'tracy.bar' => 'Tracy\Bar',
			'tracy.blueScreen' => 'Tracy\BlueScreen',
			'tracy.logger' => 'Tracy\ILogger',
			'waypoints' => 'Brazda\Models\Waypoints',
		],
		'tags' => [
			'inject' => [
				'application.1' => true,
				'application.10' => true,
				'application.11' => true,
				'application.12' => true,
				'application.13' => true,
				'application.14' => true,
				'application.2' => true,
				'application.3' => true,
				'application.4' => true,
				'application.5' => true,
				'application.6' => true,
				'application.7' => true,
				'application.8' => true,
				'application.9' => true,
			],
			'nette.presenter' => [
				'application.1' => 'Brazda\Module\Api\Presenters\BasePresenter',
				'application.10' => 'App\Presenters\Error4xxPresenter',
				'application.11' => 'App\Presenters\ErrorPresenter',
				'application.12' => 'App\Presenters\HomepagePresenter',
				'application.13' => 'NetteModule\ErrorPresenter',
				'application.14' => 'NetteModule\MicroPresenter',
				'application.2' => 'Brazda\Module\Api\Presenters\DefaultPresenter',
				'application.3' => 'Brazda\Module\Api\Presenters\PostPresenter',
				'application.4' => 'Brazda\Module\Api\Presenters\SecuredBasePresenter',
				'application.5' => 'Brazda\Module\Api\Presenters\SignPresenter',
				'application.6' => 'Brazda\Module\Api\Presenters\TeamPresenter',
				'application.7' => 'Brazda\Module\Front\Presenters\BasePresenter',
				'application.8' => 'Brazda\Module\Front\Presenters\DefaultPresenter',
				'application.9' => 'Brazda\Module\Front\Presenters\SignPresenter',
			],
			'restful.converter' => [
				'restful.camelCaseConverter' => true,
				'restful.dateTimeConverter' => true,
				'restful.objectConverter' => true,
			],
		],
		'aliases' => [
			'application' => 'application.application',
			'cacheStorage' => 'cache.storage',
			'httpRequest' => 'http.request',
			'httpResponse' => 'http.response',
			'nette.cacheJournal' => 'cache.journal',
			'nette.httpContext' => 'http.context',
			'nette.httpRequestFactory' => 'http.requestFactory',
			'nette.latteFactory' => 'latte.latteFactory',
			'nette.mailer' => 'mail.mailer',
			'nette.presenterFactory' => 'application.presenterFactory',
			'nette.templateFactory' => 'latte.templateFactory',
			'nette.userStorage' => 'security.userStorage',
			'router' => 'routing.router',
			'session' => 'session.session',
			'user' => 'security.user',
		],
	];


	public function __construct(array $params = [])
	{
		$this->parameters = $params;
		$this->parameters += [
			'appDir' => 'C:\Users\Martin\Source\Repos\Brazda\Brazda\app',
			'wwwDir' => 'C:\Users\Martin\Source\Repos\Brazda\Brazda\www',
			'debugMode' => true,
			'productionMode' => false,
			'consoleMode' => false,
			'tempDir' => 'C:\Users\Martin\Source\Repos\Brazda\Brazda\temp',
			'logInterval' => 5,
			'database' => [
				'driver' => 'postgre',
				'host' => '127.0.0.1',
				'user' => 'brazda',
				'password' => 'FzwtMS/jq.XSQ',
				'database' => 'brazda',
				'resultDetectTypes' => true,
				'profiler' => true,
			],
		];
	}


	/**
	 * @return Brazda\Module\Api\Presenters\BasePresenter
	 */
	public function createServiceApplication__1()
	{
		$service = new Brazda\Module\Api\Presenters\BasePresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->injectDrahakRestful($this->getService('restful.responseFactory'),
			$this->getService('restful.resourceFactory'), $this->getService('restful.security.authentication'),
			$this->getService('restful.inputFactory'), $this->getService('restful.requestFilter'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return App\Presenters\Error4xxPresenter
	 */
	public function createServiceApplication__10()
	{
		$service = new App\Presenters\Error4xxPresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return App\Presenters\ErrorPresenter
	 */
	public function createServiceApplication__11()
	{
		$service = new App\Presenters\ErrorPresenter($this->getService('tracy.logger'));
		return $service;
	}


	/**
	 * @return App\Presenters\HomepagePresenter
	 */
	public function createServiceApplication__12()
	{
		$service = new App\Presenters\HomepagePresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return NetteModule\ErrorPresenter
	 */
	public function createServiceApplication__13()
	{
		$service = new NetteModule\ErrorPresenter($this->getService('tracy.logger'));
		return $service;
	}


	/**
	 * @return NetteModule\MicroPresenter
	 */
	public function createServiceApplication__14()
	{
		$service = new NetteModule\MicroPresenter($this, $this->getService('http.request'),
			$this->getService('routing.router'));
		return $service;
	}


	/**
	 * @return Brazda\Module\Api\Presenters\DefaultPresenter
	 */
	public function createServiceApplication__2()
	{
		$service = new Brazda\Module\Api\Presenters\DefaultPresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Brazda\Module\Api\Presenters\PostPresenter
	 */
	public function createServiceApplication__3()
	{
		$service = new Brazda\Module\Api\Presenters\PostPresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->injectDrahakRestful($this->getService('restful.responseFactory'),
			$this->getService('restful.resourceFactory'), $this->getService('restful.security.authentication'),
			$this->getService('restful.inputFactory'), $this->getService('restful.requestFilter'));
		$service->injectBasicAuthentication($this->getService('restful.security.basicAuthentication'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Brazda\Module\Api\Presenters\SecuredBasePresenter
	 */
	public function createServiceApplication__4()
	{
		$service = new Brazda\Module\Api\Presenters\SecuredBasePresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->injectDrahakRestful($this->getService('restful.responseFactory'),
			$this->getService('restful.resourceFactory'), $this->getService('restful.security.authentication'),
			$this->getService('restful.inputFactory'), $this->getService('restful.requestFilter'));
		$service->injectBasicAuthentication($this->getService('restful.security.basicAuthentication'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Brazda\Module\Api\Presenters\SignPresenter
	 */
	public function createServiceApplication__5()
	{
		$service = new Brazda\Module\Api\Presenters\SignPresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->injectDrahakRestful($this->getService('restful.responseFactory'),
			$this->getService('restful.resourceFactory'), $this->getService('restful.security.authentication'),
			$this->getService('restful.inputFactory'), $this->getService('restful.requestFilter'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Brazda\Module\Api\Presenters\TeamPresenter
	 */
	public function createServiceApplication__6()
	{
		$service = new Brazda\Module\Api\Presenters\TeamPresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->injectDrahakRestful($this->getService('restful.responseFactory'),
			$this->getService('restful.resourceFactory'), $this->getService('restful.security.authentication'),
			$this->getService('restful.inputFactory'), $this->getService('restful.requestFilter'));
		$service->injectBasicAuthentication($this->getService('restful.security.basicAuthentication'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Brazda\Module\Front\Presenters\BasePresenter
	 */
	public function createServiceApplication__7()
	{
		$service = new Brazda\Module\Front\Presenters\BasePresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Brazda\Module\Front\Presenters\DefaultPresenter
	 */
	public function createServiceApplication__8()
	{
		$service = new Brazda\Module\Front\Presenters\DefaultPresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Brazda\Module\Front\Presenters\SignPresenter
	 */
	public function createServiceApplication__9()
	{
		$service = new Brazda\Module\Front\Presenters\SignPresenter;
		$service->injectPrimary($this, $this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'), $this->getService('session.session'),
			$this->getService('security.user'), $this->getService('latte.templateFactory'));
		$service->invalidLinkMode = 5;
		return $service;
	}


	/**
	 * @return Nette\Application\Application
	 */
	public function createServiceApplication__application()
	{
		$service = new Nette\Application\Application($this->getService('application.presenterFactory'),
			$this->getService('routing.router'), $this->getService('http.request'),
			$this->getService('http.response'));
		$service->catchExceptions = false;
		$service->errorPresenter = 'Error';
		Nette\Bridges\ApplicationTracy\RoutingPanel::initializePanel($service);
		$service->onStartup[] = [$this->getService('restful.methodHandler'), 'run'];
		$service->onError[] = [$this->getService('restful.methodHandler'), 'error'];
		$service->onStartup[] = [$this->getService('restful.panel'), 'getTab'];
		$this->getService('tracy.bar')->addPanel(new Nette\Bridges\ApplicationTracy\RoutingPanel($this->getService('routing.router'),
			$this->getService('http.request'), $this->getService('application.presenterFactory')));
		return $service;
	}


	/**
	 * @return Nette\Application\LinkGenerator
	 */
	public function createServiceApplication__linkGenerator()
	{
		$service = new Nette\Application\LinkGenerator($this->getService('routing.router'),
			$this->getService('http.request')->getUrl(), $this->getService('application.presenterFactory'));
		return $service;
	}


	/**
	 * @return Nette\Application\IPresenterFactory
	 */
	public function createServiceApplication__presenterFactory()
	{
		$service = new Nette\Application\PresenterFactory(new Nette\Bridges\ApplicationDI\PresenterFactoryCallback($this, 5, 'C:\Users\Martin\Source\Repos\Brazda\Brazda\temp/cache/Nette%5CBridges%5CApplicationDI%5CApplicationExtension'));
		$service->setMapping(['*' => 'Brazda\Module\*\Presenters\*Presenter']);
		return $service;
	}


	/**
	 * @return Nette\Caching\Storages\IJournal
	 */
	public function createServiceCache__journal()
	{
		$service = new Nette\Caching\Storages\SQLiteJournal('C:\Users\Martin\Source\Repos\Brazda\Brazda\temp/cache/journal.s3db');
		return $service;
	}


	/**
	 * @return Nette\Caching\IStorage
	 */
	public function createServiceCache__storage()
	{
		$service = new Nette\Caching\Storages\FileStorage('C:\Users\Martin\Source\Repos\Brazda\Brazda\temp/cache',
			$this->getService('cache.journal'));
		return $service;
	}


	/**
	 * @return Nette\DI\Container
	 */
	public function createServiceContainer()
	{
		return $this;
	}


	/**
	 * @return Dibi\Connection
	 */
	public function createServiceDatabase()
	{
		$service = new Dibi\Connection([
			'driver' => 'postgre',
			'host' => '127.0.0.1',
			'user' => 'brazda',
			'password' => 'FzwtMS/jq.XSQ',
			'database' => 'brazda',
			'resultDetectTypes' => true,
			'profiler' => true,
		]);
		return $service;
	}


	/**
	 * @return Dibi\Bridges\Tracy\Panel
	 */
	public function createServiceDibipanel()
	{
		$service = new Dibi\Bridges\Tracy\Panel;
		return $service;
	}


	/**
	 * @return Nette\Http\Context
	 */
	public function createServiceHttp__context()
	{
		$service = new Nette\Http\Context($this->getService('http.request'), $this->getService('http.response'));
		trigger_error('Service http.context is deprecated.', 16384);
		return $service;
	}


	/**
	 * @return Nette\Http\Request
	 */
	public function createServiceHttp__request()
	{
		$service = $this->getService('restful.httpRequestFactory')->createHttpRequest();
		if (!$service instanceof Nette\Http\Request) {
			throw new Nette\UnexpectedValueException('Unable to create service \'http.request\', value returned by factory is not Nette\Http\Request type.');
		}
		return $service;
	}


	/**
	 * @return Nette\Http\RequestFactory
	 */
	public function createServiceHttp__requestFactory()
	{
		$service = new Nette\Http\RequestFactory;
		$service->setProxy([]);
		return $service;
	}


	/**
	 * @return Nette\Http\Response
	 */
	public function createServiceHttp__response()
	{
		$service = $this->getService('restful.httpResponseFactory')->createHttpResponse();
		if (!$service instanceof Nette\Http\Response) {
			throw new Nette\UnexpectedValueException('Unable to create service \'http.response\', value returned by factory is not Nette\Http\Response type.');
		}
		return $service;
	}


	/**
	 * @return Nette\Bridges\ApplicationLatte\ILatteFactory
	 */
	public function createServiceLatte__latteFactory()
	{
		return new Container_b711d21c27_Nette_Bridges_ApplicationLatte_ILatteFactoryImpl_latte_latteFactory($this);
	}


	/**
	 * @return Nette\Application\UI\ITemplateFactory
	 */
	public function createServiceLatte__templateFactory()
	{
		$service = new Nette\Bridges\ApplicationLatte\TemplateFactory($this->getService('latte.latteFactory'),
			$this->getService('http.request'), $this->getService('security.user'),
			$this->getService('cache.storage'), null);
		return $service;
	}


	/**
	 * @return Brazda\Models\Logins
	 */
	public function createServiceLogins()
	{
		$service = new Brazda\Models\Logins($this);
		return $service;
	}


	/**
	 * @return Brazda\Models\Logs
	 */
	public function createServiceLogs()
	{
		$service = new Brazda\Models\Logs($this);
		return $service;
	}


	/**
	 * @return Nette\Mail\IMailer
	 */
	public function createServiceMail__mailer()
	{
		$service = new Nette\Mail\SendmailMailer;
		return $service;
	}


	/**
	 * @return Brazda\Models\Posts
	 */
	public function createServicePosts()
	{
		$service = new Brazda\Models\Posts($this);
		return $service;
	}


	/**
	 * @return Drahak\Restful\Application\CachedRouteListFactory
	 */
	public function createServiceRestful__cachedRouteListFactory()
	{
		$service = new Drahak\Restful\Application\CachedRouteListFactory('C:\Users\Martin\Source\Repos\Brazda\Brazda\app',
			$this->getService('restful.routeListFactory'), $this->getService('cache.storage'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Converters\CamelCaseConverter
	 */
	public function createServiceRestful__camelCaseConverter()
	{
		$service = new Drahak\Restful\Converters\CamelCaseConverter;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Mapping\DataUrlMapper
	 */
	public function createServiceRestful__dataUrlMapper()
	{
		$service = new Drahak\Restful\Mapping\DataUrlMapper;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Converters\DateTimeConverter
	 */
	public function createServiceRestful__dateTimeConverter()
	{
		$service = new Drahak\Restful\Converters\DateTimeConverter('c');
		return $service;
	}


	/**
	 * @return Drahak\Restful\Http\ApiRequestFactory
	 */
	public function createServiceRestful__httpRequestFactory()
	{
		$service = new Drahak\Restful\Http\ApiRequestFactory($this->getService('http.requestFactory'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Http\ResponseFactory
	 */
	public function createServiceRestful__httpResponseFactory()
	{
		$service = new Drahak\Restful\Http\ResponseFactory($this->getService('http.request'),
			$this->getService('restful.requestFilter'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Http\InputFactory
	 */
	public function createServiceRestful__inputFactory()
	{
		$service = new Drahak\Restful\Http\InputFactory($this->getService('http.request'), $this->getService('restful.mapperContext'),
			$this->getService('restful.validationScopeFactory'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Mapping\JsonMapper
	 */
	public function createServiceRestful__jsonMapper()
	{
		$service = new Drahak\Restful\Mapping\JsonMapper;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Mapping\MapperContext
	 */
	public function createServiceRestful__mapperContext()
	{
		$service = new Drahak\Restful\Mapping\MapperContext;
		$service->addMapper('application/xml', $this->getService('restful.xmlMapper'));
		$service->addMapper('application/json', $this->getService('restful.jsonMapper'));
		$service->addMapper('application/javascript', $this->getService('restful.jsonMapper'));
		$service->addMapper('application/x-www-form-urlencoded', $this->getService('restful.queryMapper'));
		$service->addMapper('application/x-data-url', $this->getService('restful.dataUrlMapper'));
		$service->addMapper('application/octet-stream', $this->getService('restful.nullMapper'));
		$service->addMapper(null, $this->getService('restful.nullMapper'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Application\Events\MethodHandler
	 */
	public function createServiceRestful__methodHandler()
	{
		$service = new Drahak\Restful\Application\Events\MethodHandler($this->getService('http.request'),
			$this->getService('http.response'), $this->getService('restful.methodOptions'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Application\MethodOptions
	 */
	public function createServiceRestful__methodOptions()
	{
		$service = new Drahak\Restful\Application\MethodOptions($this->getService('routing.router'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Mapping\NullMapper
	 */
	public function createServiceRestful__nullMapper()
	{
		$service = new Drahak\Restful\Mapping\NullMapper;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Converters\ObjectConverter
	 */
	public function createServiceRestful__objectConverter()
	{
		$service = new Drahak\Restful\Converters\ObjectConverter;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Diagnostics\ResourceRouterPanel
	 */
	public function createServiceRestful__panel()
	{
		$service = new Drahak\Restful\Diagnostics\ResourceRouterPanel(null, 'timestamp', $this->getService('routing.router'));
		Nette\Diagnostics\Debugger::getBar()->addPanel($service);
		return $service;
	}


	/**
	 * @return Drahak\Restful\Converters\PascalCaseConverter
	 */
	public function createServiceRestful__pascalCaseConverter()
	{
		$service = new Drahak\Restful\Converters\PascalCaseConverter;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Mapping\QueryMapper
	 */
	public function createServiceRestful__queryMapper()
	{
		$service = new Drahak\Restful\Mapping\QueryMapper;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Utils\RequestFilter
	 */
	public function createServiceRestful__requestFilter()
	{
		$service = new Drahak\Restful\Utils\RequestFilter($this->getService('http.request'),
			['jsonp', 'pretty']);
		return $service;
	}


	/**
	 * @return Drahak\Restful\IResource
	 */
	public function createServiceRestful__resource()
	{
		$service = $this->getService('restful.resourceFactory')->create();
		if (!$service instanceof Drahak\Restful\IResource) {
			throw new Nette\UnexpectedValueException('Unable to create service \'restful.resource\', value returned by factory is not Drahak\Restful\IResource type.');
		}
		return $service;
	}


	/**
	 * @return Drahak\Restful\Converters\ResourceConverter
	 */
	public function createServiceRestful__resourceConverter()
	{
		$service = new Drahak\Restful\Converters\ResourceConverter;
		$service->addConverter($this->getService('restful.objectConverter'));
		$service->addConverter($this->getService('restful.dateTimeConverter'));
		$service->addConverter($this->getService('restful.camelCaseConverter'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\ResourceFactory
	 */
	public function createServiceRestful__resourceFactory()
	{
		$service = new Drahak\Restful\ResourceFactory($this->getService('http.request'), $this->getService('restful.resourceConverter'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Application\ResponseFactory
	 */
	public function createServiceRestful__responseFactory()
	{
		$service = new Drahak\Restful\Application\ResponseFactory($this->getService('http.response'),
			$this->getService('http.request'), $this->getService('restful.mapperContext'));
		$service->setJsonp('jsonp');
		$service->setPrettyPrintKey('pretty');
		$service->setPrettyPrint(true);
		return $service;
	}


	/**
	 * @return Drahak\Restful\Application\RouteAnnotation
	 */
	public function createServiceRestful__routeAnnotation()
	{
		$service = new Drahak\Restful\Application\RouteAnnotation;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Application\RouteListFactory
	 */
	public function createServiceRestful__routeListFactory()
	{
		$service = new Drahak\Restful\Application\RouteListFactory('C:\Users\Martin\Source\Repos\Brazda\Brazda\app',
			true, $this->getService('cache.storage'), $this->getService('restful.routeAnnotation'));
		$service->setModule('Api');
		$service->setPrefix('');
		return $service;
	}


	/**
	 * @return Drahak\Restful\Security\AuthenticationContext
	 */
	public function createServiceRestful__security__authentication()
	{
		$service = new Drahak\Restful\Security\AuthenticationContext;
		$service->setAuthProcess($this->getService('restful.security.nullAuthentication'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Security\Process\BasicAuthentication
	 */
	public function createServiceRestful__security__basicAuthentication()
	{
		$service = new Drahak\Restful\Security\Process\BasicAuthentication($this->getService('security.user'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Security\Authentication\HashAuthenticator
	 */
	public function createServiceRestful__security__hashAuthenticator()
	{
		$service = new Drahak\Restful\Security\Authentication\HashAuthenticator(null, $this->getService('http.request'),
			$this->getService('restful.security.hashCalculator'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Security\HashCalculator
	 */
	public function createServiceRestful__security__hashCalculator()
	{
		$service = new Drahak\Restful\Security\HashCalculator($this->getService('restful.mapperContext'),
			$this->getService('http.request'));
		$service->setPrivateKey(null);
		return $service;
	}


	/**
	 * @return Drahak\Restful\Security\Process\NullAuthentication
	 */
	public function createServiceRestful__security__nullAuthentication()
	{
		$service = new Drahak\Restful\Security\Process\NullAuthentication;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Security\Process\SecuredAuthentication
	 */
	public function createServiceRestful__security__securedAuthentication()
	{
		$service = new Drahak\Restful\Security\Process\SecuredAuthentication($this->getService('restful.security.hashAuthenticator'),
			$this->getService('restful.security.timeoutAuthenticator'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Security\Authentication\TimeoutAuthenticator
	 */
	public function createServiceRestful__security__timeoutAuthenticator()
	{
		$service = new Drahak\Restful\Security\Authentication\TimeoutAuthenticator('timestamp',
			300);
		return $service;
	}


	/**
	 * @return Drahak\Restful\Converters\SnakeCaseConverter
	 */
	public function createServiceRestful__snakeCaseConverter()
	{
		$service = new Drahak\Restful\Converters\SnakeCaseConverter;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Validation\ValidationScope
	 */
	public function createServiceRestful__validationScope()
	{
		$service = $this->getService('restful.validationScopeFactory')->create();
		if (!$service instanceof Drahak\Restful\Validation\ValidationScope) {
			throw new Nette\UnexpectedValueException('Unable to create service \'restful.validationScope\', value returned by factory is not Drahak\Restful\Validation\ValidationScope type.');
		}
		return $service;
	}


	/**
	 * @return Drahak\Restful\Validation\ValidationScopeFactory
	 */
	public function createServiceRestful__validationScopeFactory()
	{
		$service = new Drahak\Restful\Validation\ValidationScopeFactory($this->getService('restful.validator'));
		return $service;
	}


	/**
	 * @return Drahak\Restful\Validation\Validator
	 */
	public function createServiceRestful__validator()
	{
		$service = new Drahak\Restful\Validation\Validator;
		return $service;
	}


	/**
	 * @return Drahak\Restful\Mapping\XmlMapper
	 */
	public function createServiceRestful__xmlMapper()
	{
		$service = new Drahak\Restful\Mapping\XmlMapper;
		return $service;
	}


	/**
	 * @return Nette\Application\IRouter
	 */
	public function createServiceRouting__router()
	{
		$service = Brazda\RouterFactory::createRouter();
		if (!$service instanceof Nette\Application\IRouter) {
			throw new Nette\UnexpectedValueException('Unable to create service \'routing.router\', value returned by factory is not Nette\Application\IRouter type.');
		}
		$service->offsetSet(null, $this->getService('restful.cachedRouteListFactory')->create());
		return $service;
	}


	/**
	 * @return Nette\Security\User
	 */
	public function createServiceSecurity__user()
	{
		$service = new Nette\Security\User($this->getService('security.userStorage'), $this->getService('logins'));
		$this->getService('tracy.bar')->addPanel(new Nette\Bridges\SecurityTracy\UserPanel($service));
		return $service;
	}


	/**
	 * @return Nette\Security\IUserStorage
	 */
	public function createServiceSecurity__userStorage()
	{
		$service = new Nette\Http\UserStorage($this->getService('session.session'));
		return $service;
	}


	/**
	 * @return Nette\Http\Session
	 */
	public function createServiceSession__session()
	{
		$service = new Nette\Http\Session($this->getService('http.request'), $this->getService('http.response'));
		$service->setExpiration('14 days');
		return $service;
	}


	/**
	 * @return Brazda\Models\Teams
	 */
	public function createServiceTeams()
	{
		$service = new Brazda\Models\Teams($this);
		return $service;
	}


	/**
	 * @return Tracy\Bar
	 */
	public function createServiceTracy__bar()
	{
		$service = Tracy\Debugger::getBar();
		if (!$service instanceof Tracy\Bar) {
			throw new Nette\UnexpectedValueException('Unable to create service \'tracy.bar\', value returned by factory is not Tracy\Bar type.');
		}
		$this->getService('dibipanel')->register($this->getService('database'));
		return $service;
	}


	/**
	 * @return Tracy\BlueScreen
	 */
	public function createServiceTracy__blueScreen()
	{
		$service = Tracy\Debugger::getBlueScreen();
		if (!$service instanceof Tracy\BlueScreen) {
			throw new Nette\UnexpectedValueException('Unable to create service \'tracy.blueScreen\', value returned by factory is not Tracy\BlueScreen type.');
		}
		return $service;
	}


	/**
	 * @return Tracy\ILogger
	 */
	public function createServiceTracy__logger()
	{
		$service = Tracy\Debugger::getLogger();
		if (!$service instanceof Tracy\ILogger) {
			throw new Nette\UnexpectedValueException('Unable to create service \'tracy.logger\', value returned by factory is not Tracy\ILogger type.');
		}
		return $service;
	}


	/**
	 * @return Brazda\Models\Waypoints
	 */
	public function createServiceWaypoints()
	{
		$service = new Brazda\Models\Waypoints($this);
		return $service;
	}


	public function initialize()
	{
		ini_set('zlib.output_compression', true);
		$this->getService('tracy.bar')->addPanel(new Nette\Bridges\DITracy\ContainerPanel($this));
		$this->getService('http.response')->setHeader('X-Powered-By', 'Nette Framework');
		$this->getService('http.response')->setHeader('Content-Type', 'text/html; charset=utf-8');
		$this->getService('http.response')->setHeader('X-Frame-Options', 'SAMEORIGIN');
		$this->getService('session.session')->exists() && $this->getService('session.session')->start();
		Tracy\Debugger::$editorMapping = [];
		Tracy\Debugger::setLogger($this->getService('tracy.logger'));
		if ($tmp = $this->getByType("Nette\Http\Session", false)) { $tmp->start(); Tracy\Debugger::dispatch(); };
	}
}



class Container_b711d21c27_Nette_Bridges_ApplicationLatte_ILatteFactoryImpl_latte_latteFactory implements Nette\Bridges\ApplicationLatte\ILatteFactory
{
	private $container;


	public function __construct(Container_b711d21c27 $container)
	{
		$this->container = $container;
	}


	public function create()
	{
		$service = new Latte\Engine;
		$service->setTempDirectory('C:\Users\Martin\Source\Repos\Brazda\Brazda\temp/cache/latte');
		$service->setAutoRefresh(true);
		$service->setContentType('html');
		Nette\Utils\Html::$xhtml = false;
		return $service;
	}
}
