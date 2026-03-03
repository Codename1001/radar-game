extends Node2D

@onready var ray = $RayCast2D

@onready var sound = $AudioStreamPlayer2D
@onready var bullet_types = {"tracking_beacon":preload("res://scenes/components/permenint_marker.tscn"), "standerd_torpedo": preload("res://scenes/components/standerd_torpedo.tscn")}
@onready var marker = $Marker2D
@export var max_angle = 45
@export var min_angel = -45
var rotate_direction = 0

var can_shoot= true



func place_tracker():
	if Input.is_action_just_pressed("shoot") and can_shoot == true and ray.get_collider():
		if globalVars.data.ammo_type[hud.selected_bulet_type] != 0:
			globalVars.data.ammo_type[hud.selected_bulet_type] -= 1
			sound.play()


			var new_marker = bullet_types[hud.bulet_type_button.get_item_text(hud.bulet_type_button.get_selected_id())].instantiate()
			var distance = ray.get_collider().to_local(marker.global_position).distance_to(ray.get_collider().to_local(ray.get_collision_point()))
			var duration = distance / 600
			var object_type
			new_marker.global_position = ray.get_collider().to_local(marker.global_position)
			object_type = ray.get_collider()
			ray.get_collider().add_child(new_marker)
			new_marker.move_marker(distance,ray.get_collider().to_local(ray.get_collision_point()), object_type, global_rotation)


func aim_guns():
	if Input.is_action_pressed("aim guns left")== true and Input.is_action_pressed("aim guns right")==true:
		rotate_direction = move_toward(rotate_direction,0,1)

	if Input.get_action_strength("aim guns right")- Input.get_action_strength("aim guns left") !=0 :
		rotate_direction += Input.get_action_strength("aim guns right")- Input.get_action_strength("aim guns left")

	rotate_direction = clamp(rotate_direction ,min_angel,max_angle)
	rotation_degrees = rotate_direction

func _draw() -> void:
	if globalVars.data.ammo_type[hud.selected_bulet_type] !=0:
		if ray.get_collider():
			draw_dashed_line($Marker2D.position,ray.target_position/5,Color(0.369, 0.894, 0.106, 0.258), 4,8,false,true)
			#									to_local(ray.get_collision_point())
		else:
			draw_dashed_line($Marker2D.position,ray.target_position/5,Color(0.369, 0.894, 0.106, 0.258)         , 4,8,false,true)
func _process(delta: float) -> void:
	if globalVars.control == true:
		aim_guns()
		place_tracker()
		queue_redraw()
