import java.io.File

val input_file = "../../in/i01.txt"

fun part1() {
    var sum = 0
    File("../../in/i01.txt").bufferedReader().forEachLine {
        val ms = Regex("""\d""").findAll(it)
        val f = ms.first().value.toInt()
        val l = ms.last().value.toInt()
        sum += 10 * f + l
    }
    println(sum)
}

val digit_map = mapOf(
    "one" to 1,
    "two" to 2,
    "three" to 3,
    "four" to 4,
    "five" to 5,
    "six" to 6,
    "seven" to 7,
    "eight" to 8,
    "nine" to 9
)

fun digit(s: String): Int {
    if (s in digit_map) {
        return digit_map[s]!!
    }
    return s.toInt()
}

fun part2() {
    var sum = 0
    File("../../in/i01.txt").bufferedReader().forEachLine {
        // It's not enough to find "all of the matches" because some matches overlap and
        // findAll() doesn't handle that.
        // val ms = Regex("""\d|one|two|three|four|five|six|seven|eight|nine""").findAll(it)

        val fm = Regex(""".*?(\d|one|two|three|four|five|six|seven|eight|nine)""").find(it)
        val f = digit(fm!!.groupValues.last())
        val lm = Regex(""".*(\d|one|two|three|four|five|six|seven|eight|nine)""").find(it)
        val l = digit(lm!!.groupValues.last())
        sum += 10 * f + l
    }
    println(sum)
}

fun main() {
    part1()
    part2()
}
