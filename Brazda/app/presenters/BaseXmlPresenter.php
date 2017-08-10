<?php

namespace Brazda\Presenters;

use Nette\Application\UI;

class BaseXmlPresenter extends UI\Presenter
{
    protected
        $logins;

    public function startup()
    {
        parent::startup()

        $this->logins = $this->context->getService('logins');
    } // startup()

} // BaseXmlPresenter
