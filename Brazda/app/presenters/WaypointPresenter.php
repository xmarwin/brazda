<?php

namespace Brazda\Presenters;

use Nette\Security,
    Brazda\Models;

class WaypointPresenter extends SecuredBasePresenter
{
    protected
        $waypoints;

    public function startup()
    {
        parent::startup();

        $this->waypoints = $this->context->getService('waypoints');
    } // startup()

    public function actionList(array $filter = [], array $order = [])
    {
        $viewFilter = [
            'team' => $this->team['team']
        ];

        if (isset($filter['post']) && !empty($filter['post'])) {
            $viewFilter[] = [ 'w.post = %i', (int) $filter['post'] ];
        } // if

        if (isset($filter['type']) && !empty($filter['type'])) {
            $types = explode(',', $filter['type']);
            $viewFilter[] = [ 'w.waypoint_type IN %in', $types ];
        } // if

        if (isset($filter['visibility']) && !empty($filter['visibility'])) {
            $visibilities = explode(',', $filter['visibilities']);
            $viewFilter[] = [ 'w.waypoint_visibility IN %in', $visibilities ];
        } // if

        $this->resource = (array) $this->waypoints->view($viewFilter, $order)->fetchAll();
        $this->sendResource();
    } // actionList()

    public function actionCreate()
    {
        $this->checkAdministrator();

        $values = [
            'waypoint_type'       => strtoupper($this->input->waypointType),
            'waypoint_visibility' => strtoupper($this->input->waypointVisibility),
            'post'                => (int) $this->input->post,
            'name'                => $this->input->name,
            'description'         => $this->input->description,
            'latitude'            => (float) $this->input->latitude,
            'longitude'           => (float) $this->input->longitude
        ];

        $result = [];
        try {
            $result['waypoints'] = (int) $this->waypoints->insert($values);
        } catch (Exception $e) {
            $this->sendErrorResource($e, );
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201,
            'data'   => $result
        ];
        $this->sendResource();
    } // actionCreate()

    public function actionUpdate()
    {
        $this->checkAdministrator();

        $filter['waypoint'] = (int) $this->input->waypoint;
        $values = [
            'waypoint_type'       => strtoupper($this->input->waypointType),
            'waypoint_visibility' => strtoupper($this->input->waypointVisibility),
            'name'                => $this->input->name,
            'description'         => $this->input->description,
            'latitude'            => (float) $this->input->latitude,
            'longitude'           => (float) $this->input->longitude
        ];
        if (isset($this->input->post) && !empty($this->input->post)) {
            $values['post'] = (int) $this->input->post;
        } // if

        try {
            $this->waypoints->update($values, $filter);
        } catch (Exception $e) {
            $this->sendErrorResource($e, );
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201
        ];
        $this->sendResource();
    } // actionUpdate()

    public function actionDelete()
    {
        $this->checkAdministrator();

        $filter = [ 'waypoint' => (int) $this->input->waypoint ];
        try {
            $this->waypoints->delete($filter);
        } catch (Exception $e) {
            $this->sendErrorResource($e, );
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource();
    } // actionDelete()

} // WaypointPresenter
