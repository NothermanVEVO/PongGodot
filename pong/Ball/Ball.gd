extends CharacterBody2D

class_name Ball

var _moving_particle_scene : PackedScene = load("res://Ball/MovingParticles.tscn")
var _explosing_particles_scene : PackedScene = load("res://Ball/ExplosingParticles.tscn")

const SPEED : float = 500
var direction : Vector2

func _physics_process(delta: float) -> void:
	velocity = direction * SPEED * delta
	var collision_info = move_and_collide(velocity)
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())

func kill() -> void:
	var explosing_particles : CPUParticles2D = _explosing_particles_scene.instantiate()
	explosing_particles.emitting = true
	explosing_particles.global_position = global_position
	get_parent().add_child(explosing_particles)
	queue_free()

func _on_timer_timeout() -> void:
	var moving_particle : CPUParticles2D = _moving_particle_scene.instantiate()
	add_child(moving_particle)
	moving_particle.finished.connect(moving_particle.queue_free)
	moving_particle.emitting = true
