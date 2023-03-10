extends Node


var level_button_screne = preload("res://level_button.tscn")


func _ready():
	$ControlButtons.hide_buttons()
	for i in range(len(Global.maps)):
		var level_button = level_button_screne.instance()
		if i in Global.cleared_level:
			print(Global.cleared_level)
			level_button.set_level_cleared()
		level_button.level = i
		level_button.connect("start_level", self, "start")
		$ScrollContainer/VBoxContainer2.add_child(level_button)


func start(level):
	Global.current_level = level
	get_tree().change_scene("res://game.tscn")


func _on_ControlButtons_button_back_pressed():
	get_tree().change_scene("res://menu.tscn")
