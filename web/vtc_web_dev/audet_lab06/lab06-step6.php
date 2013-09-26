<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8'>
    <title>CIS-2450 Lab 6</title>
    <link rel="stylesheet" href="./styles.css" />
</head>
<body>
    <h1>Step 6</h1>
    <form method='post' action='./lab06-step6.php'>
        <p>
            <label>
                First Name<br />
                <input type='text' name='first_name' />
            </label>
        </p>
        <fieldset>
            <legend>Internet Access</legend>
            <p>
                Do you purchase Internet service from an internet service
                provider?
            </p>
            <p>
                <label>
                    <input type='radio' name='purchase' value='yes' >
                    Yes
                </label>
            <p>
                <label>
                    <input type='radio' name='purchase' value='no' >
                    No
                </label>
            </p>
        </fieldset>
        <fieldset>
            <legend>Internet Usage</legend>
            <p>If you use the web, which of the following do you use it for?</p>
            <p>
                <label>
                    <input type='checkbox' name='research' >
                    For research
                </label>
            </p>
            <p>
                <label>
                    <input type='checkbox' name='commerce' >
                    To purchase items electronically
                </label>
            </p>
            <p>
                <label>
                    <input type='checkbox' name='email' >
                    To send and receive email
                </label>
            </p>
            <p>
                <label>
                    <input type='checkbox' name='news' >
                    To read news
                </label>
            </p>
        </fieldset>
        <p><button>Submit</button></p>
    </form>
    <?php
        if($_POST) {
            $fields = array(
                'first_name', 'purchase', 'research', 'commerce', 'email',
                'news'
            );
            echo '<p>Here are the form fields and their values:</p>';
            echo '<dl>';
            for($i = 0; $i < count($fields); $i++) {
                $field = $fields[$i];
                echo "<dt>$field</dt>";
                echo '<dd>' . htmlspecialchars($_POST[$field]) . '</dd>';
            }
            echo '</dl>';
        } else {
            echo '<p>You have not yet submitted the form.</p>';
        }
    ?>
</body>
</html>
