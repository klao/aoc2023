import java.io.File
import kotlin.io.println

val input_file = "../../in/i04.txt"

fun part1() {
    var sum = 0
    File(input_file).bufferedReader().forEachLine {
        val l = it.split(":")[1].trim()
        val p = l.split("|")
        val winning = p[0].trim().split(" ").filter { it.length > 0 }.map { it.toInt() }.toSet()
        val my = p[1].trim().split(" ").filter { it.length > 0 }.map { it.toInt() }
        var w = 0
        for (i in my) {
            if (winning.contains(i)) {
                w++
            }
        }
        if (w > 0) {
            sum += 1 shl (w - 1)
        }
    }
    println(sum)
}

fun part2() {
    var sum = 0
    var copies = Array(1000) { 1 }
    var n = 0
    File(input_file).bufferedReader().forEachLine {
        sum += copies[n]
        // print(copies[n])
        // print(" ")
        val l = it.split(":")[1].trim()
        val p = l.split("|")
        val winning = p[0].trim().split(" ").filter { it.length > 0 }.map { it.toInt() }.toSet()
        val my = p[1].trim().split(" ").filter { it.length > 0 }.map { it.toInt() }
        var w = 0
        for (i in my) {
            if (winning.contains(i)) {
                w++
            }
        }
        // println(w)
        for (i in 1 until w + 1) {
            copies[n + i] += copies[n]
        }
        n++
    }
    println(sum)
}

fun main() {
    part1()
    part2()
}
