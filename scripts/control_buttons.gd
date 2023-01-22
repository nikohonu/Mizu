extends Control

signal button_restart_pressed
signal button_undo_pressed
signal button_back_pressed


func hide_buttons():
	$MarginContainer/HBoxContainer/ButtonRestart.texture_normal = null
	$MarginContainer/HBoxContainer/ButtonUndo.texture_normal = null


func _on_ButtonRestart_pressed():
	emit_signal("button_restart_pressed")


func _on_ButtonUndo_pressed():
	emit_signal("button_undo_pressed")


func _on_ButtonBack_pressed():
	emit_signal("button_back_pressed")
