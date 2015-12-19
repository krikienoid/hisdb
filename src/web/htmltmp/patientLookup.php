<?php
    session_start();
    $err = array();
    if (!isset($_SESSION['id']) || $_SESSION['userrole'] > 2) {
        $err[] = 'You must be signed in to view this page!';
        $_SESSION['msg']['error-wrong-turn'] = implode('<br />', $err);
        header('Location: ../error.php');
        exit;
    }
?>
<div class="container">

    <h1>Patient Lookup</h1>

    <?php

        // Connect to database
        $dbConn = hisdb_dbUserConnect($_SESSION['username'], $_SESSION['password']);
        if ($dbConn) {

            // Count total number of records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT COUNT(*) ' .
                'AS TotalCount ' .
                'FROM DoctorPatientLookupView ' . ';'
            );
            $record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC);
            $totalCount = (int)$record['TotalCount'];
            mysqli_free_result($recordSet);

            // Number of records to retrieve
            $getStart = (is_numeric($_GET['start']))? (int)$_GET['start'] : 0;
            $getCount = (is_numeric($_GET['count']))? (int)$_GET['count'] : 10;
            if ($getStart < 0) {
                $getStart = 0;
            }

            // Number of records on next and previous pages
            $nextStart = $getStart + $getCount;
            $prevStart = $getStart - $getCount;
            $hasPrev   = $prevStart >= 0;
            $hasNext   = $nextStart < $totalCount;

    ?>

    <div class="fluid-container section-records">

        <table class="table table-hover table-lookup">

            <thead>
                <td>First Name</td>
                <td>Last Name</td>
                <td>Date of Birth</td>
                <td>Doctor</td>
                <td>Care Provider</td>
            </thead>

            <?php

            // Get records
            $recordSet = mysqli_query(
                $dbConn,
                'SELECT * ' .
                'FROM DoctorPatientLookupView ' .
                'LIMIT ' . $getCount . ' OFFSET ' . $getStart . ';'
            );

            // Print records as table
            while ($record = mysqli_fetch_array($recordSet, MYSQLI_ASSOC)) {

                echo '<tr onclick="location.href=\'patientView.php?patientid=' . $record['PatientID'] . '\';">';

                echo '<td>' . $record['FirstName']   . '</td>';
                echo '<td>' . $record['LastName']    . '</td>';
                echo '<td>' . $record['DateOfBirth'] . '</td>';
                echo '<td>' . $record['DoctorFirstName'] . ' ' . $record['DoctorLastName'] . '</td>';
                echo '<td>' . $record['CareProviderName'] . '</td>';

                echo '</tr>';

            };

            // Release records
            mysqli_free_result($recordSet);

            ?>

        </table>

        <?php

            // Close connection
            mysqli_close($dbConn);

            // Next and previous page buttons
            if ($hasPrev) {
                echo '<a class="btn" href="?start=' . $prevStart . '&count=' . $getCount . '">Previous</a>';
            }
            if ($hasPrev && $hasNext) {
                echo ' | ';
            }
            if ($hasNext) {
                echo '<a class="btn" href="?start=' . $nextStart . '&count=' . $getCount . '">Next</a>';
            }

        }
        else {

            $err[] = 'Error connecting to database:' . mysqli_connect_error();

        }

        ?>

    </div>

</div>
