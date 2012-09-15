import scala.util.matching.Regex

/** Represents a numerical interval.
 *
 * See: https://en.wikipedia.org/wiki/Interval_%28mathematics%29
 */
class Interval(val min: Double, val max: Double) {
    /** Auxiliary Interval constructor. */
    def this() = this(0.0, 0.0)

    /** Returns a string representation of this interval. e.g. [1.0, 2.0] */
    override def toString(): String = {
        "[" + min.toString + ", " + max.toString + "]"
    }

    def +(other: Interval): Interval = {
        new Interval(min + other.min, max + other.max)
    }

    def -(other: Interval): Interval = {
        new Interval(min - other.max, max - other.min)
    }

    def *(other: Interval): Interval = {
        val minMaxCandidates: Array[Double] = Array(
            min * other.min,
            min * other.max,
            max * other.min,
            max * other.max
        )
        var newMin, newMax = minMaxCandidates(0)
        for(candidate <- minMaxCandidates) {
            if(candidate < newMin) newMin = candidate
            if(candidate > newMax) newMax = candidate
        }
        new Interval(newMin, newMax)
    }

    /** Returns this / other.
     *
     * Throws ArithmeticException if other.min or other.max is 0.
     */
    @throws(classOf[ArithmeticException])
    def /(other: Interval): Interval = {
        if(0 == other.min || 0 == other.max)
            throw new java.lang.ArithmeticException("internal division by zero")
        val minMaxCandidates: Array[Double] = Array(
            min / other.min,
            min / other.max,
            max / other.min,
            max / other.max
        )
        var newMin, newMax = minMaxCandidates(0)
        for(candidate <- minMaxCandidates) {
            if(candidate < newMin) newMin = candidate
            if(candidate > newMax) newMax = candidate
        }
        new Interval(newMin, newMax)
    }
}

/** Companion object to class Interval. */
object Interval {
    /** Auxiliary Interval constructor.
     *
     * If argument cannot be interpreted, throws a MatchError.
     */
    @throws(classOf[MatchError])
    def apply(interval: String): Interval = {
        val minMaxStr = """^\s*\[\s*(\d+.\d+)\s*,\s*(\d+.\d+)\s*\]\s*$""".r
        val minMaxStr(minStr: String, maxStr: String) = interval // throws
        new Interval(minStr.toDouble, maxStr.toDouble)
    }
}
