extends Node

@onready var num_1 : int
@onready var num_2 : int
@onready var num_3 : int
@onready var input_given = false
@onready var user_input_loaded = false
@onready var numbers_in_use
@onready var operator
@onready var answer
@onready var master_timer_up = false
@onready var score = 0

func _ready():
	$Instructions.text = "REMEMBER THE NUMBERS!" 
	$Instructions.position = Vector2(90, 150) 
	$Number_1.hide()
	$Number_2.hide()
	$Number_3.hide()
	$User_input.hide()
	$Button_STA.show()

func _process(_delta):
	if user_input_loaded:
		receive_input()

func button_STA_pressed():
	master_timer()
	reveal_numbers()
	$Instructions.hide()
	$Button_STA.hide()

func reveal_numbers():
	$User_input.hide()
	$Instructions.hide()
	num_1 = randi_range(-10, 10)
	num_2 = randi_range(-10, 10)
	num_3 = randi_range(-10, 10)
	$Number_1.text = str(num_1)
	$Number_2.text = str(num_2)
	$Number_3.text = str(num_3)
	$Number_1.position = Vector2(0, 200)
	$Number_2.position = Vector2(400, 200)
	$Number_3.position = Vector2(800, 200)
	$Number_1.show()
	$Number_2.show()
	$Number_3.show()
	await get_tree().create_timer(2).timeout
	$Number_1.hide()
	$Number_2.hide()
	$Number_3.hide()
	if not master_timer_up:
		ready_user_input()

