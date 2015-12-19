<?php

    session_start();

    // Destroy the session
    $_SESSION = array();
    session_destroy();

    header('Location: main.php');
    exit;

?>
