<?php

namespace Brazda\Tests\Presenters;

use Nette\Application,
    Tester\Assert;

require __DIR__.'/../bootstrap.php';
require __DIR__.'/../RoleAnonCase.php';

class AnonTest extends RoleAnonCase
{
    protected
        $presenter;

    public function setUp()
    {
        $this->presenter = $this->getPresenter('Sign');
    } // setUp()

    public function testTeamsList()
    {
        $response = $this->presenter->run(
            $this->createRequest('teamsList')
        ); // run()
        Assert::type('Drahak\Restful\Application\Responses\TextResponse', $response);
        Assert::same('application/json', $response->getContentType());

        $responseData = $response->getData();
        Assert::type('array', $responseData);
        if (count($responseData) < 1) {
            Assert::fail('No items in teams list.', count($responseData), '> 0');
        }

        foreach ($responseData as $item) {
            Assert::type('array',  $item);

            Assert::type('int',    $item['team']);

            Assert::type('string', $item['teamType']);
            if (!in_array($item['teamType'], ['COM', 'ORG'])) {
                Assert::fail('Unexpected team type.', $item['teamType']);
            } // if

            Assert::type('string', $item['name']);
        } // foreach

        Assert::true(true);
    } // testTeamsList()

} // AnonTest

(new AnonTest($container))->run();
/*
$presenter = $presenterFactory->createPresenter('Sign');
$presenter->autoCanonicalize = false;
*//*
$presenter = getPresenter('Sign');
function testTeamList()
{
	global $presenter;
/*
	$request = new Application\Request('teamsList', 'GET');
*//*
	$request = createRequest('teamsList');
	$response = $presenter->run($request);

	var_dump($response);
	Assert::fail((string) $response);
	Assert::fail('blbe!');
} // testTeamList()

testTeamList();
*/
