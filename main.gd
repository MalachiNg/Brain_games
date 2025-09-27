extends Node

func _ready():
	$Introduction.show()
	$Introduction.text = "               Welcome to BRAIN GAMES!\n    Select the minigame you want to play!"

func _on_math_game_button_pressed():
	get_tree().change_scene_to_file("res://math_memory_game.tscn")



func _on_button_game_button_pressed():
	get_tree().change_scene_to_file("res://button_clicking_game.tscn")
