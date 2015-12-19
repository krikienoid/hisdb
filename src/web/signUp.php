<?php

    define('INCLUDE_CHECK', true);
    require_once('common.php');
    session_start();

    // If the Register form has been submitted
    if ($_POST['submit'] == 'Register') {

        // Error Checking
        $err = array();

        // Username length
        if (strlen($_POST['username']) < 1 || strlen($_POST['username']) > 32) {
            $err[] = 'Your username must be between 1 and 32 characters!';
        }

        // Username characters
        if (preg_match('/[^a-z0-9\-\_\.]+/i', $_POST['username'])) {
            $err[] = 'Your username contains invalid characters!';
        }

        // Connect to database
        $dbConn = hisdb_dbConnect();
        if ($dbConn) {

            // Escape input
            $password    = $_POST['password'];
            $confirmpwd  = $_POST['confirmpwd'];
            $email       = mysqli_real_escape_string($dbConn, $_POST['email']);
            $username    = mysqli_real_escape_string($dbConn, $_POST['username']);
            $firstname   = mysqli_real_escape_string($dbConn, $_POST['firstname']);
            $lastname    = mysqli_real_escape_string($dbConn, $_POST['lastname']);
            $dateofbirth = mysqli_real_escape_string($dbConn, $_POST['dateofbirth']);

            // Confirm password
            if ($password != $confirmpwd) {
                $err[] = 'Password is incorrect!';
            }

            // Check if username is taken
            if (hisdb_usernameExists($dbConn, $username)) {
                $err[] = 'This username is already taken!';
            }

            // Check if doctor or patient exists
            $doctorid  = hisdb_findDoctor($dbConn, $firstname, $lastname)['DoctorID'];
            $patientid = hisdb_findPatient($dbConn, $firstname, $lastname, $dateofbirth)['PatientID'];
            if ($doctorid) {
                if (hisdb_hasDoctorAccount($dbConn, $doctorid)) {
                    $err[] = 'Already registered in database!';
                }
                else {
                    $userrole = $hisdb_ROLE_DOCTOR;
                }
            }
            else if ($patientid) {
                if (hisdb_hasPatientAccount($dbConn, $patientid)) {
                    $err[] = 'Already registered in database!';
                }
                else {
                    $userrole = $hisdb_ROLE_PATIENT;
                }
            }
            else {
                $err[] = 'Account not found in database!';
            }

            // Input is valid and patient or doctor exists
            if (!count($err)) {

                // Insert user account
                mysqli_query($dbConn, 'START TRANSACTION; ');
                mysqli_query(
                    $dbConn,
                    'INSERT INTO LoginUser (UserName, Password, Email, RegIP, RegDate, RoleID) ' .
                    'VALUES (' .
                    '\'' . $username               . '\',' .
                    '\'' . md5($password)          . '\',' .
                    '\'' . $email                  . '\',' .
                    '\'' . $_SERVER['REMOTE_ADDR'] . '\',' .
                    'NOW(),' .
                    $userrole .
                    '); '
                );
                mysqli_query(
                    $dbConn,
                    'UPDATE Patient ' .
                    'SET LoginUserID = LAST_INSERT_ID() ' .
                    'WHERE PatientID = ' . $patientid . '; '
                );
                mysqli_query(
                    $dbConn,
                    'UPDATE Doctor ' .
                    'SET LoginUserID = LAST_INSERT_ID() ' .
                    'WHERE DoctorID = ' . $doctorid . '; '
                );

                // Add user to database
                mysqli_query(
                    $dbConn,
                    'CREATE USER \'' . $username . '\'@\'localhost\' ' .
                    'IDENTIFIED BY \'' . md5($password) . '\';'
                );
                if ($userrole == $hisdb_ROLE_ADMIN) {
                    mysqli_query($dbConn, 'GRANT ALL PRIVILEGES ON ' . $hisdb_dbName . ' . * TO \'' . $username . '\'@\'localhost\';');
                }
                else if ($userrole == $hisdb_ROLE_DOCTOR) {
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . * TO \'' . $username . '\'@\'localhost\';');
                    mysqli_query($dbConn, 'GRANT UPDATE ON ' . $hisdb_dbName . ' . * TO \'' . $username . '\'@\'localhost\';');
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . DoctorPatientLookupView TO \'' . $username . '\'@\'localhost\';');
                }
                else if ($userrole == $hisdb_ROLE_PATIENT) {
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . PatientPersonView TO \'' . $username . '\'@\'localhost\';');
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . PatientInformationView TO \'' . $username . '\'@\'localhost\';');
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . PatientVaccinationRecordView TO \'' . $username . '\'@\'localhost\';');
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . PatientDiagnosisRecordView TO \'' . $username . '\'@\'localhost\';');
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . PatientPrescriptionRecordView TO \'' . $username . '\'@\'localhost\';');
                    mysqli_query($dbConn, 'GRANT SELECT ON ' . $hisdb_dbName . ' . PatientProcedureRecordView TO \'' . $username . '\'@\'localhost\';');
                }
                mysqli_query($dbConn, 'COMMIT; ');

                // Confirm
                if (hisdb_usernameExists($dbConn, $username)) {
                    $_SESSION['msg']['success-signup'] = 'Registration Successful!';
                }
                else {
                    $err[] = 'Error uploading to database: ' . mysqli_error($dbConn);
                }

            }

            // Close connection
            mysqli_close($dbConn);

        }
        else {

            $err[] = 'Error connecting to database: ' . mysqli_connect_error();

        }

        if (count($err)) {
            $_SESSION['msg']['error-signup'] = implode('<br />', $err);
        }

        header('Location: main.php');
        exit;

    }

?>
