extends Node


export (int, 5, 15) var bottle_count = 5
var map = []
var bottles = []
var current = null
var win = false
var step_count = 0
var moves = []
onready var pour_sounds = [$"Pour sounds/AudioStreamPlayer", $"Pour sounds/AudioStreamPlayer2", $"Pour sounds/AudioStreamPlayer3"]


onready var bottle_scene = preload("res://bottle.tscn")


func _ready():
	randomize()
	start()


func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


func start():
	# clear
	delete_children($Node)
	win = false
	bottles = []
	moves = []
	# start
	map = Global.maps[Global.current_level].duplicate(true)
	bottle_count = len(map)
	var viewpor = get_viewport().size / get_viewport().size.x * 360
	var start_y = (viewpor.y/2) - (144 + 6) + ((2 - ((bottle_count - 1) / 5)) * 75)
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
#	generate_map()
	update()
	$ControlTop.set_level(Global.current_level)


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
	var return_count = 0
	while count > 0 and len(column_to) < 4:
		count -= 1
		return_count += 1
		column_to.push_back(column_from.pop_back())
	var rand_pour_sound = pour_sounds[randi() % pour_sounds.size()]
	rand_pour_sound.stream.loop = false
	rand_pour_sound.play()
	return return_count

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
			moves.push_back([current, num, pour(map[current], map[num])])
			unselect()
			update()
			step_count += 1
		else:
			unselect()
			self.click(num)
			return
		check_win_condition()
		if win:
			$"Win sound".play()
			if Global.current_level < 25:
				if not Global.current_level in Global.cleared_level:
					Global.cleared_level.push_back(Global.current_level)
					Global.save_game()
				Global.current_level += 1
				if Global.current_level == 25:
					get_tree().change_scene("res://menu.tscn")
				else:
					start()


func is_all_same(col):
	var element = col[0]
	var result = true
	for i in range(len(col)):
		if col[i] != element:
			result = false
	return result
	

func check_win_condition():
	win = true
	for i in range(len(map)):
		if len(map[i]) != 0 and len(map[i]) != 4:
			win = false
		if len(map[i]) == 4 and not is_all_same(map[i]):
			win = false
	return win



func sleep(sec):
	yield(get_tree().create_timer(sec), "timeout")


func _on_ControlButtons_button_back_pressed():
	get_tree().change_scene("res://levels.tscn")


func _on_ControlButtons_button_restart_pressed():
	start()


func _on_ControlButtons_button_undo_pressed():
	unselect()
	var move = moves.pop_back()
	if move:
		var column_from = map[move[1]]
		var column_to = map[move[0]]
		var count = move[2]
		while count > 0:
			count -= 1
			column_to.push_back(column_from.pop_back())
		sleep(1)
		update()

