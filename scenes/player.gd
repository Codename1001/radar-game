extends RigidBody2D


var scanning = true

@onready var  scaner = $scaner

var thrust = 60
var rotation_speed = 500
var input_derection = Vector2.ZERO


func aplly_thrust(state):
	input_derection.y = Input.get_action_strength("up")-Input.get_action_strength("down")
	state.apply_central_force(Vector2(0,input_derection.y * -thrust).rotated(rotation))
	
func rotate_ship(state):
	input_derection.x = Input.get_action_strength("left")-Input.get_action_strength("right")
	state.apply_torque(- input_derection.x * rotation_speed)
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	aplly_thrust(state)
	rotate_ship(state)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("scan map"):
		scanning = false
	else :
		scanning= true
	if scanning == true:
		scaner.radar_ping()
	if scanning == false:
		scaner.scan()
	
	
	
