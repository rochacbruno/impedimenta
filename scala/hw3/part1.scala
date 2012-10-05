/**
 * (5 pts) The List class contains a sortWith method that accepts a comparison
 * function used to define the sort order. That comparison function should
 * return true if the first parameter "comes before" the second in the desired
 * order.  Write a function strangeSort that takes a list of strings and returns
 * a new list sorted by the second character of each string. Strings that are
 * shorter than two characters should be first in the order (and sorted
 * according to their first and only character). For example sorting
 * List("aorld", "x", "a", "xello") should produce List("a", "x", "xello",
 * "aorld").
 */
object Main {
    /**
     * Returns true if ``first`` is less than or equal to ``second``, accoring
     * to the rules above.
     */
    def lessEqual(first: String, second: String): Boolean = {
        if(first.isEmpty)
            return true
        if(second.isEmpty)
            return false

        if(1 == first.length || 1 == second.length) {
            if(first.length < second.length)
                return true
            else if(first.length > second.length)
                return false
            else
                return first <= second
        }

        first(1) <= second(1)
    }

    /**
     * Inserts ``item`` into ``ordered_list``. Assumes that the list is already
     * sorted, according to the rules above.
     */
    def insert(item: String, ordered_list: List[String]): List[String] = {
        for(i <- ordered_list.indices) {
            if(lessEqual(item, ordered_list(i))) {
                val (before, after) = ordered_list.splitAt(i)
                return before ::: item :: after
            }
        }
        ordered_list ::: List(item)
    }

    /**
     * Sorts a list of strings according to the conditions outlined above.
     */
    def strangeSort(sort_me: List[String]): List[String] = {
        sort_me match {
            case List()       => List()
            case head :: tail => insert(head, strangeSort(tail))
        }
    }

    /**
     * Tests ``strangeSort()`` with a variety of inputs. Prints the results of
     * these exercises to stdout.
     */
    def main(args: Array[String]): Unit = {
        val lists = List(
            List(),
            List("one"),
            List("c", "b", "", "hurk", "hark", "e pty")
        )

        for(list <- lists) {
            println("list before sorting")
            println("-------------------")
            list.foreach((str: String) => println(str))
            println()
            println("list after sorting")
            println("------------------")
            strangeSort(list).foreach((str: String) => println(str))
            println()
        }
    }
}
