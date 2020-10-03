extends Spatial

var rotateStage = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(rotateStage):
		$"loop the loop".rotate_x(-delta)


func _on_PlayerCar_hit_loop_beginning():
	rotateStage = true
