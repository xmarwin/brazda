<?php

namespace Brazda\Module\Api\Presenters;

use Drahak\Restful\IResource,
    Drahak\Restful\Application\UI\ResourcePresenter,
    Drahak\Restful\Application\UI\SecuredResourcePresenter;

//class BasePresenter extends SecuredResourcePresenter
class BasePresenter extends ResourcePresenter
{
	protected $typeMap = [
		'json' => IResource::JSON,
		'xml'  => IResource::XML
	];

} // BasePresenter
