extends Area2D


export(Array, int, 0, 2, 1) var states = [0, 0, 0, 0]
export(int, 0, 3) var status

onready var slots = [$Sprites/Slot1, $Sprites/Slot2, $Sprites/Slot3, $Sprites/Slot4]
onready var status_sprite = $Sprites/Status
onready var sprites = $Sprites
onready var status_ok = load("res://sprites/ok.png")
onready var status_wrong = load("res://sprites/wrong.png")

func _ready():
	self.update()
	
func update():
	for i in range(4):
		slots[i].modulate = Color(0, 0, 0, 0)
	for i in range(len(states)):
		match states[i]:
			0:
				slots[i].modulate = Color("#bf616a")
			1:
				slots[i].modulate = Color("#5e81ac")
			2:
				slots[i].modulate = Color("#ebcb8b")
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
