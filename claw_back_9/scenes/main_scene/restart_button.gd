extends Button


func _ready() -> void:
	pressed.connect(_restart)

func _restart():
	GlobalController.reset_game()
	get_tree().reload_current_scene()
