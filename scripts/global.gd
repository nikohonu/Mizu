extends Node

var maps = [
	[[1, 2, 0, 0], [1, 0, 1, 0], [1, 2, 2, 2], [], []], # 1
	[[1, 2, 1, 2], [1, 1, 0, 2], [0, 2, 0, 0], [], []], # 2
	[[1, 2, 2, 1], [2, 0, 0, 2], [0, 0, 1, 1], [], []], # 3
	[[1, 0, 1, 2], [1, 2, 1, 0], [2, 0, 2, 0], [], []], # 4
	[[1, 1, 2, 2], [2, 1, 2, 0], [1, 0, 0, 0], [], []], # 5
	[[1, 4, 3, 2], [1, 1, 2, 4], [2, 2, 0, 0], [3, 3, 0, 3], [1, 4, 4, 0], [], []], # 6
	[[3, 1, 1, 0], [4, 4, 2, 3], [0, 4, 4, 1], [3, 3, 2, 1], [2, 2, 0, 0], [], []], # 7
	[[1, 3, 2, 3], [4, 3, 4, 2], [1, 3, 1, 4], [1, 4, 2, 0], [2, 0, 0, 0], [], []], # 8
	[[1, 2, 1, 0], [4, 1, 2, 3], [4, 0, 2, 3], [3, 4, 4, 2], [0, 1, 3, 0], [], []], # 9
	[[1, 1, 2, 3], [3, 4, 3, 1], [1, 0, 0, 2], [3, 4, 2, 0], [4, 4, 0, 2], [], []], # 10
	[[3, 6, 4, 6], [3, 1, 3, 5], [7, 2, 4, 1], [2, 6, 0, 1], [0, 0, 1, 0], [5, 7, 2, 3], [6, 5, 4, 4], [7, 2, 5, 7], [], []], # 11
	[[0, 4, 2, 0], [7, 4, 2, 5], [1, 0, 6, 3], [4, 5, 7, 4], [6, 7, 3, 6], [7, 3, 5, 6], [0, 1, 5, 1], [3, 1, 2, 2], [], []], # 12
	[[0, 7, 2, 4], [0, 6, 4, 1], [2, 7, 3, 6], [7, 1, 3, 4], [7, 5, 0, 1], [1, 5, 0, 4], [5, 3, 2, 5], [6, 3, 2, 6], [], []], # 13
	[[5, 3, 5, 0], [7, 5, 3, 2], [2, 6, 6, 6], [5, 3, 7, 4], [4, 0, 7, 7], [2, 1, 3, 2], [6, 4, 1, 0], [1, 1, 4, 0], [], []], # 14
	[[5, 3, 5, 0], [7, 5, 3, 2], [2, 6, 6, 6], [5, 3, 7, 4], [4, 0, 7, 7], [2, 1, 3, 2], [6, 4, 1, 0], [1, 1, 4, 0], [], []], # 15
	[[6, 2, 6, 1], [9, 8, 3, 2], [5, 8, 4, 7], [8, 9, 3, 8], [2, 9, 0, 9], [2, 3, 5, 6], [0, 0, 4, 3], [4, 6, 1, 7], [7, 1, 4, 1], [5, 5, 7, 0], [], []], # 16
	[[7, 7, 4, 0], [7, 2, 1, 0], [7, 6, 2, 8], [6, 9, 9, 2], [4, 5, 4, 9], [8, 0, 3, 4], [8, 2, 8, 1], [1, 6, 6, 9], [5, 0, 1, 3], [5, 3, 3, 5], [], []], # 17
	[[6, 0, 2, 2], [1, 6, 3, 7], [6, 1, 6, 8], [1, 9, 4, 0], [2, 7, 9, 1], [2, 4, 4, 9], [5, 3, 7, 3], [4, 5, 3, 0], [5, 9, 0, 5], [8, 8, 8, 7], [], []], # 18
	[[7, 2, 4, 9], [4, 1, 9, 4], [8, 0, 7, 5], [0, 0, 5, 7], [6, 1, 7, 9], [2, 4, 1, 0], [9, 5, 1, 2], [5, 6, 3, 2], [6, 3, 6, 8], [8, 3, 8, 3], [], []], # 19
	[[8, 7, 2, 6], [4, 4, 0, 7], [3, 9, 0, 8], [5, 4, 5, 1], [6, 9, 5, 9], [2, 4, 9, 1], [0, 2, 6, 6], [7, 3, 3, 0], [8, 5, 1, 1], [2, 8, 7, 3], [], []], # 20
	[[12, 4, 2, 0], [6, 8, 0, 5], [8, 5, 1, 5], [0, 7, 11, 12], [0, 1, 3, 12], [12, 8, 9, 9], [3, 8, 6, 9], [2, 6, 10, 1], [9, 6, 3, 11], [1, 10, 5, 10], [7, 11, 7, 2], [11, 10, 7, 3], [4, 4, 2, 4], [], []], # 21
	[[3, 4, 5, 2], [6, 0, 4, 1], [11, 6, 12, 0], [11, 8, 11, 12], [0, 8, 7, 7], [7, 1, 12, 7], [4, 8, 6, 8], [6, 4, 0, 10], [2, 3, 10, 11], [9, 3, 1, 3], [1, 12, 10, 10], [5, 5, 2, 9], [2, 5, 9, 9], [], []], # 22
	[[2, 4, 11, 10], [7, 12, 2, 5], [0, 10, 8, 10], [8, 12, 2, 8], [1, 1, 11, 1], [11, 0, 1, 3], [3, 7, 5, 9], [8, 10, 5, 7], [0, 11, 3, 9], [7, 12, 4, 5], [6, 6, 3, 4], [4, 2, 0, 6], [12, 6, 9, 9], [], []], # 23
	[[12, 12, 3, 3], [8, 8, 1, 10], [10, 9, 12, 7], [2, 5, 11, 9], [8, 6, 2, 8], [5, 6, 1, 9], [4, 12, 5, 1], [0, 4, 7, 1], [10, 7, 0, 7], [9, 4, 2, 5], [10, 2, 6, 11], [11, 6, 3, 4], [0, 11, 0, 3], [], []], # 24
	[[5, 11, 9, 1], [10, 11, 11, 0], [4, 1, 7, 6], [11, 9, 1, 3], [3, 4, 5, 7], [1, 5, 9, 0], [6, 10, 6, 12], [10, 9, 2, 12], [10, 3, 5, 0], [2, 2, 0, 12], [8, 8, 4, 6], [2, 3, 12, 4], [8, 7, 8, 7], [], []], # 25	
]

var current_level = 1
