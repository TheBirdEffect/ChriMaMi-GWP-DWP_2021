<?php

/**
 * @author Matthias Gabel<matthias.gabel@fh-erfurt.de>
 * @copyright Since 2021 by Matthias Gabel
 * @version 1.0.0
 */

// load needed variables/defines/configs
require_once 'config/init.php';
//require_once 'config/database.php';

// load core stuff
require_once COREPATH.'functions.php';
require_once COREPATH.'controller.class.php';
require_once COREPATH.'model.class.php';


// load all models
foreach(glob(MODELSPATH.'*.php') as $modelfiles)
{
    require_once $modelfiles;
}

/*$login = new \dwp\model\Login(['passwordHash' => 'test']);
$login->insert();

exit(0);*/

// start session to handle login
session_start();

// check which controller should be loaded
$controllerName = 'pages';
$actionName = 'main';

// check a controller is given
if(isset($_GET['c']))
{
    $controllerName = $_GET['c'];
}

// check an action is given
if(isset($_GET['a']))
{
    $actionName = $_GET['a'];
}

// check controller/class and method exists
if(file_exists(CONTROLLERSPATH.$controllerName.'Controller.php'))
{
    // include the controller file
    require_once CONTROLLERSPATH.$controllerName.'Controller.php';

    // generate the class name of the controller using the name extended by Controller
    // also add the namespace in front
    $className = '\\dwp\\controller\\'.ucfirst($controllerName).'Controller';

    // generate an instace of the controller using the name, stored in $className
    // it is the same like calling for example: new \dwp\controller\PagesController()
    $controller = new $className($controllerName, $actionName);

    // checking the method is available in the controller class
    // the method looks like: actionIndex()
    $actionMethod = 'action'.ucfirst($actionName);
    if(!method_exists($controller, $actionMethod))
    {
        // redirect to error page 404 because not found
        header('Location: index.php?c=errors&a=error404');
        exit(0);
    }
    else
    {
        // call the action method to do the job
        // so the action cann fill the params for the views which will be used
        // in the render process later
        $controller->{$actionMethod}();
    }
}
else
{
    // redirect to error page 404 because not found
    header('Location: index.php?c=errors&a=error404&error=nocontroller');
    exit(0);
}


?>


<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IB-Patrick Horsch</title>
    <link href="<?=ASSETSPATH.'roboto' .DIRECTORY_SEPARATOR.'font.css'?>" rel="stylesheet">
    <link href="<?=ASSETSPATH.'designs'.DIRECTORY_SEPARATOR.'design-index.css'?>" rel="stylesheet">
    <script language="JavaScript" type="text/javascript" src="assets/javascripts/header.js"></script>
</head>
<body>
    <header>
        <div id="head_container">
            <div id="sek-head-logo">
                <img src="<?= ASSETSPATH . 'logo/logo.png' ?>" alt="Logo">
            </div>
            <div id="sek-headcontent">
                <h1>Ingenieurbüro</h1>
                <h2>Patrick Horsch</h2>
                <nav>
                    <ul class="navigation">
                        <li><a href="<?= $_SERVER['SCRIPT_NAME'] ?>?c=pages&a=main">Home</a></li>
                        <li><a href="<?= $_SERVER['SCRIPT_NAME'] ?>?c=pages&a=produkte">Produkte</a></li>
                        <li><a href="<?= $_SERVER['SCRIPT_NAME'] ?>?c=pages&a=shop">Shop</a></li>
                        <li><a href="<?= $_SERVER['SCRIPT_NAME'] ?>?c=pages&a=administration">Administration</a></li>
                        <li><a href="<?= $_SERVER['SCRIPT_NAME'] ?>?c=pages&a=login" class="submitLogout">Login</a></li>
                        <li><a href="<?= $_SERVER['SCRIPT_NAME'] ?>?c=pages&a=impressum">Impressum</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </header>
    <div id="page-container">
        <?php

        // this method will render the views of the called action
        // for this the the file in the views directory will be included
        $controller->render();
        ?>
    </div>
    <footer>
        <section>
            <div class="left">
                <ul>
                    <h2>IB Horsch Patrick</h2>
                </ul>
                <ul>
                    <li><img src="<?= ASSETSPATH . 'icons' . DIRECTORY_SEPARATOR . 'marker.png' ?>"/></li>
                    <li>Musterweg 01</li>
                    <li>00000 Musterhausen</li>
                </ul>
                <ul>
                    <li><img src="<?= ASSETSPATH . 'icons' . DIRECTORY_SEPARATOR . 'phone.png' ?>"/></li>
                    <li> 09973 / 38 90 96-0</li>
                    <li> 09973 / 38 55 98 0</li>
                </ul>
                <ul>
                    <li><img src="<?= ASSETSPATH . 'icons' . DIRECTORY_SEPARATOR . 'printer.png' ?>"/></li>
                    <li> 09843 / 38 90 96-96</li>
                    <li> 09843 / 38 55 98 1</li>
                </ul>
                <ul>
                    <li><img src="<?= ASSETSPATH . 'icons' . DIRECTORY_SEPARATOR . 'mail.png' ?>"/></li>
                    <li>
                        info@patrick-horsch.de
                    </li>
                </ul>
            </div>
            <div class="right">
                <ul>
                    <li><img src="<?= ASSETSPATH . 'images'. DIRECTORY_SEPARATOR.'googleMaps.png' ?>"/></li>
                </ul>
            </div>
        </section>
    </footer>
</body>
</html>