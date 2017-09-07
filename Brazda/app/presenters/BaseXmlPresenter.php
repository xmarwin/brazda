<?php

namespace Brazda\Presenters;

use Nette\Application\UI;

class BaseXmlPresenter extends UI\Presenter
{
    protected
        $logins;

    public function startup()
    {
        parent::startup();

        $this->logins = $this->context->getService('logins');
    } // startup()

    protected function createDownloadPath($file = null)
    {
        return empty($file)
            ? tempnam($this->context->parameters['tempDir'], 'dl_')
            : $this->context->parameters['tempDir'].DIRECTORY_SEPARATOR
                .'dl_'.$file;
    } // createDownloadPath()

} // BaseXmlPresenter
