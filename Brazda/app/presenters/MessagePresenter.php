<?php

namespace Brazda\Presenters;

class MessagePresenter extends SecuredBasePresenter
{
    protected
        $messages;

    public function startup()
    {
        parent::startup();

        $this->messages = $this->context->getService('messages');
    } // startup()

    public function actionDefault()
    {
        $messages = $this->messages->enumeration($this->team['team']);
        $this->resource = !empty($messages)
            ? $messages
            : [ null ];

        $this->sendResource();
    } // actionDefault()

    public function actionShow($message)
    {
        $this->resource = (array) $this->messages->show(
            $this->team['team'],
            $message
        ); // show()

        $this->sendResource();
    } // actionShow()

    public function actionNew()
    {
        $this->actionDefault();
    } // actionNew()

    public function actionAll()
    {
        $messages = $this->messages->enumeration($this->team['team'], true);
        $this->resource = !empty($messages)
            ? $messages
            : [ null ];

        $this->sendResource();
    } // if

    public function actionCreate()
    {
        $this->checkAdministrator();

        if (empty($this->input->message)) {
            $this->resource = [
                'status' => 'Empty message',
                'code'   => 400
            ];

            $this->sendResource();
        } // if

        $values = [ 'content' => $this->input->message ];

        try {
            $result = $this->messages->insert($values);
        } catch (\Exception $e) {
            $this->resource = [
                'status' => 'Message creation failed',
                'code'   => 500,
                'error'  => $e->getMessage()
            ];
            $this->sendResource();
        } // try

        $this->resource = [
            'status' => 'OK',
            'code'   => 201,
            'data'   => $result
        ];
        $this->sendResource();
    } // actionCreate()

} // MessagePresenter()
