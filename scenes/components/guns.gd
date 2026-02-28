extends Node2D

@onready var ray = $RayCast2D

@onready var sound = $AudioStreamPlayer2D
@onready var perminint_marker_scene = preload("res://scenes/components/permenint_marker.tscn")

@onready var marker = $Marker2D

func place_tracker():
	if hud.data.ammo != 0:
		hud.data.ammo -= 1
		sound.play()
		var new_marker = perminint_marker_scene.instantiate()
		var distance = ray.get_collider().to_local(marker.global_position).distance_to(ray.get_collider().to_local(ray.get_collision_point()))
		var duration = distance / 600
		var object_type
		new_marker.global_position = ray.get_collider().to_local(marker.global_position)
		object_type = ray.get_collider()
		ray.get_collider().add_child(new_marker)
		new_marker.move_marker(distance,ray.get_collider().to_local(ray.get_collision_point()), object_type, get_parent().global_rotation)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		place_tracker()
