<?php

namespace Brazda\Module\Front\Presenters;

use Nette\Application\UI,
    Nette\Security;

class SignPresenter extends BasePresenter 
{
    public function actionOut()
    {
        $user = $this->getUser();
        if ($user->isLoggedIn()) {
            $user->logout();
        } // if
        $this->redirect('Sign:in');
    } // actionOut()

    public function signInSubmit(UI\Form $form, $values)
    {
        try {
            $user = $this->getUser();
            $user->login(
                $values['name'],
                $values['password']
            ); // login()
            $this->flashMessage('Uživatel se přihlásil.');
            $this->redirect('Default:default');
        } catch (Security\AuthenticationException $e) {
            $this->flashMessage($e->getMessage(), 'danger');
        } // try
    } // signInSubmit()

    protected function createComponentSignInForm()
    {
        $form = new UI\Form;
        $form->addText('name', 'Jméno')
            ->addRule(UI\Form::FILLED, 'Prosím vyplňte název týmu.');
        $form['name']->getControlPrototype()
            ->placeholder = 'Jméno týmu';

        $form->addPassword('password', 'Heslo')
            ->addRule(UI\Form::FILLED, 'Prosím vyplňte heslo.');
        $form['password']->getControlPrototype()
            ->placeholder = 'Heslo';

        $form->addSubmit('login', 'Přihlásit');
        $form->onSuccess[] = [ $this, 'signInSubmit' ];

        return $form;
    } // createComponentSignInForm()


} // SignPresenter
