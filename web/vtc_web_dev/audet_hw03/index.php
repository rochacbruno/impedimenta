<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8'>
    <title>TIME U.S. Covers</title>
    <link rel="stylesheet" href="./styles.css" />
</head>
<body>
    <h1>Time U.S. Covers</h1>
    <p>Enter a date to see the TIME U.S. magazine cover for that week.</p>
    <form name='getcover' method='get' action='index.php'>
        <p>
            <label>
                Date:<br />
                <input name='date' type='text' placeholder='mm/dd/yyyy' />
            </label>
        </p>
        <button>Get a Cover!</button>
    </form>
    <?php
    function parseForm() {
        if(!isset($_GET['date'])) {
            echo('<p>Form has not yet been submitted.</p>');
            return;
        }
        if(!preg_match('|^(\d{2})/(\d{2})/(\d{4})$|', $_GET['date'], $matches)) {
            echo('<p>Incorrectly formed input.</p>');
            return;
        }
        $year = $matches[3];
        $month = $matches[1];
        $day = $matches[2];
        if(!checkdate($month, $day, $year)) {
            echo('<p>Date not in valid range.</p>');
            return;
        }
        $date = getdate(mktime(0, 0, 0, $month, $day, $year));
        $day_offset = (7 + $date['wday'] - 1) % 7;
        // All issues are published on Monday.
        $mon_tstamp = mktime(0, 0, 0, $month, $day - $day_offset, $year);
        $mon_string = date('m/d/Y', $mon_tstamp);
        $mon_url = htmlspecialchars(
            "http://img.timeinc.net/time/magazine/archive/covers/" .
            date('Y/1101ymd', $mon_tstamp) .
            "_400.jpg"
        );
        echo(
            "<figure>" .
            "    <img" .
            "        src='$mon_url'" .
            "        alt='$mon_string'" .
            "    />" .
            "    <figcaption>" .
            "        Time U.S. cover for the issue published on $mon_string." .
            "    </figcaption>" .
            "</figure>"
        );
    }
    date_default_timezone_set('UTC');
    parseForm();
    ?>
</body>
</html>
