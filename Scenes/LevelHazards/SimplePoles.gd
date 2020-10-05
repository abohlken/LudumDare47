extends Spatial

signal takeDamage

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func _on_Area_body_entered(body):
    emit_signal("takeDamage")


func _on_Area_area_entered(area):
    emit_signal("takeDamage")
