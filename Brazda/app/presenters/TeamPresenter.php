<?php

namespace Brazda\Presenters;

use Nette\Security;

class TeamPresenter extends SecuredBasePresenter
{
    protected
        $teams;

    public function startup()
    {
        parent::startup();

        $this->teams = $this->context->getService('teams');
    } // startup()

	public function actionList(array $filter = [], array $order = [])
	{
		$viewFilter = [];
		if (isset($filter['role']) && !empty($filter['role'])) {
			$roles = explode(',', $filter['role']);
			$viewFilter[] = [ 't.team_type IN %in', $roles ];
		} // if

		if (isset($filter['status']) && !empty($filter['status'])) {
			$statuses = explode(',', $filter['status']);
			$viewFilter[] = ['t.status IN %in', $statuses ];
		} // if

        $this->resource = $this->teams->view($viewFilter, $order);

        $this->sendResource($this->outputType);
	} // actionList()

	public function actionCreate()
	{
        $this->checkAdministrator();

        $values = [
            'name'           => $this->input->name,
            'shibboleth'     => $this->input->shibboleth,
            'team_type'      => strtoupper($this->input->role),
            'is_active'      => $this->input->active,
            'allow_tracking' => $this->input->allowTracking,
        ];

        if (isset($this->input->description) && !empty($this->input->description))
            $values['description'] = $this->input->description;

        if (isset($this->input->telephone) && !empty($this->input->telephone))
            $values['telephone'] = $this->input->telephone;

        if (isset($this->input->email) && !empty($this->input->email))
            $values['email'] = $this->input->email;

        try {
            $result['team'] = $this->teams->insert($values);
        } catch (\Exception $e) {
            $this->sendErrorResource($e, $this->outputType);
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201,
            'data'   => $result
        ];
        $this->sendResource($this->outputType);
	} // actionCreate()

	public function actionUpdate()
	{
        $this->checkAdministrator();

        $team = (int) $this->input->team;
        $filter = [ 'team' => $team ];
        $values = [
            'name'           => $this->input->name,
            'shibboleth'     => $this->input->shibboleth,
            'team_type'      => strtoupper($this->input->role),
            'is_active'      => $this->input->active,
            'allow_tracking' => $this->input->allowTracking,
        ];

        if (isset($this->input->description) && !empty($this->input->description))
            $values['description'] = $this->input->description;

        if (isset($this->input->telephone) && !empty($this->input->telephone))
            $values['telephone'] = $this->input->telephone;

        if (isset($this->input->email) && !empty($this->input->email))
            $values['email'] = $this->input->email;

        try {
            $this->teams->update($values, $filter);
        } catch (\Exception $e) {
            $this->sendErrorResource($e, $this->outputType);
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201
        ];
        $this->sendResource($this->outputType);
	} // actionCreate()

	public function actionDelete()
	{
        $this->checkAdministrator();

        $filter = [ 'team' => (int) $this->input->team ];
        try {
            $this->teams->delete($filter);
        } catch (\Exception $e) {
            $this->sendErrorResource($this->outputType);
        } // if

        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource($this->outputType);
	} // actionDelete()

} // TeamPresenter
