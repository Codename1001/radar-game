extends Node2D

@onready var ray = $rays.get_children()
@onready var marker_scene = preload("res://scenes/components/marker.tscn")
@onready var perminint_marker_scene = preload("res://scenes/components/permenint_marker.tscn")
var scanning = true

func radar_ping():
	rotate(deg_to_rad(5))
	for i in ray:
		if i.is_colliding():
			var new_marker = marker_scene.instantiate()
			new_marker.global_position = i.get_collision_point()
			new_marker.change_color("green")
			get_parent().get_parent().add_child(new_marker)




func scan():
	rotate(deg_to_rad(5))
	for i in ray:
		if i.is_colliding():
			var new_marker = marker_scene.instantiate()
			new_marker.global_position = i.get_collider().to_local(i.get_collision_point())
			if i.get_collider().is_in_group("entity"):
				new_marker.change_color("blue")
			if i.get_collider().is_in_group("enemy"):
				new_marker.change_color("red")
			if i.get_collider().is_in_group("object"):
				new_marker.change_color("green")
			i.get_collider().add_child(new_marker)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("scan map"):
		scanning = false
	else :
		scanning= true
	if scanning == true:
		radar_ping()
	if scanning == false:
		scan()
