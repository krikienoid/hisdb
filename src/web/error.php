<?php
    define('INCLUDE_CHECK', true);
    session_start();
?>

<!DOCTYPE html>

<html>

<?php include('htmltmp/head.html'); ?>

<body>

    <?php include('htmltmp/navBar.php'); ?>

    <div class="container">

        <div class="container">
            <div class="alert alert-danger">Woops! you made a wrong turn!</div>
        </div>

        <div class="fluid-container section-records">

            <?php
                if ($_SESSION['msg']['error-wrong-turn']) {
                    echo '<div class="text-danger error-msg">';
                    echo $_SESSION['msg']['error-wrong-turn'];
                    echo '</div>';
                    unset($_SESSION['msg']['error-wrong-turn']);
                }
            ?>

        </div>

    </div>

</body>

</html>
