<nav class="navbar navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="main.php">HIS DataBase</a>
        </div>
        <div class="navbar-collapse collapse" id="navbar">
            <ul class="nav navbar-nav navbar-right">
                <?php
                    if (!$_SESSION['id']) {
                        echo '<li><a href="main.php">Sign In</a></li>';
                    }
                    else if ($_SESSION['userrole'] == $hisdb_ROLE_PATIENT) {
                        echo '<li><a href="patientView.php">Health Record</a></li>';
                        echo '<li><a href="signOut.php">Sign Out</a></li>';
                    }
                    else if ($_SESSION['userrole'] == $hisdb_ROLE_DOCTOR) {
                        echo '<li><a href="patientLookup.php">Patients</a></li>';
                        echo '<li><a href="signOut.php">Sign Out</a></li>';
                    }
                ?>
            </ul>
        </div>
    </div>
</nav>
