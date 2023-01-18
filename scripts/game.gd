extends Node2D


export (int, 5, 15) var bottle_count = 5
var map = []
var bottles = []
var current = null
var win = false
var step_count = 0



func _ready():
	var bottle_scene = preload("res://bottle.tscn")
	var start_y = 170 + ((2 - ((bottle_count - 1) / 5)) * 75)
	for i in range(bottle_count):
		var bottle = bottle_scene.instance()
		var x = i % 5
		var y = i / 5
		var current_min_x = min(bottle_count - (5 * y), 5)
		bottle.position.y = start_y + ((6 + 144) * y)
		bottle.position.x = (40+(5-current_min_x)*35) + ((10 + 60) * x)
		bottle
		bottle.connect("pressed", self, "click")
		add_child(bottle)
		bottles.append(bottle)
	generate_map()
	update()


func generate_map():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	map.resize(bottle_count)
	for i in range(bottle_count):
		map[i] = []
	var need = []
	var color_count = bottle_count - 2
	need.resize(color_count)
	need.fill(0)
	for i in range(color_count):
		for j in range(4):
			while true:
				var value = rng.randi_range(0, color_count - 1) # (0, 1, 2) = 3
				if need[value] < 4:
					map[i].push_back(value)
					need[value] += 1
					break


func update():
	for i in range(bottle_count):
		bottles[i].number = i
		bottles[i].states = map[i]
		bottles[i].update()



func check_status(column, water):
	return len(column) < 4 and (len(column) == 0 or column[-1] == water)


func clear():
	for i in range(bottle_count):
		bottles[i].status = 0
		bottles[i].update()


func pour(column_from: Array, column_to:  Array):
	var count = 0
	if len(column_from) > 1:
		for i in range(len(column_from)-1, -1, -1):
			if column_from[i] == column_from[-1]:
				count += 1
			else:
				break
	else:
		count = 1
	while count > 0 and len(column_to) < 4:
		count -= 1
		column_to.push_back(column_from.pop_back())


func click(num):
	if win and step_count > 1:
		return
	if current == null:
		if len(map[num]) == 0:
			return
		current = num
		for i in range(bottle_count):
			if i != num:
				var water = map[current][-1]
				if check_status(map[i], water):
					bottles[i].status = 2
				else:
					bottles[i].status = 3
				bottles[i].update()
			else:
				bottles[i].status = 1
				bottles[i].update()
	else:
		if num == current:
			current = null
			clear()
			return
		var water = map[current][-1]
		if check_status(map[num], water):
			pour(map[current], map[num])
			current = null
			clear()
			update()
			step_count += 1
		check_win_condition()
		if win and step_count > 1:
			step_count = 0
			win = false
			generate_map()
			update()


func check_win_condition():
	win = true
	for i in range(bottle_count):
		if len(map[i]) != 0 and len(map[i]) != 4:
			win = false
