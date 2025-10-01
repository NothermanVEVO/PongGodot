extends Control

var _game_screen := load("res://Screens/GameScreen.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(_game_screen)

func _on_quit_pressed() -> void:
	get_tree().quit()
