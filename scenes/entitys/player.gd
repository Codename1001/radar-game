extends RigidBody2D




@onready var  scaner = $scaner

var thrust = 60
var rotation_speed = 500
var input_derection = Vector2.ZERO
var rotate_derection = 0
var straf_direction = 1

func aplly_thrust(state):
	input_derection.y = Input.get_action_strength("up")-Input.get_action_strength("down")
	state.apply_central_force(Vector2(0,input_derection.y * -thrust).rotated(rotation))

	input_derection.x = Input.get_action_strength("straf left")-Input.get_action_strength("straf right")
	if rotation_degrees > 80 :
		input_derection.x = -input_derection.x

	if rotation_degrees < -80 :

		input_derection.x = -input_derection.x
	state.apply_central_force(Vector2(input_derection.x * -thrust/2 ,0).rotated(rotation))

	if Input.is_key_pressed(KEY_SHIFT):
		pass
	else:
		rotate_derection = Input.get_action_strength("left")-Input.get_action_strength("right")
		state.apply_torque(- rotate_derection * rotation_speed)

func update_stats():
	$hud.data.speed = roundi(linear_velocity.length())
	$hud.data.position = global_position
	$hud.update_hud_data()



func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	aplly_thrust(state)


func _physics_process(delta: float) -> void:
	update_stats()
