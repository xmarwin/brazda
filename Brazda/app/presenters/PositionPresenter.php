<?php

namespace Brazda\Presenters;

class PositionPresenter extends SecuredBasePresenter
{
    protected
        $positions;

    public function startup()
    {
        parent::startup();

        $this->positions = $this->context->getService('positions');
    } // startup()

    public function actionList(array $filter = [], array $order = [])
    {
        $this->resource = (array) $this->positions->view($filter, $order)->fetchAll();
        $this->sendResource($this->outputType);
    } // actionList()

    public function actionReport()
    {
        if (is_array($this->input)) {
            $input = $this->input;
        } elseif (is_object($this->input)) {
            $input = [ $this->input ];
        } else {
            $this->sendErrorResource(new Exception(
                    'Neznámý formát dat. Prosím posílejte buďto JSON literal, nebo pole JSON literálů.',
                    400
                ), // Exception()
                $this->outputType
            );
        } // if

        $this->positions->begin();
        foreach ($input as $position) {
            $values = [
                'team'      => (int) $this->team['team'],
                'device_id' => (string) $position->deviceId,
                'latitude'  => (float) $position->latitude,
                'longitude' => (float) $position->longitude,
                'moment'    => $position->moment
            ];

            try {
                $result[] = (int) $this->positions->insert($values);
            } catch (\Exception $e) {
                $this->positions->rollback();
                $this->sendErrorResource($e, $this->outputType);
            } // try
        } // foreach()
        $this->positions->commit();

        $this->resource = [
            'status' => 'OK',
            'code'   => 201,
            'data'   => $result
        ];
        $this->sendResource($this->outputType);
    } // actionReport()

} // PositionPresenter
