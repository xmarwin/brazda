<?php

namespace Brazda\Presenters;

use Brazda\Models,
    Latte,
    League\Geotools,
    Mpdf,
    Nette\Application\Responses;

class InstructionPresenter extends SecuredBasePresenter
{
    protected
        $posts,
	$settings,
        $waypoints;

    public function startup()
    {
        parent::startup();

        $this->posts     = $this->context->getService('posts');
        $this->settings  = $this->context->getService('settings');
        $this->waypoints = $this->context->getService('waypoints');
    } // startup()

    public function actionDefault()
    {
        $this->checkAdministrator();

        $posts = $this->posts->view([ [ 'instructions IS NOT NULL' ] ]);

        $data = [
            'posts' => $posts,
            'params' => $this->context->getParameters(),
            'settings' => $this->settings->enumeration()
	];

        $templateFile = __DIR__.'/templates/Instruction/posts.latte';
        $styleFile = __DIR__.'/templates/Instruction/post.css';

        $latte = new Latte\Engine;
        $latte->setTempDirectory(__DIR__.'/../../temp/cache/latte/');

        $pdf = new Mpdf\Mpdf([
            'mode'   => 'utf-8',
	    'format' => 'A4'
        ]); // Mpdf()
        $pdf->img_dpi = 300;
	$pdf->SetBasePath(__DIR__.'/templates/Instruction/');

        $pdf->SetTitle("Instrukce pro stanoviště");

        $pdf->WriteHTML(
            file_get_contents($styleFile),
            \Mpdf\HTMLParserMode::HEADER_CSS
        ); // WriteHTML()

        $pdf->WriteHTML(
            $latte->renderToString($templateFile, $data),
            \Mpdf\HTMLParserMode::HTML_BODY
        ); // WriteHTML()

        $pdf->Output("instrukce.pdf", Mpdf\Output\Destination::DOWNLOAD);

	$this->terminate();
    } // actionDefault()

    public function actionAll()
    {
        $this->actionDefault();
    } // actionAll()

    public function actionPost($post)
    {
        $this->checkAdministrator();

        $postId = (int) $post;
        $post = $this->posts->find($postId);
        $post->instructions = $this->replacements($post->instructions);

        $data = [
            'post' => $post,
            'params' => $this->context->getParameters(),
            'settings' => $this->settings->enumeration()
	];
        $templateFile = __DIR__.'/templates/Instruction/post.latte';
        $styleFile = __DIR__.'/templates/Instruction/post.css';

        $latte = new Latte\Engine;
        $latte->setTempDirectory(__DIR__.'/../../temp/cache/latte/');

        $pdf = new Mpdf\Mpdf([
            'mode'   => 'utf-8',
	    'format' => 'A4'
        ]); // Mpdf()
        $pdf->img_dpi = 300;
	$pdf->SetBasePath(__DIR__.'/templates/Instruction/');

        $pdf->SetTitle("Instrukce pro stanoviště {$post['name']}");

        $pdf->WriteHTML(
            file_get_contents($styleFile),
            \Mpdf\HTMLParserMode::HEADER_CSS
        ); // WriteHTML()

        $pdf->WriteHTML(
            $latte->renderToString($templateFile, $data),
            \Mpdf\HTMLParserMode::HTML_BODY
        ); // WriteHTML()

        $pdf->Output("instrukce-{$post['post']}.pdf", Mpdf\Output\Destination::DOWNLOAD);

        $this->terminate();
    } // actionPost()

    public function actionPostsTable()
    {
        $posts = $this->posts->view([ [ 'post_type NOT IN %in', [ 'BEG', 'END', 'ORG' ] ] ])->fetchAll();
        array_walk($posts, function (&$post, $key) {
            $coords = "{$post->latitude}, {$post->longitude}";

            $geotools = new Geotools\Geotools;
            $coordinate = new Geotools\Coordinate\Coordinate($coords);
            $converted = $geotools->convert($coordinate);

            $latitudeLD = $converted->toDM('%L %D°');
            $latitudeN  = str_pad(number_format(round($converted->toDM('%N'), 3), 3), 6, '0', STR_PAD_LEFT);

            $longitudeLD = $converted->toDM('%l&thinsp;%d°');
            $longitudeN  = str_pad(number_format(round($converted->toDM('%n'), 3), 3), 6, '0', STR_PAD_LEFT);

            $post->coordinate = "{$latitudeLD}&thinsp;{$latitudeN},&nbsp;{$longitudeLD}&thinsp;{$longitudeN}";
        }); // array_map()

        $waypoints = $this->waypoints->view()->fetchAssoc('post,waypoint_type');
        foreach ($waypoints as $post => $waypointTypeItems) {
            foreach ($waypointTypeItems as $waypointType => $waypoint) {
                if (empty($waypoint->latitude) || empty($waypoint->longitude)) continue;

                $coords = "{$waypoint->latitude}, {$waypoint->longitude}";

                $geotools = new Geotools\Geotools;
                $coordinate = new Geotools\Coordinate\Coordinate($coords);
                $converted = $geotools->convert($coordinate);

                $latitudeLD = $converted->toDM('%L&thinsp;%D°');
                $latitudeN  = str_pad(number_format(round($converted->toDM('%N'), 3), 3), 6, '0', STR_PAD_LEFT);

                $longitudeLD = $converted->toDM('%l&thinsp;%d°');
                $longitudeN  = str_pad(number_format(round($converted->toDM('%n'), 3), 3), 6, '0', STR_PAD_LEFT);

                $waypoints[$post][$waypointType]->coordinate = "{$latitudeLD}&thinsp;{$latitudeN},&nbsp;{$longitudeLD}&thinsp;{$longitudeN}";
            } // foreach
        } // foreach

        $data = [
            'posts'     => $posts,
            'settings'  => $this->settings->enumeration(),
            'waypoints' => $waypoints
        ];
        $templateFile = __DIR__.'/templates/Instruction/postsTable.latte';
        $styleFile = __DIR__.'/templates/Instruction/postsTable.css';

        $latte = new Latte\Engine;
        $latte->setTempDirectory(__DIR__.'/../../temp/cache/latte/');

        $pdf = new Mpdf\Mpdf([
            'mode'   => 'utf-8',
            'format' => 'A4-L'
        ]); // Mpdf()
        $pdf->img_dpi = 300;
        $pdf->SetBasePath(__DIR__.'/templates/Instruction/');

        $pdf->SetTitle("Stanoviště závodu {$this->settings->get('raceTitle')}");

        $pdf->WriteHTML(
            file_get_contents($styleFile),
            \Mpdf\HTMLParserMode::HEADER_CSS
        ); // WriteHTML()

        $pdf->WriteHTML(
            $latte->renderToString($templateFile, $data),
            \Mpdf\HTMLParserMode::HTML_BODY
        ); // WriteHTML()

        $pdf->Output('tabulka-stanovist.pdf', Mpdf\Output\Destination::DOWNLOAD);

        $this->terminate();
    } // actionPostsTable()

    protected function replacements(?string $input): string
    {
        $replacements = [
            '----------' => '<hr class="cut-here" />'
        ];

        return str_replace(
            array_keys($replacements),
            array_values($replacements),
            $input
        ); // str_replace()
    } // replacements()

} // InstructionPresenter


