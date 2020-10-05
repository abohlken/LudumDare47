extends KinematicBody

signal hit_loop_beginning

export var STEER_ANGLE = 2.8
export var GRAVITY = -10
export var lateralSpeed = 66
var velocity = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func startMoving():
    velocity = Vector3(0,0,-50)
    
func stopMoving():
    velocity = Vector3(0,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var steer_val = 0
    if Input.is_action_pressed("ui_left"):
        steer_val = -1.0
        if $car.get_rotation().y != -STEER_ANGLE: $car.set_rotation(Vector3(0,-STEER_ANGLE,0))
    elif Input.is_action_pressed("ui_right"):
        steer_val = 1.0
        if $car.get_rotation().y != STEER_ANGLE: $car.set_rotation(Vector3(0,STEER_ANGLE,0))
    else:
        if $car.get_rotation().y != 0: $car.set_rotation(Vector3(0,0,0))

    move_and_slide(Vector3(steer_val*lateralSpeed,GRAVITY,0))
    
    if(translation.z < 0):
        emit_signal("hit_loop_beginning")
    else:
        move_and_slide(velocity)
