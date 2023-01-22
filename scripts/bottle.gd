extends Area2D


export(Array, int, 0, 2, 1) var states = []
export(int, 0, 3) var status
onready var slots = [$Sprites/Slot1, $Sprites/Slot2, $Sprites/Slot3, $Sprites/Slot4]
onready var status_sprite = $Status
onready var sprites = $Sprites
onready var status_ok = load("res://sprites/ok.png")
onready var status_wrong = load("res://sprites/wrong.png")
onready var colors = [
	Color("#da2424"),
	Color("#1831a7"),
	Color("#ef6e10"),
	Color("#ffffff"),
	Color("#08b23b"),
	Color("#c12458"),
	Color("#f94e6d"),
	Color("#ece910"),
	Color("#5ee9e9"),
	Color("#ecab11"),
	Color("#841252"),
	Color("#2890dc"),
	Color("#8a4926"),
	Color("#c5cddb"),
	Color("#f78d8d"),
]
var number = null


signal pressed(number)


func _ready():
	self.update()


func update():
	for i in range(4):
		slots[i].modulate = Color(0, 0, 0, 0)
	for i in range(len(states)):
		slots[i].modulate = colors[states[i]]
	match status:
		0: # normal
			status_sprite.texture = null
			sprites.position.y = 0
		1: # selected
			sprites.position.y = -20
		2: # ok
			sprites.position.y = 0
			status_sprite.texture = status_ok
		3: # wrong
			sprites.position.y = 0


func _on_Bottle_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("pressed", number)
