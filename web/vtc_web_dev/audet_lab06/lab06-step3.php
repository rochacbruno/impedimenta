<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8'>
    <title>CIS-2450 Lab 6</title>
    <link rel="stylesheet" href="./styles.css" />
</head>
<body>
    <h1>Step 3</h1>
    <p class='banner'>
    <?php
        $width = 6;
        $height = 8;
        $char = 'x';
        for($row = 0; $row < $height; $row++) {
            for($col = 0; $col < $width; $col++) {
                echo $char;
            }
            echo '<br />';
        }
    ?> 
    </p>
</body>
</html>
