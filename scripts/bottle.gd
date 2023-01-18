extends Area2D


export(Array, int, 0, 2, 1) var states = []
export(int, 0, 3) var status
onready var slots = [$Sprites/Slot1, $Sprites/Slot2, $Sprites/Slot3, $Sprites/Slot4]
onready var status_sprite = $Status
onready var sprites = $Sprites
onready var status_ok = load("res://sprites/ok.png")
onready var status_wrong = load("res://sprites/wrong.png")
onready var colors = [
	Color("#2e3440"),
	Color("#3b4252"),
	Color("#4c566a"),
	Color("#d8dee9"),
	Color("#8fbcbb"),
	Color("#88c0d0"),
	Color("#81a1c1"),
	Color("#5e81ac"),
	Color("#bf616a"),
	Color("#d08770"),
	Color("#ebcb8b"),
	Color("#a3be8c"),
	Color("#b48ead"),
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
			status_sprite.texture = status_wrong


func _on_Bottle_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("pressed", number)
