extends Node2D


@export var area_2D: Area2D


func _ready() -> void:
	area_2D.body_entered.connect(take_damage)

func take_damage(_body) -> void:
		print("Mug broken")
		queue_free()
