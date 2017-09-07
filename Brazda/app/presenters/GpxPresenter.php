<?php

namespace Brazda\Presenters;

use Nette\Application\Responses,
    Brazda\Models;

class GpxPresenter extends SecuredBaseXmlPresenter
{
    protected
        $posts,
        $waypoints;

    private
        $downloadFile = '';

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

        $this->downloadFile = $this->createDownloadPath();
        $this->template->setFile($this->formatTemplateFiles()[0]);

        $response = (false === file_put_contents($this->downloadFile, (string) $this->template))
            ? new Responses\JsonResponse([
                'status' => 'Cannot create GPX file with all posts.',
                'code'   => 404
            ]) // JsonResponse()
            : new Responses\FileResponse(
                $this->downloadFile,
                'all.gpx',
                'application/gpx+xml'
            ); // FileResponse()

        $this->sendResponse($response);
    } // actionAll()

    public function actionPost($post)
    {
        $viewFilter = [
            'team' => $this->team['team'],
            'post' => (int) $post
        ];
        $posts = $this->posts->view($viewFilter)->fetchAll();
        $posts[0]->waypoints = $this->waypoints->view($viewFilter)->fetchAll();

        $this->template->posts = $posts;

        $this->downloadFile = $this->createDownloadPath();
        $this->template->setFile($this->formatTemplateFiles()[0]);

        $response = (false == file_put_contents($this->downloadFile, (string) $this->template))
            ? new Responses\JsonResponse([
                'status' => 'Cannot create GPX file with single post.',
                'code'   => 404
            ]) // JsonResponse()
            : new Responses\FileResponse(
                $this->downloadFile,
                'post'.$post.'.gpx',
                'application/gpx+xml'
            ); // FileResponse()

        $this->sendResponse($response);
    } // actionPost()

} // GpxPresenter
