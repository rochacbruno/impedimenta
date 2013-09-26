<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8'>
    <title>CIS-2450 Lab 6</title>
    <link rel="stylesheet" href="./styles.css" />
</head>
<body>
    <h1>Step 4</h1>
    <p class='banner'>
    <?php
        /* Echo a banner containing $message.
         *
         * $message is an array of characters. If `$message = array('1', '2')`,
         * then the following banner will be created:
         *
         *     ******
         *     * 12 *
         *     ******
         */
        function banner($message) {
            $decoration = '*';
            $prefix = $decoration . ' ';
            $postfix = ' ' . $decoration;
            $line_len = strlen($prefix) + count($message) + strlen($postfix);

            for($i = 0; $i < $line_len; $i++) {
                echo $decoration;
            }
            echo '<br />';
            echo $prefix . implode($message) . $postfix;
            echo '<br />';
            for($i = 0; $i < $line_len; $i++) {
                echo $decoration;
            }
            echo '<br />';
        }

        $message1 = array(
            'H', 'i', ' ', 'e', 'v', 'e', 'r', 'y', 'o', 'n', 'e', ',', ' ',
            'I', '\'', 'm', ' ', 'i', 'n', ' ', 't', 'h', 'e', ' ', 'C', 'I',
            'S', '-', '2', '4', '5', '0', ' ', 'L', 'a', 'b', '!'
        );
        $message2 = array(
            'H', 'e', 'l', 'l', 'o', ' ', 'e', 'v', 'e', 'r', 'y', 'b', 'o',
            'd', 'y', ',', ' ', 'I', ' ', 'a', 'm', ' ', 'w', 'o', 'r', 'k',
            'i', 'n', 'g', ' ', 'o', 'n', ' ', 't', 'h', 'e', ' ', 'C', 'I',
            'S', '-', '2', '4', '5', '0', ' ', 'L', 'a', 'b', '.',
        );
        banner($message1);
        banner($message2);
    ?> 
    </p>
</body>
</html>
