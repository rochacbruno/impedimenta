//-----------------------------------------------------------------------
// FILE    : Tree.scala
// SUBJECT : Some binary tree handling methods to illustrate case class pattern matching.
// AUTHOR  : (C) Copyright 2012 by Peter C. Chapin <PChapin@vtc.vsc.edu>
//
// This is a demonstration program for CIS-3030, Programming Languages. It illustrates the use
// of pattern matching with case classes.
// -----------------------------------------------------------------------
package hw4

/**
 * Classes that implement <code>OrderedProperties[A]</code> must implement
 * <code>minimum</code>, <code>maximum</code>, and <code>compare</code>.
 */
abstract class OrderedProperties[A] extends Ordered[A] {
    def minimum(): A
    def maximum(): A
}

sealed abstract class Tree[+A]

/**
 * An empty sub-tree in a tree.
 */
case object Leaf extends Tree

/**
 * <code>Node</code> contains <code>data</code> and two sub-trees, <code>left
 * </code> and <code>right</code>. Note that <code>Leaf</code> is also a <code>
 * Tree</code>, so each sub-tree may be either another <code>Node</code> or a
 * <code>Leaf</code>.
 */
case class Node[+A](left: Tree[A], data: A, right: Tree[A]) extends Tree[A]

/**
 * Companion object to abstract class <code>Tree</code>. Provides methods for
 * working with binary trees.
 */
object Tree {
    /** Returns the number of nodes in tree <code>t</code>. */
    def size[A](t: Tree[A]): Int =
        t match {
            case Leaf => 0
            case Node(left, _, right) => size(left) + size(right) + 1
        }

    /**
     * Returns a tree identical to <code>t</code>, but into which <code>value
     * </code> has been inserted.
     */
    def insert[A <: Ordered[A]](t: Tree[A], value: A): Tree[A] = 
        t match {
            case Leaf => Node(Leaf, value, Leaf)
            case Node(left, data, right) =>
                if     (value == data) Node(left, data, right)
                else if(value <  data) Node(insert(left, value), data, right)
                else                   Node(left, data, insert(right, value))
        }

    /**
     * Returns true if <code>value</code> is in tree <code>t</code>, else false.
     */
    def lookup[A <: Ordered[A]](t: Tree[A], value: A): Boolean =
        t match {
            case Leaf => false
            case Node(left, data, right) =>
                if     (value == data) true
                else if(value <  data) lookup(left, value)
                else                   lookup(right, value)
        }

    /**
     * Returns the minimum value in tree <code>t</code>.
     */
    def min[A <: OrderedProperties[A]](t: Node[A]): A = {
        def minHelper[A](t: Tree[A], currentMin: A): A =
            t match {
                case Leaf                => currentMin
                case Node(left, data, _) => minHelper(left, data)
            }
        minHelper(t, t.data.minimum())
    }

    /**
     * Returns the maximum value in tree <code>t</code>.
     */
    def max[A <: OrderedProperties[A]](t: Node[A]): A = {
        def maxHelper[A](t: Tree[A], currentMax: A): A =
            t match {
                case Leaf => currentMax
                case Node(_, data, right) => maxHelper(right, data)
            }
        maxHelper(t, t.data.maximum())
    }
}
