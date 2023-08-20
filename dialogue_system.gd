extends CharacterBody2D

var speed = 300
var dialogue_box: Label
var close_button: Button
var dialogue_lines: Array = ["Hello, adventurer!", "Welcome to our village."]

var current_line: int = 0
var line_timer: float = 0

func _ready():
	dialogue_box = Label.new()
	dialogue_box.visible = false
	add_child(dialogue_box)
	
	close_button = Button.new()
	close_button.text = "Close"
	close_button.position = Vector2(50, 30)
	close_button.visible = false
	close_button.pressed.connect(_on_close_button_pressed)
	add_child(close_button)

func _physics_process(delta):
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1
	

	velocity = input_dir.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	if Input.is_action_pressed("ui_right"):
		if collision:
			print("collided")
			dialogue_box.visible = true
			close_button.visible = true
		else:
			dialogue_box.visible = false
	if line_timer > 0:
		line_timer -= delta
	elif current_line < dialogue_lines.size():
		show_next_dialogue_line()

func show_next_dialogue_line():
	dialogue_box.text = dialogue_lines[current_line]
	current_line += 1
	line_timer = 3.0  # Display each line for 3 seconds
	

func _on_close_button_pressed():
	dialogue_box.visible = false
	close_button.visible = false
	current_line = 0
