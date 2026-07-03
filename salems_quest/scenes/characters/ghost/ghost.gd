extends CharacterBody2D

#variable to be able to work with the animated sprite,
#this will appear on the right panel under "player.gd" when node Player is selected
#we will then change it to Animation: AnimatedSprite2D
@export var animation_ghost: AnimatedSprite2D
@export var damage_area: Area2D


var _can_damage: bool = true
var _base_speed: float = 60.0
var _speed_increment: float = 15.0
var _direction: Vector2 = Vector2(1, 1).normalized()
var _stopped: bool = false

func _ready():
	animation_ghost.play("idle")
	damage_area.body_entered.connect(_on_body_entered)
	GlobalController.signal_win_game.connect(_stop_ghost)


func _physics_process(delta: float) -> void:
	if _stopped:
		return
	var current_speed := _base_speed + (GlobalController.lives * _speed_increment)
	position += _direction * current_speed * delta
	if position.x > 200 or position.x < -200:
		_direction.x *= -1
	if position.y > 105 or position.y < -105:
		_direction.y *= -1


func _on_body_entered(_body: Node2D) -> void:
	if not _can_damage:
		return
	
	_can_damage = false
	animation_ghost.modulate = Color.PURPLE
	var _tween= create_tween()
	_tween.set_loops(0)
	_tween.tween_property(self, "position:x", position.x - 4, 0.05)
	_tween.tween_property(self, "rotation_degrees", -6, 0.05)
	_tween.tween_property(self, "position:x", position.x + 4, 0.05)
	_tween.tween_property(self, "rotation_degrees", 6, 0.05)
	_tween.tween_property(self, "position:x", position.x - 3, 0.05)
	_tween.tween_property(self, "rotation_degrees", -4, 0.05)
	_tween.tween_property(self, "position:x", position.x + 3, 0.05)
	_tween.tween_property(self, "rotation_degrees", 4, 0.05)
	_tween.tween_property(self, "position:x", position.x, 0.05)
	_tween.tween_property(self, "rotation_degrees", 0, 0.05)
	GlobalController.lost_life()
	await get_tree().create_timer(1.0).timeout
	animation_ghost.modulate = Color(1, 1, 1) # normal
	_tween.kill()
	_can_damage = true


func _stop_ghost():
	_stopped = true
	animation_ghost.stop()
