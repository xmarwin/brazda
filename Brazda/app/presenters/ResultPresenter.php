<?php

namespace Brazda\Presenters;

use Latte,
    Nette\Application\Responses,
    Nette\Security,
    Brazda\Models,
    Drahak\Restful\Validation;

class ResultPresenter extends SecuredBasePresenter
{
    protected
        $logs,
	$posts,
	$results,
        $teams;

    public function startup()
    {
        parent::startup();

        $this->logs     = $this->context->getService('logs');
        $this->posts    = $this->context->getService('posts');
        $this->results  = $this->context->getService('results');
        $this->teams    = $this->context->getService('teams');
    } // startup()

    /** ZASTARALE */
/*
    public function actionList()
    {
        $this->checkAdministrator();

        $teams = [];
        $teamsData = (array) $this->teams->view(['t.team_type' => 'COM']);
        foreach ($teamsData as $teamItem) {
            $team = [
                'team' => $teamItem->team,
                'name' => $teamItem->name,
                'logs' => []
            ];
            $team['logs'] = $this->logs->resultView([
                'team' => $teamItem->team
            ])->fetchAll();

            $teams[] = $team;
        } // foreach

        $this->resource = $teams;
        $this->sendResource();
    } // actionList()

    /** ZASTARALE */
/*
    public function actionListKid()
    {
        $this->checkAdministrator();

        $teams = [];
        $teamsData = (array) $this->teams->view(['t.team_type' => 'KID']);
        foreach ($teamsData as $teamItem) {
            $team = [
                'team' => $teamItem->team,
                'name' => $teamItem->name,
                'logs' => []
            ];
            $team['logs'] = $this->logs->resultView([
                'team' => $teamItem->team
            ])->fetchAll();

            $teams[] = $team;
        } // foreach

        $this->resource = $teams;
        $this->sendResource();
    } // actionListKid()

    /** ZASTARALE */
/*
    public function actionListAll()
    {
        $this->checkAdministrator();

        $teams = [];
        $teamsData = (array) $this->teams->view([ ['t.team_type IN %in', [ 'COM', 'KID' ] ] ]);
        foreach ($teamsData as $teamItem) {
            $team = [
                'team' => $teamItem->team,
                'name' => $teamItem->name,
                'logs' => []
            ];
            $team['logs'] = $this->logs->resultView([
                'team' => $teamItem->team
            ])->fetchAll();

            $teams[] = $team;
        } // foreach

        $this->resource = $teams;
        $this->sendResource();
    } // actionListAll()
*/
    /**
     * Vrací výsledky závodu pro dospělé týmy
     */
    public function actionCom(string $format = 'json')
    {
        $this->checkAdministrator();

        if (!$this->checkFormat($format)) {
            $this->sendErrorResource(new \Exception(sprintf('Neznámý formát odpovědi %s', $format), 400));
        } // if

        switch ($format) {
             case 'xls':
             case 'html':
             case 'webHtml':
                try {
                    $response = $this->getResultsResponse($format, $this->results->resultsView('COM'));
                } catch (\Exception $e) {
                    $this->sendErrorResource($e);
                } // try
                $this->sendResponse($response);
	        break;

             case 'json':
             default:
                $this->resource = $this->results->resultsView('COM');
                $this->sendResource();
                break;
	} // switch
    } // actionCom()

    /**
     * Vrací výsledky závodu pro dětské týmy
     */
    public function actionKid(string $format = 'json')
    {
        $this->checkAdministrator();

        if (!$this->checkFormat($format)) {
            $this->sendErrorResource(new \Exception(sprintf('Neznámý formát odpovědi %s', $format), 400));
        } // if

        switch ($format) {
             case 'xls':
             case 'html':
             case 'webHtml':
                try {
                    $response = $this->getResultsResponse($format, $this->results->resultsView('KID'));
                } catch (\Exception $e) {
                    $this->sendErrorResource($e);
                } // try
                $this->sendResponse($response);
	        break;

             case 'json':
             default:
                $this->resource = $this->results->resultsView('KID');
                $this->sendResource();
                break;
	} // switch
    } // actionCom()

    private function checkFormat(string $format): bool
    {
        return in_array(strtolower($format), [ 'json', 'csv', 'xls', 'html', 'webhtml' ]);
    } // checkFormat()

   private function getResultsResponse(string $format, array $result): object
   {
       $format = strtolower($format);
       $templateFile = __DIR__."/templates/Result/{$format}Format.latte";
       if (!file_exists($templateFile)) {
           throw new \Exception(sprintf("Šablona pro formát %s nebyla nalezna, asi to zatím není implementováno", $format), 500);
       } // if

       $latte = new Latte\Engine;
       $latte->setTempDirectory(__DIR__.'/../../temp/cache/latte/');

       $contentTypes = [
	   'xls' => 'application/vnd.ms-excel'
       ];

       switch ($format) {
           case 'xls':
               $tempFile = tempnam(__DIR__.'/../../temp/', "{$format}_");
               file_put_contents($tempFile, $latte->renderToString($templateFile, [ 'results' => $result ]));

               return new Responses\FileResponse($tempFile, "results.{$format}", $contentTypes[$format]);
               break;

           case 'html':
           case 'webhtml':

               return new Responses\TextResponse($latte->renderToString($templateFile, [ 'results' => $result, 'posts' => $this->posts->view()->fetchAll() ]));
               break;
       } // switch
   } // getResultsResponse()

} // ResultPresenter
