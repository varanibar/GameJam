extends Node2D

@export var animation: AnimatedSprite2D

#creating the reference to the Node MugsContainer to be able to use the functions in its script
#but this variable is empty when we declare it here, we need to reference it in the script mugs_container as well
var mugs_container: MugsContainer
var _is_broken: bool

func _ready() -> void:
	animation.play("idle")
	_initiate_animation()
	
func destroy_mug() -> void:
	if _is_broken:
		return
	_is_broken = true
	print("Mug broken")
	animation.play("broken")
	mugs_container.is_mug_broken()
	await animation.animation_finished
	queue_free()


func _initiate_animation():
	var tween: Tween = create_tween()
	tween.set_loops(0)
	tween.tween_property(self, "position:y", position.y -1, 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "position:y", position.y +1, 0.5)
	
	
