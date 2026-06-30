extends CharacterBody2D

#variable to be able to work with the animated sprite,
#this will appear on the right panel under "player.gd" when node Player is selected
#we will then change it to Animation: AnimatedSprite2D
@export var animation: AnimatedSprite2D

var _speed: float = 100.0
var _speed_jump: float = -400.0

func _physics_process(delta):
	#gravity
	velocity += get_gravity() * delta
	
	#jump
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("up")) and is_on_floor():
		velocity.y = _speed_jump
	#side movement
	if Input.is_action_pressed("right"):
		velocity.x = _speed
		animation.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -_speed
		animation.flip_h = true
	else:
		velocity.x = 0
	move_and_slide()

	#animation
	if !is_on_floor():
		animation.play("jump")
	elif velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
