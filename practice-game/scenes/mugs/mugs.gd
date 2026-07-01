extends Node2D


@export var animation: AnimatedSprite2D


var _is_broken: bool = false


func _ready() -> void:
	animation.play("idle")

	
func destroy_mug() -> void:
	if _is_broken:
		return
	_is_broken = true
	print("Mug broken")
	animation.play("broken")
	await animation.animation_finished
	queue_free()
