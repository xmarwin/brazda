<?php

namespace Brazda\Module\Api\Presenters;

use Drahak\Restful\IResource,
    Drahak\Restful\Application\UI\ResourcePresenter;

class BasePresenter extends ResourcePresenter
{
	protected
		$typeMap = [
			'json' => IResource::JSON,
			'xml'  => IResource::XML
		],
		$outputType = IResource::JSON,

		$logins;

    public function startup()
    {
        parent::startup();

        $this->logins = $this->context->getService('logins');
    } // startup()

} // BasePresenter
