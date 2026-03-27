extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globalVars.target_position = get_global_mouse_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("leftclick"):
		$Area2D.monitorable = true
	else :
		$Area2D.monitorable  = false
	global_position = get_global_mouse_position()
	globalVars.target_position = get_global_mouse_position()
