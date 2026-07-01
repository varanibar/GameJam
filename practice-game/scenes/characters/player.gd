extends CharacterBody2D


signal dead_player


#variable to be able to work with the animated sprite,
#While selecting the Player node, in the inspector panel under "player.gd", change:
#Animation: AnimatedSprite2D
@export var animation: AnimatedSprite2D

#this will add the area to the player
#While selecting the Player node, in the inspector panel under "player.gd", change:
#Area 2D: Areat2D
@export var area_2d: Area2D

var _speed: float = 100.0
var _speed_jump: float = -400.0
var _dead: bool


#we add this after disconnecting the area to the player, bc we wanna code so it is easier to keep track
#this cnnects the area to the player, it will call whatever we have in the function _on_area_2d_body_entered
func _ready():
	#this allows the main scene find this node, it filters it out.
	add_to_group("characters")
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	

func _physics_process(delta):
	if _dead:
		return
		
		
	#gravity
	velocity += get_gravity() * delta
	
	#jump
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("up")) and is_on_floor():
		velocity.y = _speed_jump
	#side movement
	if Input.is_action_pressed("right"):
		velocity.x = _speed
		animation.flip_h = true 
	elif Input.is_action_pressed("left"):
		velocity.x = -_speed
		animation.flip_h = false
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

#we keep it after disconnecting the area bc we will use it but using the _ready function
func _on_area_2d_body_entered(_body: Node2D) -> void:
	#animation.modulate = Color(18.892, 0.0, 0.0, 1.0)
	animation.modulate = Color.DARK_RED
	print("DEAD")
	animation.flip_v = true
	_dead = true
	
	await get_tree().create_timer(1).timeout
	dead_player.emit()
	#animation.stop()
