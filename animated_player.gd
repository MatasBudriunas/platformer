extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0

var score : int = 0
var time_passed : float = 0.0
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")
@onready var time_text : Label = get_node("CanvasLayer/TimeText")
@onready var game_timer : Timer = get_node("GameTimer")

@export var run_animation : String
@export var idle_animation : String
@onready var player_sprite : AnimatedSprite2D = get_node("AnimatedSprite")

func _ready():
	if player_sprite:
		if idle_animation != "":
			player_sprite.play(idle_animation)
	else:
		print("Error: AnimatedSprite node not found!")
	start_game()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = 0
	
	var is_moving = false
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
		is_moving = true
		
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
		is_moving = true
		
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jump_force
		
	move_and_slide()

	if player_sprite:
		if is_moving and player_sprite.animation != run_animation:
			player_sprite.play(run_animation)
		elif not is_moving and player_sprite.animation != idle_animation:
			player_sprite.play(idle_animation)

	if global_position.y > 100:
		game_over()
	
	time_passed += delta
	time_text.text = "Time: %.3f" % time_passed

func game_over():
	get_tree().reload_current_scene()

func add_score(amount):
	score += amount
	score_text.text = str("Score: ", score)

func start_game():
	time_passed = 0.0
	time_text.text = "Elapsed Time: %.3f" % time_passed
	game_timer.start()
