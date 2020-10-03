extends KinematicBody

signal hit_loop_beginning

export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0

export var joy_steering = JOY_ANALOG_LX
export var steering_mult = -1.0

export var position = Vector3()
var velocity = Vector3(0,0,-50)
var floorNormal = Vector3(0,1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var steer_val = steering_mult * Input.get_joy_axis(0, joy_steering)
	if Input.is_action_pressed("ui_left"):
		steer_val = 1.0
	elif Input.is_action_pressed("ui_right"):
		steer_val = -1.0

	steer_target = steer_val * MAX_STEER_ANGLE
	if (steer_target < steer_angle):
		steer_angle -= steer_speed * delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += steer_speed * delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	#steering = steer_angle
	
	if(translation.z > 0):
		moveCar()
	else:
		emit_signal("hit_loop_beginning")
	
func moveCar():
	position = position + move_and_slide(velocity,floorNormal)
	rotation.x += get_floor_normal().x
	floorNormal.x = get_floor_normal().x
	print(translation)
