extends Camera2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("zoom in"):
		zoom = zoom.move_toward(Vector2(1,1),0.01)
	if Input.is_action_pressed("zoom out"):
		zoom = zoom.move_toward(Vector2(0.045,0.045),0.01)
