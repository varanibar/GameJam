class_name MugsContainer
extends Node

var _mugs_destroyed: int = 0
var _total_mugs: int = 0
var _lives: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var array_mugs:= get_children() #we are getting an array of the children of the node MugsContainer which will be the scene Mugss
	_total_mugs = array_mugs.size() 
	
	for mugs in array_mugs:
		mugs.mugs_container = self # this is completing the referencing, the 
									#variable mugs_container in the script mugs is not empty anymore
									#we basically go through all the mugs and filling the variable 
									#mugs_container with a reference to this node

#for the mugs to be able to call this function, so the mugs script needs a reference to this script
func is_mug_broken():
	_mugs_destroyed += 1
	print("mugs destroyed: ", _mugs_destroyed)
	if _mugs_destroyed == 9:
		_lives += 1
		print("GAINED A LIFE")
