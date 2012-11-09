import hw4.Tree
import hw4.Node
import hw4.Leaf

object Main {
    def main(args: Array[String]) = {
        val life: Node[Int] = new Node[Int](Leaf, 10, Leaf)
        println(Tree.size(life))
        println("Job's done!")
    }
}
