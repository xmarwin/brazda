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

} // TeamPresenter
