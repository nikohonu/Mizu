extends Control


func set_level(level):
	$MarginContainer2/Label.text = "Level " + str(level + 1)
