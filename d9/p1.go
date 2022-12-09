package main

import (
	"fmt"
	"bufio"
	"os"
	"strings"
	"strconv"
)

type Pos struct {
	x, y interface{}
}

func mod(a int) int {
	if a < 0 {
		return a * -1
	}
	return a
}

func dist(a int, b int) int {
	if a < 0 && b < 0 {
		return mod(mod(a) - mod(b))
	} else if a > 0 && b > 0 {
		return mod(a - b)
	} 
	return mod(a) + mod(b)
}

func main() {
	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	visited := map[Pos]bool {Pos{0, 0}: true}
	xH, yH, xT, yT := 0, 0, 0, 0

    for scanner.Scan() {
        line := strings.Split(scanner.Text(), " ")
		dir := line[0]
		c, _ := strconv.Atoi(line[1])

		for i := 0; i < c; i++ {
			switch dir {
				case "R": xH++
				case "L": xH--
				case "U": yH++
				case "D": yH--
			}

			if dist(xH, xT) <= 1 && dist(yH, yT) <= 1 {
				continue
			} else if (xH == xT) {
				if yH > yT { yT++ } else { yT-- }
			} else if (yH == yT) {
				if xH > xT { xT++ } else { xT-- }
			} else {
				switch dir {
					case "R": xT++; yT = yH
					case "L": xT--; yT = yH
					case "U": yT++; xT = xH
					case "D": yT--; xT = xH
				}
			}

			visited[Pos{xT, yT}] = true
		}
    }

	fmt.Println(len(visited))
}
