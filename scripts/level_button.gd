extends TextureButton

var level

signal start_level(level)

func _ready():
	$Label.text = "Level " + str(level+1)


func _on_TextureButtonQuit_pressed():
	emit_signal("start_level", level)
