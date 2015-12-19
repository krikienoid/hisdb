<?php

    $hisdb_dbName = 'hisdbx10_his';

    $hisdb_ROLE_ADMIN   = 1;
    $hisdb_ROLE_DOCTOR  = 2;
    $hisdb_ROLE_PATIENT = 3;

    // DB Connection

    function hisdb_dbConnect () {
        global $hisdb_dbName;
        return mysqli_connect('localhost', 'hisdbx10', 'pozhalujsta', $hisdb_dbName);
    }

    function hisdb_dbUserConnect ($username, $password) {
        global $hisdb_dbName;
        return mysqli_connect('localhost', $username, $password, $hisdb_dbName);
    }

    // DB Users

    function hisdb_usernameExists ($dbConn, $username) {
        $recordSet = mysqli_query(
            $dbConn,
            'SELECT UserID, UserName ' .
            'FROM LoginUser ' .
            'WHERE UserName = \'' . $username . '\';'
        );
        $record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
        mysqli_free_result($recordSet);
        return !!$record['UserName'];
    }

    function hisdb_findPatient ($dbConn, $firstname, $lastname, $dateofbirth) {
        $recordSet = mysqli_query(
            $dbConn,
            'SELECT * ' .
            'FROM PatientPersonView ' .
            'WHERE FirstName = \'' . $firstname . '\' ' .
            'AND LastName = \'' . $lastname . '\' ' .
            'AND DateOfBirth = \'' . date('Y-m-d', strtotime($dateofbirth)) . '\';'
        );
        $record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
        mysqli_free_result($recordSet);
        return $record;
    }

    function hisdb_findDoctor ($dbConn, $firstname, $lastname) {
        $recordSet = mysqli_query(
            $dbConn,
            'SELECT * ' .
            'FROM DoctorPersonView ' .
            'WHERE FirstName = \'' . $firstname . '\' ' .
            'AND LastName = \'' . $lastname . '\';'
        );
        $record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
        mysqli_free_result($recordSet);
        return $record;
    }

    function hisdb_hasPatientAccount ($dbConn, $patientid) {
        $recordSet = mysqli_query(
            $dbConn,
            'SELECT LoginUserID ' .
            'FROM Patient ' .
            'WHERE PatientID = \'' . $patientid . '\';'
        );
        $record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
        mysqli_free_result($recordSet);
        return $record['LoginUserID'];
    }

    function hisdb_hasDoctorAccount ($dbConn, $doctorid) {
        $recordSet = mysqli_query(
            $dbConn,
            'SELECT LoginUserID ' .
            'FROM Doctor ' .
            'WHERE DoctorID = \'' . $doctorid . '\';'
        );
        $record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
        mysqli_free_result($recordSet);
        return $record['LoginUserID'];
    }

?>
