<?php

namespace Brazda\Presenters;

use Nette,
    Nette\Application\UI,
    Nette\Utils;

class BasePresenter extends UI\Presenter
{
    protected
        $input,
        $resource,

        $logins;


    public function startup()
    {
        parent::startup();

        $this->logins = $this->context->getService('logins');
    } // startup()

    public function getInput()
    {
        $postQuery   = (array) $this->getHttpRequest()->getPost();
        $urlQuery    = (array) $this->getHttpRequest()->getQuery();
        $requestBody = (array) $this->parseRequestBody();

        return Utils\ArrayHash::from(array_merge($postQuery, $urlQuery, $requestBody));
    } // getInput()

    public function sendResource()
    {
        if (!is_iterable($this->resource)) {
            $this->resource = [];
        } // if

        $this->sendJson($this->resource);
    } // sendResource()

    public function sendErrorResource($error)
    {
        if ($error instanceof \Exception || $error instanceof \Throwable) {
            $resource = [
                'code' => $error->getCode(),
                'status' => 'error',
                'message' => $error->getMessage()
            ];
        } else {
            $resource = [
                'code' => 500,
                'status' => 'error',
                'message' => (string) $error
            ];
        } // if

        if (isset($error->errors) && $error->errors) {
            $resource['errors'] = $error->errors;
        }

        $this->sendJson($resource);
    } // sendErrorResource()

    public function checkContentTypeJson()
    {
        if (strpos($this->getHttpRequest()->getHeader('Content-Type'), 'application/json') === FALSE) {
            $this->sendErrorResource(
                new \Exception('Content type not acceptable, JSON excpected.', 406)
            ); // sendErrorResource()
        } // if
    } // checkJsonHeaders()

    public function checkValuesExists($values, array $rules = [])
    {
        foreach ($rules as $rule) {
            if (!isset($values[$rule])) {
                $this->sendErrorResource(
                    new \Exception("Value {$rule} expected.", 400)
                ); // sendErrorResource|()
            } // if
        } // foreach
    } // checkExpectedBodyValues()

    protected function parseRequestBody()
    {
        $input = $this->getHttpRequest()->getRawBody();

        $contentTypeHeader = !empty($this->getHttpRequest()->getHeader('Content-Type'))
            ? $this->getHttpRequest()->getHeader('Content-Type')
            : 'query';
        if (strpos($contentTypeHeader, ';') !== false) {
            list($contentType, $appendix) = explode(';', $contentTypeHeader);
        } else {
            $contentType = $contentTypeHeader;
        } // if
        $contentType = strtolower(trim($contentType));

        switch ($contentType) {
            case 'application/json':
                $body = !empty($input)
                    ? Nette\Utils\Json::decode($input)
                    : [];
                break;

            case 'query':
                $body = [];
                parse_str($input, $body);
                break;

            default:
                $body = [];
                break;
        } // if

        return $body;
    } // parseRequestBody()

} // BasePresenter
