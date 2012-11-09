//-----------------------------------------------------------------------
// FILE    : Tree.scala
// SUBJECT : Some binary tree handling methods to illustrate case class pattern matching.
// AUTHOR  : (C) Copyright 2012 by Peter C. Chapin <PChapin@vtc.vsc.edu>
//
// This is a demonstration program for CIS-3030, Programming Languages. It illustrates the use
// of pattern matching with case classes.
// -----------------------------------------------------------------------
package hw4

sealed abstract class Tree[+A]

case object Leaf extends Tree

case class Node[+A](left: Tree[A], data: A, right: Tree[A]) extends Tree[A]

object Tree {
    class EmptyTreeException(message: String) extends Exception(message)

    /**
     * Returns the number of nodes in Tree t.
     *
     * Note that t is covariant. Therefore, it's possible to write code like
     * this:
     *
     *     val ints: Node[Int] = new Node[Int](Leaf, 10, Leaf)
     *     println(Tree.size(ints))
     *
     */
    def size[A](t: Tree[A]): Int =
        t match {
            case Leaf => 0
            case Node(left, _, right) => size(left) + size(right) + 1
        }

    def insert[A <: Ordered[A]](t: Tree[A], value: A): Tree[A] = 
        t match {
            case Leaf => Node(Leaf, value, Leaf)
            case Node(left, data, right) =>
                if (value == data) Node(left, data, right)
                else if (value < data) Node(insert(left, value), data, right)
                else Node(left, data, insert(right, value))
        }

    def lookup[A <: Ordered[A]](t: Tree[A], value: A): Boolean =
        t match {
            case Leaf => false
            case Node(left, data, right) =>
                if (value == data) true
                else if (value < data) lookup(left, value)
                else lookup(right, value)
        }

/*
    def min[A](t: Tree[A]): A = {
        def minHelper[A](t: Tree[A], currentMin: A): A =
            t match {
                case Leaf => currentMin
                case Node(left, data, _) => minHelper(left, data)
            }
        if (t == Leaf) throw new EmptyTreeException("No minimum element in an empty tree")
        else minHelper(t, Int.MaxValue)
    }

    def max[A](t: Tree[A]): A = {
        def maxHelper[A](t: Tree[A], currentMax: A): A =
            t match {
                case Leaf => currentMax
                case Node(_, data, right) => maxHelper(right, data)
            }
        if (t == Leaf) throw new EmptyTreeException("No maximum element in an empty tree")
        else maxHelper(t, Int.MinValue)
    }
*/
}
