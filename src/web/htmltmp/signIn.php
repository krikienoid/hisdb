<?php
    session_start();
    $err = array();
    if (isset($_SESSION['id'])) {
        $err[] = 'You are already signed in!';
        $_SESSION['msg']['error-wrong-turn'] = implode('<br />', $err);
        header('Location: ../error.php');
        exit;
    }
?>
<div class="container">

    <h1>Home</h1>

    <div class="fluid-container section-records">

        <div class="row">

            <div class="col-md-6">

                <!-- Login Form -->
                <form action="signIn.php" method="post" class="form-signin">

                    <h3 class="form-signin-heading sub-header">Member Sign In</h3>

                    <?php
                        if ($_SESSION['msg']['error-signin']) {
                            // Output login errors
                            echo '<div class="text-danger error-msg">' . $_SESSION['msg']['error-signin'] . '</div>';
                            unset($_SESSION['msg']['error-signin']);
                        }
                    ?>

                    <p>
                        <label for="username">Username:</label>
                        <input type="text" name="username" id="username" value="" size="32" class="form-control" required />
                    </p>
                    <p>
                        <label for="password">Password:</label>
                        <input type="password" name="password" id="password" size="32" class="form-control" required />
                    </p>
                    <p>
                        <input type="submit" name="submit" value="Login" class="form-control" />
                    </p>

                </form>

            </div>

            <div class="col-md-6">

                <!-- Register Form -->
                <form action="signUp.php" method="post">

                    <h3 class="form-signin-heading sub-header">Register Today!</h3>

                    <?php

                        if ($_SESSION['msg']['error-signup']) {
                            // Output the registration errors
                            echo '<div class="text-danger error-msg">' . $_SESSION['msg']['error-signup'] . '</div>';
                            unset($_SESSION['msg']['error-signup']);
                        }

                        if ($_SESSION['msg']['success-signup']) {
                            // Output the registration successful message
                            echo '<div class="success">' . $_SESSION['msg']['success-signup'] . '</div>';
                            unset($_SESSION['msg']['success-signup']);
                        }

                    ?>

                    <p>
                        <label for="firstname">First Name:</label>
                        <input type="text" name="firstname" id="firstname" value="" size="32" class="form-control" required />
                    </p>
                    <p>
                        <label for="lastname">Last Name:</label>
                        <input type="text" name="lastname" id="lastname" value="" size="32" class="form-control" required />
                    </p>
                    <p>
                        <label for="dateofbirth">Date of Birth:</label>
                        <input type="date" name="dateofbirth" id="dateofbirth" value="" size="32" class="form-control" required />
                    </p>
                    <p>
                        <label for="username">Username:</label>
                        <input type="text" name="username" id="username" value="" size="32" class="form-control" required />
                    </p>
                    <p>
                        <label for="password">Password:</label>
                        <input type="password" name="password" id="password" size="32" class="form-control" required />
                    </p>
                    <p>
                        <label for="confirmpwd">Confirm Password:</label>
                        <input type="password" name="confirmpwd" id="confirmpwd" size="32" class="form-control" required />
                    </p>
                    <p>
                        <label for="email">Email:</label>
                        <input type="email" name="email" id="email" size="255"  class="form-control" required />
                    </p>
                    <p>
                        <input type="submit" name="submit" value="Register" class="form-control" />
                    </p>

                </form>

            </div>

        </div>

    </div>

</div>
