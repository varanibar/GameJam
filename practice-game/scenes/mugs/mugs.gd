extends Node2D

func take_damage() -> void:
		print("Mug broken")
		queue_free()
