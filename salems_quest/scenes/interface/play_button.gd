extends Button

@export var main_scene: PackedScene #reference to the scene we want to load


func _ready() -> void:
	pressed.connect(_play, ConnectFlags.CONNECT_ONE_SHOT)
	#pressed.connect(_play, 4)

func _play():
	get_tree().change_scene_to_packed(main_scene)
