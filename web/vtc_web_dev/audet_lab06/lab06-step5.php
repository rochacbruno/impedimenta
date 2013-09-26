<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8'>
    <title>CIS-2450 Lab 6</title>
    <link rel="stylesheet" href="./styles.css" />
</head>
<body>
    <h1>Step 5</h1>
    <p class='banner'>
    <?php
        /* Echo a banner containing $message.
         *
         * $message is string. If `$message = '12'`, then the following banner
         * will be created:
         *
         *     ******
         *     * 12 *
         *     ******
         */
        function banner($message) {
            $decoration = '*';
            $prefix = $decoration . ' ';
            $postfix = ' ' . $decoration;
            $line_len = strlen($prefix) + strlen($message) + strlen($postfix);

            for($i = 0; $i < $line_len; $i++) {
                echo $decoration;
            }
            echo '<br />';
            echo $prefix . $message . $postfix;
            echo '<br />';
            for($i = 0; $i < $line_len; $i++) {
                echo $decoration;
            }
            echo '<br />';
        }

        $message1 = 'Hi everyone, I\'m in the CIS-2450 Lab!';
        $message2 = 'Hello everybody, I am working on the CIS-2450 Lab.';
        banner($message1);
        banner($message2);
    ?> 
    </p>
</body>
</html>
