import scala.util.matching.Regex

// TODO: add docstrings

class Interval(val min: Double, val max: Double) {
    def this() = this(0.0, 0.0)

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

object Interval {
    def apply(interval: String): Interval = {
        val minMaxStr = """^\s*\[\s*(\d+.\d+)\s*,\s*(\d+.\d+)\s*\]\s*$""".r
        val (min: Double, max: Double) = try {
            val minMaxStr(minStr, maxStr) = interval
            (minStr.toDouble, maxStr.toDouble)
        } catch {
            case err: scala.MatchError =>
                (0.0, 0.0)
        }
        new Interval(min, max)
    }
}
