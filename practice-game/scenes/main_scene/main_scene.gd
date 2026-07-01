extends Node2D


#We will create an array of levels that holds all the levels as scenes
@export var levels: Array[PackedScene]

var _level_current: int = 1
var _level_instance: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_level(_level_current)


#athe level needs to be instantiated and afterwards it has to be
#added to the Scene Tree, wee need to add level_1 as a child of 
#Main scene, for this we use the function add child 
func _create_level(level_number: int):
	_level_instance = levels[level_number - 1].instantiate()
	add_child(_level_instance)
	
	#Array of the children nodes of the instantiated level(kitty, ghost, player, etc)
	var children := _level_instance.get_children()
	#filtering out the children that belong to the group "characters"
	#connecting the player to the restart level function so the signal emitted
	#by the player when it dies can trigger the function
	for i in children.size():
		if children[i].is_in_group("characters") and children[i].name == "Kitty":
			children[i].dead_player.connect(_restart_level)
			break


#queue free is the function to delete nodes in Godot
#this means : add this node to the queue of nodes that will be deleted 
#at the end of this frame
func _delete_level():
	_level_instance.queue_free()


#we need to activate this when the player dies, so the player will send
#a signal so this function activates
#adding call deferred mdelays the execution of the function until the frame is oversss
func _restart_level():
	_delete_level()
	_create_level.call_deferred(_level_current)
