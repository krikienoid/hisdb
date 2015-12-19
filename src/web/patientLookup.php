<?php
    define('INCLUDE_CHECK', true);
    require_once('common.php');
    session_start();
?>

<!DOCTYPE html>

<html>

<?php include('htmltmp/head.html'); ?>

<body>

    <?php include('htmltmp/navBar.php'); ?>

    <div class="container">

        <?php include('htmltmp/patientLookup.php'); ?>

    </div>

</body>

</html>
