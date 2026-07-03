extends Node2D

@export var animation: AnimatedSprite2D
@export var collision_shape: CollisionShape2D


#creating the reference to the Node MugsContainer to be able to use the functions in its script
#but this variable is empty when we declare it here, we need to reference it in the script mugs_container as well
var mugs_container: MugsContainer
var _is_broken: bool
var _is_enchanted: bool
var _tween: Tween
var _start_position_x: float
var _start_position_y: float
var _is_stopped: bool = false


func _ready() -> void:
	animation.play("idle")
	_start_position_x = position.x
	_start_position_y = position.y
	_initiate_animation()


func enchant_mug() -> void:
	if _is_broken or _is_stopped:
		return
	_is_enchanted = true
	_update_visual()
	await get_tree().create_timer(4.0).timeout
	
	if not _is_broken and not _is_stopped:
		disenchant_mug()


func disenchant_mug() -> void:
	if _is_stopped:
		return
	_is_enchanted = false
	_update_visual()

func destroy_mug() -> void:
	if _is_broken:
		return
	_is_broken = true
	animation.play("broken")
	if _is_enchanted:
		mugs_container.is_mug_broken()
	else:
		mugs_container.is_wrong_mug_broken()
	await animation.animation_finished
	hide()
	collision_shape.disabled = true
	await get_tree().create_timer(3.0).timeout
	if _is_stopped:
		return
	_is_broken = false
	_is_enchanted = false
	animation.play("idle")
	_update_visual()
	collision_shape.disabled = false
	show()


func _initiate_animation():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.set_loops(0)
	_tween.tween_property(self, "position:y", _start_position_y -1, 0.5).set_trans(Tween.TRANS_BOUNCE)
	_tween.tween_property(self, "position:y", _start_position_y +1, 0.5)
	

func _update_visual() -> void:
	if _is_enchanted:
		if _tween:
			_tween.kill()
		_tween= create_tween()
		_tween.set_loops(0)
		_tween.tween_property(self, "position:x", _start_position_x - 4, 0.05)
		_tween.tween_property(self, "rotation_degrees", -6, 0.05)
		_tween.tween_property(self, "position:x", _start_position_x + 4, 0.05)
		_tween.tween_property(self, "rotation_degrees", 6, 0.05)
		_tween.tween_property(self, "position:x", _start_position_x - 3, 0.05)
		_tween.tween_property(self, "rotation_degrees", -4, 0.05)
		_tween.tween_property(self, "position:x", _start_position_x + 3, 0.05)
		_tween.tween_property(self, "rotation_degrees", 4, 0.05)
		_tween.tween_property(self, "position:x", _start_position_x, 0.05)
		_tween.tween_property(self, "rotation_degrees", 0, 0.05)
		animation.modulate = Color(1.5, 0.4, 2.0, 1.0)
	else:
		animation.modulate = Color(1, 1, 1) # normal
		_initiate_animation()

func stop_mug() -> void:
	_is_stopped = true
	if _tween:
		_tween.kill()
	animation.stop()
