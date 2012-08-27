#!/bin/sh
exec scala "$0" "$@"
!#

object Main {
  def main(args: Array[String]) {
    println("Hello, World!")
  }
}
