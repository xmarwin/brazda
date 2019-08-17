<?php

namespace Brazda\Presenters;

class MapPresenter extends SecuredBasePresenter
{
    protected
        $posts,
        $waypoints,
        $team;

    public function startup()
    {
        parent::startup();

        $this->posts     = $this->context->getService('posts');
        $this->waypoints = $this->context->getService('waypoints');
        //$this->team      = $this->getUser()->getIdentity()->getData();
    } // startup()

    public function actionPoints(array $filter)
    {

        $postFilter = [
            'team' => $this->team['team']
        ];
        $waypointFilter = [
            'team' => $this->team['team'],
        ];

        if (isset($filter['type']) && !empty($filter['type'])) {
            $types = explode(',', $filter['type']);
            $postFilter[] = ['p.post_type IN %in', $types];
            $waypointFilter[] = ['w.waypoint_type IN %in', $types];

        } // if

        if (isset($filter['color']) && !empty($filter['color'])) {
            $colors = explode(',', $filter['color']);
            $postFilter[] = [ 'p.color IN %in', $colors ];
            } // if

        $posts = (array) $this->posts->listView($postFilter)->fetchAll();

        $posts = $this->posts->listView()->fetchAll();

        $this->resource = [
            'type' => 'FeatureCollection',
            'features' => []
        ];
        foreach ($posts as $id => $post) {
            $this->resource['features'][] = [
                'type' => 'Feature',
                'properties' => [
                    'name' => $post['name'],
                    'terrain' => $post['terrain'],
                    'difficulty' => $post['difficulty'],
                    'maxScore' => $post['max_score'],
                    'marker-color' => $post['color_code'],
                    'marker-symbol' => $post['post_type']
                ],
                'geometry' => [
                    'type' => 'Point',
                    'coordinates' => [
                        $post['longitude'],
                        $post['latitude']
                    ]
                ]
            ];

            $waypointFilter['post'] = (int) $post['post'];
            $waypoints = $this->waypoints->view($waypointFilter)->fetchAll();
            foreach ($waypoints as $waypoint) {
                if (empty($waypoint['latitude']) || empty($waypoint['longitude'])) continue;

                $this->resource['features'][] = [
                    'type' => 'Feature',
                    'properties' => [
                        'name' => $waypoint['name'],
                        'marker-color' => $post['color_code'],
                        'marker-symbol' => $waypoint['waypoint_type']
                    ],
                    'geometry' => [
                        'type' => 'Point',
                        'coordinates' => [
                            $waypoint['longitude'],
                            $waypoint['latitude']
                        ]
                    ]
                ];
            } // foreach
        } // foreach

        $this->sendResource($this->outputType);
    } // actionPoints()

} // MapPresenter
