extends Node


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused #so if its not paused, it pauses it and if it is paused it does the opposite
