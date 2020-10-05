extends Spatial

var rotateStage = false
var x_axis = Vector3(1, 0, 0)
var pivot_point = Vector3(0, 100, 0)

var hazardsResourcePrefix = "res://Scenes/LevelHazards/"
var levelHazardScenes = ["SimplePoles.tscn"]
var currHazards = []

onready var originalTrackTransform = $"loop the loop".transform
onready var originalPortalTransform = $Portal.transform

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func startGame():
    while(currHazards.size() > 0):
        var hazardLeaving = currHazards.pop_front()
        hazardLeaving.queue_free()
    $"loop the loop".transform = originalTrackTransform
    $Portal.transform = originalPortalTransform
    initializeNewHazard()
    $PlayerCar.translation = Vector3(25, 0, 190)
    $PlayerCar.startMoving()

var timer = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if(rotateStage):
        rotateElement($"loop the loop", delta)
        rotateElement($Portal, delta, Vector3(8.5,81,0))
        for hazard in currHazards:
            rotateElement(hazard, delta)
    timer += delta
    if timer > 1:
        $HUD.loseLife()
        timer = 0

func _on_PlayerCar_hit_loop_beginning():
    rotateStage = true

func rotateElement(node, delta, starting_point = Vector3(0,0,0)):
        var pivot_radius = starting_point - pivot_point
        var pivot_transform = Transform(node.transform.basis, pivot_point)
        node.transform = pivot_transform.rotated(x_axis, -delta).translated(pivot_radius)

func _on_Portal_body_entered(area):
    $PlayerCar.translation = Vector3(25,0,0)
    initializeNewHazard()

func _on_game_over():
    rotateStage = false
    $PlayerCar.stopMoving()
    $PlayerCar.translation.z = 1
    print("game over!")
    
func initializeNewHazard():
    var scene = load(hazardsResourcePrefix + levelHazardScenes[0])
    var sceneInstance = scene.instance()
    sceneInstance.connect("takeDamage", self, "_on_take_damage")
    self.add_child(sceneInstance)
    currHazards.push_back(sceneInstance)
    if(currHazards.size() > 1):
        var hazardLeaving = currHazards.pop_front()
        hazardLeaving.queue_free()

func _on_take_damage():
    $HUD.loseLife()
