<?php

namespace Brazda\Presenters;

use Nette\Security,
    Brazda\Models,
    Drahak\Restful\Validation;

class ResultPresenter extends SecuredBasePresenter
{
    protected
        $logs,
        $teams;

    public function startup()
    {
        parent::startup();

        $this->logs  = $this->context->getService('logs');
        $this->teams = $this->context->getService('teams');
    } // startup()

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
                'team' => $teamItem->team,
            ])->fetchAll();

            $teams[] = $team;
        } // foreach

        $this->resource = $teams;
        $this->sendResource($this->outputType);
    } // actionList()
} // ResultPresenter
