<?php
    session_start();
    $err = array();
    if (!isset($_SESSION['id'])) {
        $err[] = 'You must be signed in to view this page!';
        $_SESSION['msg']['error-wrong-turn'] = implode('<br />', $err);
        header('Location: ../error.php');
        exit;
    }
?>
<div class="container">

    <h1>Patient Health Record</h1>

    <?php

        // Connect to database
        $dbConn = hisdb_dbUserConnect($_SESSION['username'], $_SESSION['password']);
        if ($dbConn) {

            // Escape input data
            if (isset($_GET['patientid'])) {
                $patientid = mysqli_real_escape_string($dbConn, $_GET['patientid']);
            }

            // If patient
            if (isset($_SESSION['patientid'])) {
                $patientid = $_SESSION['patientid'];
            }

    ?>

    <div class="fluid-container section-records">

        <div class="row">

            <div class="col-md-6">

                <table class="table table-info">

                    <?php

            // Get patient information records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT * ' .
                'FROM PatientPersonView ' .
                'WHERE PatientID = ' . $patientid . ';'
            );

            // Print records as table
            while ($record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC)) {
                echo '<h2 class="sub-header">' . $record['FirstName'] . ' ' . $record['LastName'] . '</h2>';
                echo '<tr><td>Date of Birth</td>' . '<td>' . $record['DateOfBirth'] . '</td></tr>';
                echo '<tr><td>Gender</td>'        . '<td>' . $record['GenderName']  . '</td></tr>';
                echo '<tr><td>Race</td>'          . '<td>' . $record['RaceName']    . '</td></tr>';
            };

            // Release records
            mysqli_free_result($recordSet);

                    ?>

                </table>

            </div>

            <div class="col-md-6"></div>

        </div>

        <div class="row">

            <?php

            // Get patient information records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT * ' .
                'FROM PatientInformationView ' .
                'WHERE PatientID = ' . $patientid . ';'
            );

            // Print records as table
            if ($record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC)) {
                echo '<div class="col-md-6">';
                    echo '<h2 class="sub-header">Address</h2>';
                    echo '<p>' . $record['StreetAddress1'] . '</p>';
                    if ($record['StreetAddress2']) echo '<p>' . $record['StreetAddress2'] . '</p>';
                    if ($record['POBox'])          echo '<p>P.O. Box ' . $record['POBox'] . '</p>';
                    echo '<p>' . $record['City'] . ', ' . $record['StateName'] . ' ' . $record['PostalCode'] . '</p>';
                echo '</div>';
                echo '<div class="col-md-6">';
                    echo '<h2 class="sub-header">Contact</h2>';
                    if ($record['MainPhone']) echo '<p><strong>Home Phone:</strong>&nbsp;' . $record['MainPhone'] . '</p>';
                    if ($record['WorkPhone']) echo '<p><strong>Work Phone:</strong>&nbsp;' . $record['WorkPhone'] . '</p>';
                    if ($record['AltPhone'])  echo '<p><strong>Cell Phone:</strong>&nbsp;' . $record['AltPhone']  . '</p>';
                    if ($record['MainEmail']) echo '<p><strong>Main Email:</strong>&nbsp;' . $record['MainEmail'] . '</p>';
                    if ($record['AltEmail'])  echo '<p><strong>Work Email:</strong>&nbsp;' . $record['AltEmail']  . '</p>';
                echo '</div>';
            };

            // Release records
            mysqli_free_result($recordSet);

            ?>

        </div>

    </div>

    <div class="fluid-container">

        <div class="row">

            <div class="col-md-6">

                <div class="fluid-container section-records">

                    <h3 class="sub-header">Vaccinations</h3>

                    <table class="table table-striped table-info table-records">

                        <?php

            // Get patient vaccination records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT * ' .
                'FROM PatientVaccinationRecordView ' .
                'WHERE PatientID = ' . $patientid . ';'
            );

            // Print records as table
            echo '<thead><td>Vaccine</td><td>Date</td></thead>';
            while ($record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC)) {
                echo '<tr>';
                echo '<td>' . $record['VaccinationName'] . '</td>';
                echo '<td>' . $record['VacDate'] . '</td>';
                echo '</tr>';
            };

            // Release records
            mysqli_free_result($recordSet);

                        ?>

                    </table>

                </div>

                <div class="fluid-container section-records">

                    <h3 class="sub-header">Medication History</h3>

                    <table class="table table-striped table-info table-records">

                        <?php

            // Get patient prescription records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT * ' .
                'FROM PatientPrescriptionRecordView ' .
                'WHERE PatientID = ' . $patientid . ';'
            );

            // Print records as table
            echo '<thead><td>Medication</td><td>Dosage</td><td>From</td><td>To</td></thead>';
            while ($record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC)) {
                echo '<tr>';
                echo '<td>' . $record['DrugName']  . '</td>';
                echo '<td>' . $record['Dosage']    . '</td>';
                echo '<td>' . $record['StartDate'] . '</td>';
                echo '<td>' . $record['EndDate']   . '</td>';
                echo '</tr>';
            };

            // Release records
            mysqli_free_result($recordSet);

                        ?>

                    </table>

                </div>

            </div>

            <div class="col-md-6">

                <div class="fluid-container section-records">

                    <h3 class="sub-header">Diagnosis History</h3>

                    <table class="table table-striped table-info table-records">

                        <?php

            // Get patient diagnosis records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT * ' .
                'FROM PatientDiagnosisRecordView ' .
                'WHERE PatientID = ' . $patientid . ';'
            );

            // Print records as table
            echo '<thead><td>Diagnosis</td><td>Date</td></thead>';
            while ($record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC)) {
                echo '<tr>';
                echo '<td>' . $record['DiagnosisName'] . '</td>';
                echo '<td>' . $record['DiagnosisDate'] . '</td>';
                echo '</tr>';
            };

            // Release records
            mysqli_free_result($recordSet);

                        ?>

                    </table>

                </div>

                <div class="fluid-container section-records">

                    <h3 class="sub-header">Procedure History</h3>

                    <table class="table table-striped table-info table-records">

                        <?php

            // Get patient procedure records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT * ' .
                'FROM PatientProcedureRecordView ' .
                'WHERE PatientID = ' . $patientid . ';'
            );

            // Print records as table
            echo '<thead><td>Procedure</td><td>Date</td></thead>';
            while ($record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC)) {
                echo '<tr>';
                echo '<td>' . $record['ProcedureName'] . '</td>';
                echo '<td>' . $record['ProcDate'] . '</td>';
                echo '</tr>';
            };

            // Release records
            mysqli_free_result($recordSet);

                        ?>

                    </table>

                </div>

            </div>

        </div>

    </div>

    <?php

            // Close connection
            mysqli_close($dbConn);

        }
        else {

            echo '<div class="fluid-container section-records">';
            echo 'Error connecting to database: ' . mysqli_error($dbConn);
            echo '</div>';

        }

    ?>

</div>
