extends CharacterBody2D

@export_enum("Player 1", "Player 2") var choice : String = "Escolhe"

var direction : int = 0

const SPEED : float = 500

func _physics_process(delta: float) -> void:
	if choice == "Player 1":
		direction = Input.get_axis("Mover Cima 1", "Mover Baixo 1")
	elif choice == "Player 2":
		direction = Input.get_axis("Mover Cima 2", "Mover Baixo 2")
	
	if direction:
		velocity.y = direction * SPEED
		move_and_slide()
