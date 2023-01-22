extends TextureButton

var level
onready var label = $Label
onready var font = preload("res://fonts/cleared_level.tres")
signal start_level(level)


func set_level_cleared():
	$Label.add_color_override("font_color", Color("#fbbe82"))


func _ready():
	$Label.text = "Level " + str(level+1)


func _on_TextureButtonQuit_pressed():
	emit_signal("start_level", level)
