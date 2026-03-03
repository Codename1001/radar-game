extends RigidBody2D

var normal
var normal_point
var damage
var damage_multiplyer


@onready var sound = $AudioStreamPlayer2D
@onready var  scaner = $scaner

var thrust = 60
var rotation_speed = 500
var input_derection = Vector2.ZERO
var rotate_derection = 0
var straf_direction = 1



func aplly_thrust(state):
	if globalVars.control == true:
		input_derection.y = Input.get_action_strength("up")-Input.get_action_strength("down")
		state.apply_central_force(Vector2(0,input_derection.y * -thrust).rotated(rotation))


		input_derection.x = Input.get_action_strength("straf left")-Input.get_action_strength("straf right")
		#if rotation_degrees > 80 :
			#input_derection.x = -input_derection.x
		#if rotation_degrees < -80 :
			#input_derection.x = -input_derection.x
		state.apply_central_force(Vector2(input_derection.x * -thrust/2 ,0).rotated(rotation))
		rotate_derection = Input.get_action_strength("left")-Input.get_action_strength("right")
		state.apply_torque(- rotate_derection * rotation_speed)

func update_stats():
	globalVars.data.speed = roundi(linear_velocity.length()/2)
	globalVars.data.position = global_position/2
	hud.update_hud_data()

func  take_damage(body):
	modulate = Color(0.891, 0.131, 0.0)
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1.0, 1.0, 1.0),.5)
	damage_multiplyer = 1
	if globalVars.data.speed > 10:
		sound.play()
		damage = damage_multiplyer * globalVars.data.speed * abs(normal_point.normalized().dot(normal.normalized()))
		globalVars.data.health = roundi(globalVars.data.health - damage)
		hud.update_hud_data()
	else:
		pass
	if globalVars.data.health <= 0 :
		tween.stop()
		modulate = Color(0.891, 0.131, 0.0)
		globalVars.control = false




func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	aplly_thrust(state)

	for i in range(state.get_contact_count()):
		normal = state.get_contact_local_normal(i)
		normal_point = state.get_contact_local_position(i)
		#wnormal.rotated(rotation)
		normal_point.rotated(rotation)
		normal = to_global(normal)
		normal_point = to_global(normal_point)

func _physics_process(delta: float) -> void:
	$"background noise".volume_db = globalVars.data.speed / 10
	if globalVars.data.speed ==0:
		$"background noise".volume_db = move_toward($"background noise".volume_db,-80.5,2 )
	update_stats()

func _on_body_entered(body: Node) -> void:
	take_damage(body)
