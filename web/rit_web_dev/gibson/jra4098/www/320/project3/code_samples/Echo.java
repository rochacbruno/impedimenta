/**
 * Author(s):
 * Jeremy Audet
 * 
 * First Created: 03/26/2009
 * License: Creative Commons BY-SA   http://creativecommons.org/licenses/by-sa/3.0/
 */

 import java.io.Console;

 public class Echo {
    public static void main(String[] args) {
        Console userConsole = System.console();
        String input = userConsole.readLine("Input: ");
        userConsole.printf("%s\n", input);
    }
 }
