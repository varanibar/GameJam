extends CharacterBody2D


signal dead_player

@export var animation: AnimatedSprite2D #While selecting the Player node, in the inspector panel under "player.gd", change: Animation: AnimatedSprite2D
@export var area_2D: Area2D #While selecting the Player node, in the inspector panel under "player.gd", change: Area 2D: Areat2D
@export var hitbox: Area2D


var _speed: float = 100.0
var _speed_jump: float = -400.0
var _dead: bool = false
var _is_right: bool = true
var _is_attacking: bool = false


func _ready():
	add_to_group("characters") #add_to_group allows the main scene find this node, it filters it out.
	area_2D.body_entered.connect(_on_area_2d_body_entered) #this cnnects the area to the player, it will call whatever we have in the function _on_area_2d_body_entered
	hitbox.area_entered.connect(_on_hitbox_area_entered) #when the hitbox touches another area2D, call this function
	hitbox.monitoring = false #hitbox detection ability is off


func _physics_process(delta):
	if _dead:
		return

	#gravity
	velocity += get_gravity() * delta

	#jump
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("up")) and is_on_floor():
		velocity.y = _speed_jump

	#attack
	if (Input.is_action_just_pressed("attack")):
		#animation.play("attack")
		_attack()

	#side movement
	if Input.is_action_pressed("right"):
		velocity.x = _speed
		animation.flip_h = false
		if _is_right == false:
			hitbox.move_local_x(40, true)
			_is_right = true
	elif Input.is_action_pressed("left"):
		velocity.x = -_speed
		animation.flip_h = true
		if _is_right == true:
			_is_right = false
			hitbox.move_local_x(-40, true)
	else:
		velocity.x = 0
	move_and_slide()

	#animation
	if _is_attacking:
		return
	if !is_on_floor():
		animation.play("jump")
	elif velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")


func _attack() -> void:
	print("attack")
	if _is_attacking:
		return
	_is_attacking = true
	animation.play("attack")
	
	hitbox.monitoring = true
	await get_tree().create_timer(0.2).timeout
	hitbox.monitoring = false
	_is_attacking = false

#when hitbox touches the mug's area2D:
func _on_hitbox_area_entered(area: Area2D) -> void:
	var mug = area.get_parent() #the take_damage function is in the parent node (mugs) and not in the child node (area2d), thats why we get the parent of the area node
	if mug.has_method("take_damage"):
		mug.take_damage()

#when kitty touches a spike it dies:
func _on_area_2d_body_entered(_body: Node2D) -> void:
	animation.modulate = Color.DARK_RED
	print("DEAD")
	animation.flip_v = true
	_dead = true
	await get_tree().create_timer(1).timeout
	dead_player.emit()
	#animation.stop()
