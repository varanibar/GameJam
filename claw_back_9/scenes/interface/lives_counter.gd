extends Control

@export var label_lives: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalController.signal_updated_lives.connect(_update_text_lives)

func _update_text_lives():
	label_lives.text = "Kitty lives: " + str(GlobalController.lives)
