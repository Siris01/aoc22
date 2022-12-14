import java.io.File
import java.io.InputStream

val map = Array(999) { Array(999) { true } }

fun processLine(line: String) {
    val points = line.split(" -> ").toTypedArray()

    for (i in 0..(points.count() - 2)) {
        val src = points[i].split(",").toTypedArray().map { it.toInt() }
        val dest = points[i + 1].split(",").toTypedArray().map { it.toInt() }

        if (src[0] == dest[0]) {
            val y = src[0]
            if (src[1] < dest[1]) {
                for (j in src[1]..dest[1]) map[j][y] = false
            } else {
                for (j in dest[1]..src[1]) map[j][y] = false
            }
        } else if (src[1] == dest[1]) {
            val x = src[1]
            if (src[0] < dest[0]) {
                for (j in src[0]..dest[0]) map[x][j] = false
            } else {
                for (j in dest[0]..src[0]) map[x][j] = false
            }
        }
    }
}

fun fall(a: Int, b: Int, c: Int): Boolean {
    if (c > 500) return false

    if (map[b + 1][a]) return fall(a, b + 1, c + 1)
    else if (map[b + 1][a - 1]) return fall(a - 1, b + 1, c + 1)
    else if (map[b + 1][a + 1]) return fall(a + 1, b + 1, c + 1)
    else map[b][a] = false
    return true
}

fun main() {
    val inputStream: InputStream = File("input.txt").inputStream()
    inputStream.bufferedReader().forEachLine { processLine(it) }

    var count = 0

    while (true) {
        if (fall(500, 0, 0)) count++ else break
    }

    print(count)
}
