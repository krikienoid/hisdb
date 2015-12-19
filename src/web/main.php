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

        <?php
            if (!$_SESSION['id']) {
                // If you are not logged in
                include('htmltmp/signIn.php');
            }
            else {
                // If you are logged in
                if ($_SESSION['userrole'] == $hisdb_ROLE_ADMIN) {
                    echo '<div class="container"><div class="alert alert-success">';
                    echo 'Welcome back, Administrator ' . $_SESSION['username'] . '!';
                    echo '</div></div>';
                }
                else if ($_SESSION['userrole'] == $hisdb_ROLE_DOCTOR) {
                    echo '<div class="container"><div class="alert alert-success">';
                    echo 'Welcome back, Doctor ' . $_SESSION['username'] . '!';
                    echo '</div></div>';
                    //$_GET['doctorid'] = $_SESSION['doctorid'];
                    include('htmltmp/patientLookup.php');
                }
                else if ($_SESSION['userrole'] == $hisdb_ROLE_PATIENT) {
                    echo '<div class="container"><div class="alert alert-success">';
                    echo 'Welcome back, ' . $_SESSION['username'] . '!';
                    echo '</div></div>';
                    include('htmltmp/patientView.php');
                }
            }
        ?>

    </div>

</body>

</html>
