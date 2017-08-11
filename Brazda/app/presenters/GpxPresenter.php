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
        $viewFilter = [
            'team' => $this->team['team']
        ];
        $posts = $this->posts->view($viewFilter)->fetchAll();
        foreach ($posts as $id => $post) {
            $posts[$id]->waypoints = $this->waypoints->view([
                'post' => (int) $post->post,
                'team' => (int) $this->team['team']
            ])->fetchAll();
        } // foreach
        $this->template->posts = $posts;
    } // actionAll()

    public function actionPost($post)
    {
    } // actionPost()

} // GpxPresenter
