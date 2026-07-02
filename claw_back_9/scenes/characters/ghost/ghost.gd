extends CharacterBody2D

#variable to be able to work with the animated sprite,
#this will appear on the right panel under "player.gd" when node Player is selected
#we will then change it to Animation: AnimatedSprite2D
@export var animation_ghost: AnimatedSprite2D

func _ready():
	animation_ghost.play("idle")
