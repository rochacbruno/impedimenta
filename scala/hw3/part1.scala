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
    def lessEqual(first: Int, second: Int): Boolean = {
        if(first <= second)
            return true
        else
            return false
    }

    /**
     * Inserts ``item`` into ``ordered_list``. Assumes that the list is already
     * sorted, according to the rules above.
     */
    def insert(item: Int, ordered_list: List[Int]): List[Int] = {
        for(i <- ordered_list.indices) {
            if(lessEqual(item, ordered_list(i))) {
                val (before, after) = ordered_list.splitAt(i)
                return before ::: item :: after
            }
        }
        ordered_list ::: List(item)
    }

    def strangeSort(sort_me: List[Int]): List[Int] = {
        sort_me match {
            case List()       => List()
            case head :: tail => insert(head, strangeSort(tail))
        }
    }

    def main(args: Array[String]): Unit = {
    /*
        val sort_me = List("c", "b", "", "hurk", "hark")

        println("List before sorting.")
        println("--------------------")
        sort_me.foreach((str: String) => println(str))
        println()
        println("List after sorting.")
        println("-------------------")
        strangeSort(sort_me).foreach((str: String) => println(str))
    */
        val sort_me = List(2, 1, 0, 3, 4)
        println("List before sorting.")
        println("--------------------")
        sort_me.foreach((num: Int) => println(num))
        println()
        println("List after sorting.")
        println("-------------------")
        strangeSort(sort_me).foreach((num: Int) => println(num))
    }
}
