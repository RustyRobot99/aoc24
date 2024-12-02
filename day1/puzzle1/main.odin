package main

import "core:os"
import "core:strings"
import "core:fmt"
import "core:strconv"
import "core:sort"
import "core:math"

to_int :: proc(str: string) -> int {
	n, ok := strconv.parse_int(str)
	
	if !ok {
		return 0
	}

	return n
}

spliter :: proc(text: string) -> (string, string) {
	test := text
	temp: [dynamic]string
	defer delete(temp)
	for str in strings.split_iterator(&test , "   ") {
		append(&temp, str)
	}

	return temp[0], temp[1]
}

read_file :: proc(filepath: string) -> ([]int, []int) {
	data, ok := os.read_entire_file(filepath, context.allocator)
	defer delete(data, context.allocator)

	left: [dynamic]int
	right: [dynamic]int

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		a, b := spliter(line)
		append(&left, to_int(a))
		append(&right, to_int(b))
	}

	return left[:], right[:]
}

main :: proc() {
	left, right := read_file("./input.txt")

	sort.bubble_sort(left[:])
	sort.bubble_sort(right[:])

	arr_add: [dynamic]int
	defer delete(arr_add)
	for value, index in left {
		append(&arr_add, math.abs(left[index] - right[index]))
	}

	result: int = 0
	for value in arr_add {
		result += value
	}

	fmt.println(result)
}
