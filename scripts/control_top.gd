extends Control


func _ready():
	pass # Replace with function body.


func set_level(level):
	$MarginContainer2/Label.text = "Level " + str(level + 1)
	
