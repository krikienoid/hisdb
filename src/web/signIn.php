<?php

    define('INCLUDE_CHECK', true);
    require_once('common.php');
    session_start();

    if ($_SESSION['id']) {
        header('Location: signOut.php');
        exit;
    }

    if ($_POST['submit'] == 'Login') {

        // Error Checking
        $err = array();

        // Check if fields are filled
        if (!$_POST['username'] || !$_POST['password']) {
            $err[] = 'All the fields must be filled in!';
        }

        if(!count($err)) {

            // Connect to database
            $dbConn = hisdb_dbConnect();
            if ($dbConn) {

                // Escape input data
                $username = mysqli_real_escape_string($dbConn, $_POST['username']);
                $password = mysqli_real_escape_string($dbConn, $_POST['password']);

                // Check if user matches
                $recordSet = mysqli_query(
                    $dbConn,
                    'SELECT * ' .
                    'FROM LoginUser ' .
                    'WHERE UserName = \'' . $username . '\' ' .
                    'AND Password = \'' . md5($password) . '\';'
                );
                $loginUser = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
                mysqli_free_result($recordSet);

                // If matching user exists
                if ($loginUser['UserName']) {

                    // Save to session
                    $_SESSION['id']       = $loginUser['UserID'];
                    $_SESSION['username'] = $loginUser['UserName'];
                    $_SESSION['password'] = $loginUser['Password'];
                    $_SESSION['userrole'] = $loginUser['RoleID'];

                    // Check user for patient / doctor IDs
                    $recordSet = mysqli_query(
                        $dbConn,
                        'SELECT PatientID, DoctorID ' .
                        'FROM LoginUser ' .
                        'INNER JOIN Patient ' .
                        'ON LoginUser.UserID = Patient.LoginUserID ' .
                        'LEFT JOIN Doctor ' .
                        'ON LoginUser.UserID = Doctor.LoginUserID ' .
                        'WHERE UserName = \'' . $username . '\';'
                    );
                    $record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
                    if ($record['PatientID']) $_SESSION['patientid'] = $record['PatientID'];
                    if ($record['DoctorID'])  $_SESSION['doctorid']  = $record['DoctorID'];
                    mysqli_free_result($recordSet);

                }
                else {

                    $err[] = 'Invalid username and/or password!';

                }

                // Close connection
                mysqli_close($dbConn);

            }
            else {

                $err[] = 'Error connecting to database: ' . mysqli_connect_error();

            }

        }

        if ($err) {
            // Save the error messages in the session
            $_SESSION['msg']['error-signin'] = implode('<br />', $err);
        }

        header('Location: main.php');
        exit;

    }

?>
