<?php

namespace Brazda\Presenters;

use Brazda\Models,
    Latte,
    Mpdf,
    Nette\Application\Responses;

class InstructionPresenter extends SecuredBasePresenter
{
    protected
        $posts,
	$settings;

    public function startup()
    {
        parent::startup();

        $this->posts    = $this->context->getService('posts');
        $this->settings = $this->context->getService('settings');
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

