extends Node2D


#We will create an array of levels that holds all the levels as scenes
@export var levels: Array[PackedScene]

var _level_current: int = 1
var _level_instance: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalController.signal_game_over.connect(_restart_level)
	GlobalController.signal_win_game.connect(_win_game)
	_create_level(_level_current)


#the level needs to be instantiated and afterwards it has to be
#added to the Scene Tree, wee need to add level_1 as a child of 
#Main scene, for this we use the function add child 
func _create_level(level_number: int):
	_level_instance = levels[level_number - 1].instantiate()
	add_child(_level_instance)
	#Array of the children nodes of the instantiated level(kitty, ghost, player, etc)
	#var children := _level_instance.get_children() #filtering out the children that belong to the group "characters"
	#for i in children.size():
		#if children[i].is_in_group("characters") and children[i].name == "Kitty":
			#children[i].dead_player.connect(_restart_level)  #when kitty emits the signal "dead_player", call my function "_restart_level
			#break


func _delete_level():
	_level_instance.queue_free()#queue free is the function to delete nodes in Godot


func _restart_level():
	await get_tree().create_timer(2.0).timeout
	GlobalController.reset_game() #resetting the counters
	_delete_level()
	_create_level.call_deferred(_level_current) #adding call deferred mdelays the execution of the function until the frame is over


func _win_game():
	await get_tree().create_timer(2.0).timeout
	
