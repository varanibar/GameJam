extends CharacterBody2D

#variable to be able to work with the animated sprite,
#this will appear on the right panel under "player.gd" when node Player is selected
#we will then change it to Animation: AnimatedSprite2D
@export var animation_ghost: AnimatedSprite2D
@export var damage_area: Area2D


var _can_damage: bool = true
var _speed: float = 80.0
var _direction: Vector2 = Vector2(1, 1).normalized()

func _ready():
	animation_ghost.play("idle")
	damage_area.body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position +=


func _on_body_entered(body: Node2D) -> void:
	if not _can_damage:
		return
	
	_can_damage = false
	GlobalController.lost_life()
	await get_tree().create_timer(1.0).timeout
	_can_damage = true
