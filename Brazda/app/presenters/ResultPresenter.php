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
	$settings,
        $teams;

    public function startup()
    {
        parent::startup();

        $this->logs     = $this->context->getService('logs');
        $this->posts    = $this->context->getService('posts');
        $this->results  = $this->context->getService('results');
        $this->settings = $this->context->getService('settings');
        $this->teams    = $this->context->getService('teams');
    } // startup()

    /** ZASTARALE */
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

    public function actionCom($format = 'json')
    {
        $this->checkAdministrator();

        if (!$this->checkFormat($format)) {
            $this->sendErrorResource(new \Exception(sprintf('Neznámý formát odpovědi %s', $format), 400));
        } // if

        switch ($format) {
             case 'csv':
             case 'xls':
             case 'html':
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

    public function actionKid($format = 'json')
    {
        $this->checkAdministrator();

        if (!$this->checkFormat($format)) {
            $this->sendErrorResource(new \Exception(sprintf('Neznámý formát odpovědi %s', $format), 400));
        } // if

        switch ($format) {
             case 'csv':
             case 'xls':
             case 'html':
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
        return in_array(strtolower($format), [ 'json', 'csv', 'xls', 'html' ]);
    } // checkFormat()

   private function getResultsResponse(string $format, array $result): object
   {
       $format = strtolower($format);
       $templateFile = __DIR__."/templates/Result/{$format}Format.latte";
       if (!file_exists($templateFile)) {
           throw new \Exception(sprintf("Šablona pro formát %s nebyla nalezna, asi to zatím není implementováno", $format), 500);
       } // if

       $params = $this->context->getParameters();
       $settings = $this->settings->enumeration();

       $latte = new Latte\Engine;
       $latte->setTempDirectory(__DIR__.'/../../temp/cache/latte/');

       $data = [
           'result'   => $result,
           'params'   => $params,
           'settings' => $settings
       ];

       $contentTypes = [
           'csv' => 'text/csv',
	   'xls' => 'application/vnd.ms-excel'
       ];

       switch ($format) {
           case 'csv':
           case 'xls':
               $tempFile = tempnam(__DIR__.'/../../temp/', "{$format}_");
               file_put_contents($tempFile, $latte->renderToString($templateFile, $data));

               return new Responses\FileResponse($tempFile, "results.{$format}", $contentTypes[$format]);
               break;

           case 'html':

               return new Responses\TextResponse($latte->renderToString($templateFile, $data));
               break;
       } // switch
   } // getResultsResponse()

} // ResultPresenter
