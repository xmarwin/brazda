<?php

namespace Brazda\Presenters;

use Brazda\Models;

class GpxPresenter extends SecuredBaseXmlPresenter
{
    protected
        $posts,
        $waypoints;

    public function startup()
    {
        parent::startup();

        $this->posts     = $this->context->getService('posts');
        $this->waypoints = $this->context->getService('waypoints');
    } // startup()

    public function actionAll()
    {

    } // actionAll()

    public function actionPost($post)
    {
    } // actionPost()

} // GpxPresenter
