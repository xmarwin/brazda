<?php

namespace Brazda\Presenters;

use Brazda\Models;

class NotePresenter extends SecuredBasePresenter
{
    protected
        $notes;

    public function startup()
    {
        parent::startup();

        $this->notes = $this->context->getService('postNotes');
    } // startup()

    public function actionDetail($post)
    {
        $viewFilter = [
            'team' => (int) $this->team['team'],
            'post' => (int) $post
        ];

        $this->resource = (array) $this->notes->find($viewFilter);
        $this->sendResource($this->outputType);
    } // actionDetail()

    public function actionCreate()
    {
        $values = [
            'post' => (int) $this->input->post,
            'team' => (int) $this->team['team'],
            'note' => $this->input->note
        ];

        try {
            $result = $this->notes->insert($values);
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
        $filter = [];
        if (isset($this->input->postNote) && !empty($this->input->postNote))
            $filter['post_note'] = (int) $this->input->postNote;

        if (isset($this->input->post) && !empty($this->input->post)) {
            $filter['post'] = (int) $this->input->post;
            $filter['team'] = (int) $this->team['team'];
        } // if

        $values = [
            'note' => $this->input->note
        ];

        try {
            $this->notes->update($values, $filter);
        } catch (\Exception $e) {
            $this->sendErrorResource($e, $this->outputType);
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201
        ];
        $this->sendResource($this->outputType);
    } // actionUpdate()

    public function actionDelete()
    {
        $filter = [];
        if (isset($this->input->postNote) && !empty($this->input->postNote))
            $filter['post_note'] = (int) $this->input->postNote;

        if (isset($this->input->post) && !empty($this->input->post)) {
            $filter['post'] = (int) $this->input->post;
            $filter['team'] = (int) $this->team['team'];
        } // if

        try {
            $this->notes->delete($filter);
        } catch (\Exception $e) {
            $this->sendErrorResource($e, $this->outputType);
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource($this->outputType);
    } // actionDelete()

} // NotePresenter