func receive_input():
	if Input.is_action_just_pressed("button_0"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "0"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "0"
	if Input.is_action_just_pressed("button_1"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "1"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "1"
	if Input.is_action_just_pressed("button_2"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "2"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "2"
	if Input.is_action_just_pressed("button_3"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "3"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "3"
	if Input.is_action_just_pressed("button_4"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "4"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "4"
	if Input.is_action_just_pressed("button_5"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "5"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "5"
	if Input.is_action_just_pressed("button_6"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "6"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "6"
	if Input.is_action_just_pressed("button_7"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "7"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "7"
	if Input.is_action_just_pressed("button_8"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "8"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "8"
	if Input.is_action_just_pressed("button_9"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "9"
			input_given = true
			$User_input.position.x += 200
		else:
			$User_input.text = $User_input.text + "9"
	if Input.is_action_just_pressed("button_delete"):
		$User_input.text = str(roundi(float(int($User_input.text) / 10)))
		if $User_input.text == "0" and input_given:
			$User_input.text = "Type the answer..."
			input_given = false
			$User_input.position.x -= 200
	if Input.is_action_just_pressed("button_enter"):
		calculate_answer()
		print(str(answer))
		if int($User_input.text) == answer:
			$User_input.text = "Correct!"
			score += 1
			user_input_loaded = false
			input_given = false
			$User_input.position.x -= 100
			await get_tree().create_timer(0.5).timeout
			$User_input.position.x -= 100
			if not master_timer_up:
				reveal_numbers()
		else:
			$User_input.text = "WRONG YOU SUCK TRY AGAIN!"
			user_input_loaded = false
			input_given = false
			$User_input.position.x -= 300
			await get_tree().create_timer(0.5).timeout
			$User_input.position.x += 100
			if not master_timer_up:
				reveal_numbers()
	if Input.is_action_just_pressed("button_minus"):
		if not input_given or $User_input.text == "0":
			$User_input.text = "-"
			input_given = true
			$User_input.position.x += 200

func ready_user_input():
	$User_input.show()
	$Instructions.show()
	$Instructions.scale = Vector2(4, 4)
	$Instructions.position = Vector2(200, 25)
	$Instructions.text = "What is"
	numbers_in_use = randi_range(1, 7)
	if numbers_in_use == 1:
		$Instructions.text = $Instructions.text + " the 1st and 2nd number"
	if numbers_in_use == 2:
		$Instructions.text = $Instructions.text + " the 2nd and 3rd number"
	if numbers_in_use == 3:
		$Instructions.text = $Instructions.text + " the 1st and 3rd number"
	if numbers_in_use == 4:
		$Instructions.text = $Instructions.text + " all 3 numbers"
		operator = randi_range(1, 2)
		if operator == 1:
			$Instructions.text = $Instructions.text + "\n         multiplied?"
		if operator == 2:
			$Instructions.text = $Instructions.text + "\n     added together?"
		user_input_loaded = true
		$User_input.text = "Type the answer..."
		$User_input.show()
		return
	if numbers_in_use == 5:
		$Instructions.text = $Instructions.text + " the 1st number"
		operator = randi_range(1, 2)
		if sqrt(int($Number_1.text)) == int(sqrt(int($Number_1.text))) and operator == 1:
			$Instructions.text = $Instructions.text + "\n    square rooted?"
		else:
			$Instructions.text = $Instructions.text + "\n             squared?"
			operator = 2
		user_input_loaded = true
		$User_input.text = "Type the answer..."
		$User_input.show()
		return
	if numbers_in_use == 6:
		$Instructions.text = $Instructions.text + " the 2nd number"
		operator = randi_range(1, 2)
		if sqrt(int($Number_2.text)) == int(sqrt(int($Number_2.text))) and operator == 1:
			$Instructions.text = $Instructions.text + "\n    square rooted?"
		else:
			$Instructions.text = $Instructions.text + "\n             squared?"
			operator = 2
		user_input_loaded = true
		$User_input.text = "Type the answer..."
		$User_input.show()
		return
	if numbers_in_use == 7:
		$Instructions.text = $Instructions.text + " the 3rd number"
		operator = randi_range(1, 2)
		if sqrt(int($Number_3.text)) == int(sqrt(int($Number_3.text))) and operator == 1:
			$Instructions.text = $Instructions.text + "\n    square rooted?"
		else:
			$Instructions.text = $Instructions.text + "\n             squared?"
			operator = 2
		user_input_loaded = true
		$User_input.text = "Type the answer..."
		$User_input.show()
		return
	operator = randi_range(1, 4)
	if operator == 1:
		$Instructions.text = $Instructions.text + "\n     multiplied together?"
	if operator == 2:
		$Instructions.text = $Instructions.text + "\n         added together?"
	if operator == 3:
		$Instructions.text = $Instructions.text + "\n subtracted? (former by latter)"
	if operator == 4:
		if numbers_in_use == 1 and (num_1 / num_2) == int(num_1 / num_2): # if the answer is a whole number:
			$Instructions.text = $Instructions.text + "\n   divided? (former by latter) \n     round to higher number"
		elif numbers_in_use == 2 and (num_2 / num_3) == int(num_2 / num_3):
			$Instructions.text = $Instructions.text + "\n   divided? (former by latter) \n     round to higher number"
		elif numbers_in_use == 3 and (num_1 / num_3) == int(num_1 / num_3):
			$Instructions.text = $Instructions.text + "\n   divided? (former by latter) \n     round to higher number"
		else: # if the answer isn't a whole number:
			operator = 1 # change to multiplication (doesn't matter which but multiplication is operator 1) 
			$Instructions.text = $Instructions.text + "\n     multiplied together?"
	user_input_loaded = true
	$User_input.text = "Type the answer..."
	$User_input.show()

func calculate_answer():
	if numbers_in_use == 1: # 1st and 2nd number
		if operator == 1: # multiplied
			answer = (num_1 * num_2)
		elif operator == 2: # added together
			answer = (num_1 + num_2)
		elif operator == 3: # subtracted
			answer = (num_1 - num_2)
		elif operator == 4: # divided
			answer = (num_1 / num_2)
	elif numbers_in_use == 2: #2nd and 3rd number
		if operator == 1: # multiplied
			answer = (num_2 * num_3)
		elif operator == 2: # added together
			answer = (num_2 + num_3)
		elif operator == 3: # subtracted
			answer = (num_2 - num_3)
		elif operator == 4: # divided
			answer = (num_2 / num_3)
	elif numbers_in_use == 3: #1st and 3rd number
		if operator == 1: # multiplied
			answer = (num_1 * num_3)
		elif operator == 2: # added together
			answer = (num_1 + num_3)
		elif operator == 3: # subtracted
			answer = (num_1 - num_3)
		elif operator == 4: # divided
			answer = (num_1 / num_3)
	elif numbers_in_use == 4:
		if operator == 1:
			answer = (num_1*num_2*num_3)
		elif operator == 2:
			answer = (num_1+num_2+num_3)
	elif numbers_in_use == 5: # just the 1st number
		if operator == 1:
			answer = sqrt(num_1)
		else:
			answer = pow(num_1, 2)
	elif numbers_in_use == 6: # just the 2nd number
		if operator == 1:
			answer = sqrt(num_2)
		else:
			answer = pow(num_2, 2)
	elif numbers_in_use == 7: # just the 3rd number
		if operator == 1:
			answer = sqrt(num_3)
		else:
			answer = pow(num_3, 2)


func master_timer():
	await get_tree().create_timer(90).timeout
	master_timer_up = true
	get_tree().paused = true
	game_over()

func game_over():
	$Instructions.show()
	if score == 0:
		$Instructions.text = "   You successfully managed\nto get no questions right.\n     you failure"
	if score == 1:
		$Instructions.text = "   You correctly answered\n1 question. You seriously suck."
	if score <= 4 and score != 1:
		$Instructions.text = "You correctly answered\n         " + str(score) + " questions.\nYou're kinda trash gang..."
	elif score > 10:
		$Instructions.text = "You correctly answered\n         " + str(score) + " questions! \n         Nice one!"
	elif score >= 15:
		$Instructions.text = "You correctly answered\n         " + str(score) + " questions...\nYou have got to be cheating somehow...!"
	else:
		$Instructions.text = "You correctly answered\n         " + str(score) + " questions."
	$User_input.hide()
	$Number_1.hide()
	$Number_2.hide()
	$Number_3.hide()
	$Button_STA.show()
