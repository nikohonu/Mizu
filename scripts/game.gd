extends Node2D


export (Array, Array, int, 0, 3) var map = [[], [], [], [], []]
onready var bottles = [$Bottle1, $Bottle2, $Bottle3, $Bottle4, $Bottle5]
var current = null
var step_count = 0
var win = false

func _ready():
	generate_map()
	update()

func generate_map():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var need = [0, 0, 0]
	for i in range(3):
		for j in range(4):
			while true:
				var value = rng.randi_range(0, 2)
				if need[value] < 4:
					map[i].push_back(value)
					need[value] += 1
					break


func update():
	for i in range(5):
		bottles[i].states = map[i]
		bottles[i].update()
		

func _on_Bottle1_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		self.click(0)


func _on_Bottle2_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		self.click(1)


func _on_Bottle3_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		self.click(2)


func _on_Bottle4_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		self.click(3)


func _on_Bottle5_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		self.click(4)


func check_status(column, water):
	return len(column) < 4 and (len(column) == 0 or column[-1] == water)
	
	
func clear():
	for i in range(5):
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
		$Label.text = "Count of steps: " + str(step_count) + ". You win!"
		return
	if current == null:
		if len(map[num]) == 0:
			return
		current = num
		for i in range(5):
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
			$Label.text = "Count of steps: " + str(step_count)
		check_win_condition()
		if win and step_count > 1:
			$Label.text = "Count of steps: " + str(step_count) + ". You win!"
			step_count = 0
			win = false
			map = [[], [], [], [], []]
			generate_map()
			update()


func check_win_condition():
	win = true
	for i in range(5):
		if len(map[i]) != 0 and len(map[i]) != 4:
			win = false
