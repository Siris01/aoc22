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
	xH, yH := 0, 0
	x, y := [9]int{}, [9]int{}

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

     		newDir := dir

			for j := 0; j < 9; j++ {
				headX, headY := xH, yH
				if j > 0 {
					headX, headY = x[j-1], y[j-1]
				}

				if dist(headX, x[j]) <= 1 && dist(headY, y[j]) <= 1 { 
					continue
				} else if (headX == x[j]) {
					if headY > y[j] {  y[j]++; newDir = "U" } else { y[j]--; newDir = "D" }
				} else if (headY == y[j]) {
					if headX > x[j] { x[j]++; newDir = "R" } else { x[j]--; newDir = "L" }
				} else if (newDir == "R" || newDir == "L") {
          			if (newDir == "R") { x[j]++ } else { x[j]-- }
					if headY > y[j] { y[j]++; newDir = "U" } else { y[j]--; newDir = "D" }
				} else if (newDir == "U" || newDir == "D") {
          			if (newDir == "U") { y[j]++ } else { y[j]-- }
					if headX > x[j] { x[j]++; newDir = "R" } else { x[j]--; newDir = "L" }
				}
			}

			visited[Pos{x[8], y[8]}] = true
		}
    }

	fmt.Println(len(visited))
}
