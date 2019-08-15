<?php

namespace Brazda\Presenters;

use Brazda\Models,
    Dibi;

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
        try {
            $viewFilter = [
                'team' => (int) $this->team['team'],
                'post' => (int) $post
            ];

            $this->resource = (array) $this->notes->find($viewFilter);
        } catch (Dibi\Exception $e) {
            $this->sendErrorResource($e);
        } // try

        $this->sendResource();
    } // actionDetail()

    public function actionCreate()
    {
        $this->checkAdministrator();

        $this->checkContentTypeJson();

        $this->checkValuesExists($this->input, [
            'team',
            'post',
            'note'
        ]); // checkValuesExists()

        $values = [
            'team' => (int) $this->team['team'],
            'post' => (int) $this->input->post,
            'note' => $this->input->note
        ];

        try {
            $result = $this->notes->insert($values);
        } catch (\Exception $e) {
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

        $this->checkContentTypeJson();

        $this->checkValuesExists($this->input, [
            'note'
        ]); // checkValuesExists()

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
            $this->sendErrorResource($e, );
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201
        ];
        $this->sendResource();
    } // actionUpdate()

    public function actionSave()
    {
        $this->checkAdministrator();

        $this->checkContentTypeJson();

        $this->checkValuesExists($this->input, [
            'note'
        ]); // checkValuesExists()

        $filter = [
            'post' => (int) $this->input->post,
            'team' => (int) $this->team['team']
        ];

        $values = [
            'last_change' => date('Y-m-d H:i:s'),
            'note'        => $this->input->note
        ];

        try {
            $note = $this->notes->find($filter);

            if (empty($note)) {
                $this->notes->insert($values + $filter);
            } else {
                $this->notes->update($values, $filter);
            } // of
        } catch (\Exception $e) {
            $this->sendErrorResource($e, );
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201
        ];
        $this->sendResource();
    } // actionSave()

    public function actionDelete()
    {
        $this->checkAdministrator();

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
            $this->sendErrorResource($e, );
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 200
        ];
        $this->sendResource();
    } // actionDelete()

} // NotePresenter
