//-----------------------------------------------------------------------
// FILE    : Rational.scala
// SUBJECT : A class that represents rational numbers.
// AUTHOR  : (C) Copyright 2012 by Peter C. Chapin <PChapin@vtc.vsc.edu>
//
// This is a demonstration program for CIS-3030, Programming Languages. This version illustrates
// the Ordered trait (see section 19.8 in PiS fo more information) and the Numeric type class.
// -----------------------------------------------------------------------

class Rational(n: Int, d: Int = 1) extends Ordered[Rational] {
  require(d != 0, "Invalid Rational denominator")

  private val commonDivisor = gcd(n.abs, d.abs)
  private val signFlag = integerSign(n) * integerSign(d)
  val numer: Int = signFlag * (n.abs / commonDivisor)
  val denom: Int = d.abs / commonDivisor

  override def toString = numer + "/" + denom

  def +(that: Rational) =
    new Rational(
      numer * that.denom + that.numer * denom,
      denom * that.denom)

  def -(that: Rational) =
    new Rational(
      numer * that.denom - that.numer * denom,
      denom * that.denom)

  def *(that: Rational) =
    new Rational(numer * that.numer, denom * that.denom)

  def /(that: Rational) =
    new Rational(numer * that.denom, denom * that.numer)

  def compare(that: Rational) = {
    val leftNumer = numer * that.denom
    val rightNumer = that.numer * denom
    if (leftNumer < rightNumer) -1
    else if (leftNumer == rightNumer) 0
    else 1
  }

  private def integerSign(n: Int) =
    if (n < 0) -1 else 1

  private def gcd(a: Int, b: Int): Int =
    if (b == 0) a else gcd(b, a % b)
}

class RationalIsNumeric extends Numeric[Rational] {
  def compare (x: Rational, y: Rational) = x compare y
  def fromInt (x: Int)                   = Rational(x, 1)
  def minus   (x: Rational, y: Rational) = x - y
  def negate  (x: Rational)              = Rational(-x.numer, x.denom)
  def plus    (x: Rational, y: Rational) = x + y
  def times   (x: Rational, y: Rational) = x * y
  def toDouble(x: Rational)              = x.numer.toDouble / x.denom.toDouble
  def toFloat (x: Rational)              = x.numer.toFloat / x.denom.toFloat
  def toInt   (x: Rational)              = x.numer / x.denom
  def toLong  (x: Rational)              = x.numer.toLong / x.denom.toLong
}
 
object Rational {
  def apply(n: Int, d: Int = 1) = new Rational(n, d)
  implicit val ratNumeric = new RationalIsNumeric
}
