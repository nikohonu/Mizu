extends Node


export (int, 5, 15) var bottle_count = 5
var map = []
var bottles = []
var current = null
var win = false
var step_count = 0
var moves = []



func _ready():
	var bottle_scene = preload("res://bottle.tscn")
	map = Global.maps[Global.current_level].duplicate(true)
	bottle_count = len(map)
	var start_y = (get_viewport().size.y/2) - (144 + 6) + ((2 - ((bottle_count - 1) / 5)) * 75)
	for i in range(bottle_count):
		var bottle = bottle_scene.instance()
		var x = i % 5
		var y = i / 5
		var current_min_x = min(bottle_count - (5 * y), 5)
		bottle.position.y = start_y + ((6 + 144) * y)
		bottle.position.x = (40+(5-current_min_x)*35) + ((10 + 60) * x)
		bottle.connect("pressed", self, "click")
		$Node.add_child(bottle)
		bottles.append(bottle)
	generate_map()
	update()
	$ControlTop.set_level(Global.current_level)
	print(map)


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
		for _j in range(4):
			while true:
				var value = rng.randi_range(0, color_count - 1) # (0, 1, 2) = 3
				if need[value] < 4:
					map[i].push_back(value)
					need[value] += 1
					break
	map = Global.maps[Global.current_level].duplicate(true)
#	map = [[3, 5, 9, 12], [1, 2, 7, 2], [9, 10, 7, 9], [3, 8, 0, 11], [5, 10, 5, 4], [12, 7, 6, 12], [9, 2, 12, 3], [2, 11, 10, 11], [7, 0, 0, 10], [3, 8, 8, 4], [6, 4, 8, 4], [6, 6, 5, 1], [0, 1, 1, 11], [], []]

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

func unselect():
	current = null
	clear()

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
			unselect()
			return
		var water = map[current][-1]
		if check_status(map[num], water):
			pour(map[current], map[num])
			moves.push_back([current, num])
			unselect()
			update()
			step_count += 1
		else:
			unselect()
			self.click(num)
			return
		check_win_condition()
		if win and step_count > 1:
			step_count = 0
			win = false
			generate_map()
			update()
	print(moves)


func check_win_condition():
	win = true
	for i in range(bottle_count):
		if len(map[i]) != 0 and len(map[i]) != 4:
			win = false


func sleep(sec):
	yield(get_tree().create_timer(sec), "timeout")
	

func _on_ControlButtons_button_back_pressed():
	get_tree().change_scene("res://levels.tscn")


func _on_ControlButtons_button_restart_pressed():
	generate_map()
	update()


func _on_ControlButtons_button_undo_pressed():
	unselect()
	var move = moves.pop_back()
	if move:
		pour(map[move[1]], map[move[0]])
		sleep(1)
		print(map)
		update()
