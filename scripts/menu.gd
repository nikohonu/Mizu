extends Node


func _on_TextureButton_pressed():
	get_tree().change_scene("res://levels.tscn")


func _on_TextureButtonQuit_pressed():
	get_tree().quit()
