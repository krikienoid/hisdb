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

        <h1>List of Drugs</h1>

        <?php

            // Connect to database
            $dbConn = hisdb_dbConnect();
            if ($dbConn) {

                // Count total number of records
                $recordSet = mysqli_query(
                    $dbConn,
                    'SELECT COUNT(*) ' .
                    'AS TotalCount ' .
                    'FROM DrugKind ' . ';'
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
                    <td>Name</td>
                    <td colspan="6">Codes</td>
                </thead>

                <?php

                // Get records
                $recordSetCells = mysqli_query(
                    $dbConn,
                    'SELECT * FROM DrugKind ' .
                    'LIMIT ' . $getCount . ' OFFSET ' . $getStart . ';'
                );

                // Print records as table.
                while($record = mysqli_fetch_array($recordSetCells, MYSQLI_ASSOC)) {
                    echo '<tr>';
                    echo '<td>' . $record['DrugName']  . '</td>';
                    echo '<td>' . $record['DrugCode1'] . '</td>';
                    echo '<td>' . $record['DrugCode2'] . '</td>';
                    echo '<td>' . $record['DrugCode3'] . '</td>';
                    echo '<td>' . $record['DrugCode4'] . '</td>';
                    echo '<td>' . $record['DrugCode5'] . '</td>';
                    echo '<td>' . $record['DrugCode6'] . '</td>';
                    echo '</tr>';
                };

                // Release records
                mysqli_free_result($recordSetCells);

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

</body>

</html>
