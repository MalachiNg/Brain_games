extends Node

@onready var location_1
@onready var location_2
@onready var location_3
@onready var location_4
@onready var location_5
@onready var location_6
@onready var button_stage = 1
@onready var running_timer = false
@onready var game_running = false
@onready var dud_pressed = false
@onready var score = 0
@onready var master_timer_up = false


func _ready():
	$Back_Button.show()
	$Instructions.text = "CLICK THE BLUE BUTTONS!" 
	$Instructions.position = Vector2(70, 150) 
	$Instructions.show()
	$Start_Button.show()
	$Button.hide()
	$Dud_Button.hide()

func _process(_delta):
	if game_running and not master_timer_up:
		move_buttons()


func _on_start_button_pressed():
	$Start_Button.hide()
	$Instructions.hide()
	$Button.show()
	$Back_Button.hide()
	location_1 = Vector2(randf_range(0, 1033), randf_range(0, 528))
	location_2 = Vector2(randf_range(0, 1033), randf_range(0, 528))
	location_3 = Vector2(randf_range(0, 1033), randf_range(0, 528))
	location_4 = Vector2(randf_range(0, 1033), randf_range(0, 528))
	location_5 = Vector2(randf_range(0, 1033), randf_range(0, 528))
	location_6 = Vector2(randf_range(0, 1033), randf_range(0, 528))
	$Button.position = location_1
	game_running = true
	master_timer_up = false
	score = 0
	master_timer()


func move_buttons():
	if button_stage == 1:
		$Button.position = location_1
	elif button_stage == 2:
		$Button.position = location_2
	elif button_stage == 3:
		$Button.position = location_3
	elif button_stage == 4:
		$Button.position = location_4
	elif button_stage == 5:
		$Button.position = location_5
	elif button_stage == 6:
		$Button.position = location_6
	if not running_timer:
		var initial_button_stage = button_stage
		await get_tree().create_timer(1).timeout
		if initial_button_stage == button_stage:
			if button_stage == 6:
				button_stage = 1
			else:
				button_stage += 1 # change the button stage to the next position, as the user didn't click it in time.



func _on_button_pressed():
	score += 1
	if button_stage == 6:
		button_stage = 1
	else:
		button_stage += 1
	var rand = randi_range(1, 3)
	if rand == 2:
		$Dud_Button.show()
		$Dud_Button.position = Vector2(randf_range(0, 1033), randf_range(0, 528))
		print(str($Dud_Button.position))
		var initial_button_stage = button_stage
		while (initial_button_stage == button_stage) == true and dud_pressed == false:
			await get_tree().process_frame
		$Dud_Button.hide()
		dud_pressed = false
		



func _on_dud_button_pressed():
	dud_pressed = true
	if button_stage == 6:
		button_stage = 1
	else:
		button_stage += 1 # move the real button.

func master_timer():
	await get_tree().create_timer(30).timeout
	master_timer_up = true
	get_tree().paused = true
	game_over()


func game_over():
	button_stage = 1
	$Button.hide()
	$Start_Button.show()
	$Instructions.show()
	$Dud_Button.hide()
	if score == 0:
		$Instructions.text = "HOW did you NEVER hit it...\n          you're trash."
		$Instructions.position.y = 0
	if score == 1:
		$Instructions.text = "     You hit the blue once.\n            you're trash."
		$Instructions.position.y = 0
	if score != 1 and score != 0:
		$Instructions.text = "You hit the blue " + str(score) + " times!"
	get_tree().paused = false



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
