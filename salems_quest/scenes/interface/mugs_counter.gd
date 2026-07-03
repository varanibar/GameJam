extends Control

@export var label_mugs: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalController.signal_updated_mugs.connect(_update_text_mugs) #when GlobalController emits the signal called
																	# signal_update_lives, call my function _update_text_mugs

func _update_text_mugs():
	label_mugs.text = "Enchanted mugs: " + str(GlobalController.mugs)
