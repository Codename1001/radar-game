extends RigidBody2D

@onready var rays = $rays.get_children()
@export var id = 1
@onready var marker = $Marker2D
var stear_direction = 0

var intrests = []
var dangers = []
var near_boids = []

var move_speed = 100
var turn_speed = 70
#var avrage_direction =0

var  target_position = Vector2.ZERO

var debug = false

func group():
	var boids = Vector2.ZERO
	var avrige_posiiton = Vector2.ZERO
	# finds the avrage position of local boids
	intrests = []

	if !near_boids == []:
		for area in near_boids:
			boids += area.global_position 
			avrige_posiiton = (boids / near_boids.size())
			intrests.append(avrige_posiiton)
			#target_position = (avrige_posiiton / near_boids.size())
		pass
	else:
		
		intrests.append($Marker2D.global_position)
		#intrests.append((avrige_posiiton / near_boids.size()))
		#target_position = $Marker2D.global_position
	#print(rad_to_deg(get_angle_to(target_position))+90)
	#intrests.append( get_global_mouse_position())

	#finds the avrage point of itrest and sets targaet position to it
	for i in intrests:
		
		if intrests.size() <1:
			target_position = (i/ intrests.size())
		else :
			target_position = i
	
	stear_direction =  100*(rad_to_deg(get_angle_to(target_position))+90)
	
	
	queue_redraw()
	pass

func stear(state):

	#for i in rays :
		#if i.is_colliding()== true:
			#intrests.append((i.rotation_degrees *-1) * turn_speed)
			#if i.rotation_degrees ==0:
				#intrests.append( (45*-1) *turn_speed)
		#if i.is_colliding() == false:
			#intrests.erase(i.rotation_degrees *-1)
			#if i.rotation_degrees ==0:
				#intrests.erase((i.rotation_degrees *-1) * turn_speed)
	pass

func update_direction(state):

	
	#stear_direction = 0
	
	group()
	stear(state)

	#for i in intrests:
	#	stear_direction += i


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#update_direction(state)
	group()
	state.apply_torque(stear_direction)
	state.apply_central_force(Vector2(0,-move_speed).rotated(rotation))


func _draw() -> void:

	if Input.is_action_just_pressed("debug ") and debug ==true:
		debug = false
		$"debug layer".hide()
	elif Input.is_action_just_pressed("debug ") and debug ==false:
		debug = true
		$"debug layer".show()

	if debug == true:
		draw_line(to_local(self.global_position), to_local(target_position),Color(0.37, 0.667, 0.109, 1.0),5)



func _on_area_2d_area_entered(area: Area2D) -> void:

	near_boids.append(area)

	#intrests.append(area.get_parent().stear_direction ) #move_toward(stear_direction,i.get_parent().stear_direction,turn_speed)


func _on_area_2d_area_exited(area: Area2D) -> void:
	near_boids.erase(area)
	#intrests.erase(area.get_parent().stear_direction)
