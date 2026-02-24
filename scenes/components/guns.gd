extends Node2D

@onready var ray = $RayCast2D

@onready var perminint_marker_scene = preload("res://scenes/components/permenint_marker.tscn")

func place_tracker():
	var new_marker = perminint_marker_scene.instantiate()
	new_marker.global_position = ray.get_collider().to_local(ray.get_collision_point())
	if ray.get_collider().is_in_group("entity"):
		new_marker.change_color("blue")
	if ray.get_collider().is_in_group("enemy"):
		new_marker.change_color("red")
	if ray.get_collider().is_in_group("object"):
		new_marker.change_color("green")
	ray.get_collider().add_child(new_marker)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		place_tracker()
