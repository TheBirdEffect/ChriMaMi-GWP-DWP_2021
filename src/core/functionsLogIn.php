<?php


/*
function getAllUsers()
{
    $dbString = file_get_contents(DATABASE);
    $usersArray = json_decode($dbString, true);assoc == true return as as associative array
    return $usersArray['users'];
}

function user($id)
{
    $usersArray = getAllUsers();
    foreach($usersArray as $userData)
    {
        if($userData['id'] === $id)
        {
            return $userData;
        }
    }
}

function logIn(&$error, $rememberMe = false)
{
    $userArray = getAllUsers();
    $userReference  = isset($_POST['validationEmail']) ? $_POST['validationEmail'] : '';
    $userPassword   = isset($_POST['validationPassword']) ? $_POST['validationPassword'] : '';

    $userId = null;

    If the checked the rememberMe at last logIn, check the cookies an logIn automatically
    if($rememberMe === true && empty($_POST['validationEmail']) && empty($_POST['validationPassword']))
    {
        $userId = $_POST['userId'];
        $userPassword = $_POST['password'];
    }

    foreach ($userArray as $index => $userData)
    {
        if($userData['email'] === $userReference
        || $userData['id'] === $userId)
        {
            $userIndex = $index;
            $userId = $userData['id'];
            break;
        }
    }

    if(isset($userId))
    {
        if($userArray[$userIndex]['password'] === $userPassword)
        {
            $error = false;

            if(isset($_POST['rememberMe']))
            {
                rememberMe($userId, $userArray[$userIndex]['password']);
            }
            return $userId;
        }
    } else
    {
        $error = 'Wrong email or password';
    }
}

function logOut()
{
    setcookie('userId', '', -1, '/');
    setcookie('password', '', -1, '/');
    unset($_SESSION['user']);
    session_destroy();
}

function rememberMe($id, $password)
{
    $duration = time() + 3600 * 24; //24 Hours
    setcookie('userId', $id, $duration, '/');
    setcookie('password', $password, $duration, '/');

}
*/


use dwp\model\Accounts as Accounts;
use dwp\model\Administrators as Administrators;

/**
 * @param $email expects an email-address from user as string
 * @return mixed|null return Account by email
 */
function getAccount($email)
{
    $db = $GLOBALS['db'];
    $sql = "email=" . $db->quote($email);
    return Accounts::findOne($sql);
}

function isAdmin($account){
    $db = $GLOBALS['db'];
    $userId = $account->id;
    $sql = "accounts_id=". $db->quote($userId);
    $adminId = Administrators::findOne($sql);
    if(isset($adminId)){
        if($userId === $adminId->accounts_id) {
            return true;
        }
    } else {
        return false;
    }
}

function emptyInputLogin($email, $password)
{
    if (empty($email) || empty($password)) {
        $result = true;
    } else {
        $result = false;
    }
    return $result;
}

function loginUser($email, $password)
{
    $account = getAccount($email);
    if (isset($account)) {
        $isAdmin = isAdmin($account);
        $password_hashed = $account->password_hash;

        $isPasswordCorrect = password_verify($password, $password_hashed);
        if ($isPasswordCorrect) {
            $_SESSION['id'] = $account->id;
            $_SESSION['email'] = $account->email;
            $_SESSION['isAdmin'] = $isAdmin;
            header("Location: index.php?c=pages&a=main");
        }
    }
    else {
        header("Location: index.php?c=errors&a=errorLogin&error=stmtFailed");
    }
}



