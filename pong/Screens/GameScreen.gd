extends Control

var _start_screen : PackedScene = load("res://Screens/StartScreen.tscn")

var _ball_scene : PackedScene = load("res://Ball/Ball.tscn")

var _current_ball : Ball

var _player_1_score : int = 0
var _player_2_score : int = 0

@onready var _player_1_score_text : RichTextLabel = $Player1Score/RichTextLabel
@onready var _player_2_score_text : RichTextLabel = $Player2Score/RichTextLabel

@onready var _counter_text : RichTextLabel = $Counter/RichTextLabel

func _ready() -> void:
	add_ball(Vector2(get_random_axis_direction(), get_random_axis_direction()))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_packed(_start_screen)

func add_ball(direction : Vector2) -> void:
	_current_ball = _ball_scene.instantiate()
	_current_ball.global_position = get_viewport_rect().size / 2
	add_child(_current_ball)
	
	_counter_text.text = "3"
	await get_tree().create_timer(1).timeout
	_counter_text.text = "2"
	await get_tree().create_timer(1).timeout
	_counter_text.text = "1"
	await get_tree().create_timer(1).timeout
	_counter_text.text = ""
	
	_current_ball.direction = direction

func _on_player_1_area_body_entered(body: Node2D) -> void: ## Player 2 scored
	if body is Ball:
		body.kill()
		add_ball.call_deferred(Vector2(1, get_random_axis_direction()))
		
		_player_2_score += 1
		_player_2_score_text.text = str(_player_2_score)

func _on_player_2_area_body_entered(body: Node2D) -> void: ## Player 1 scored
	if body is Ball:
		body.kill()
		add_ball.call_deferred(Vector2(-1, get_random_axis_direction()))
		
		_player_1_score += 1
		_player_1_score_text.text = str(_player_1_score)

static func get_random_axis_direction() -> int:
	var rng := RandomNumberGenerator.new()
	return 1 if rng.randi_range(0, 1) == 0 else -1
