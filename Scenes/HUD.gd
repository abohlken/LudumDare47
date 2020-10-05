extends Control

signal startGame
signal gameOver

var maxLife = 5
var lifebarTextures = []

# Called when the node enters the scene tree for the first time.
func _ready():
    preload("res://Textures/lifebar.png")
    $"Lifebar Label".visible = false
    $GameOver.visible = false

func startGame():
    initializeLifebar()
    $StartMenu.visible = false
    $VolumeLabel.visible = false
    $GameOver.visible = false
    emit_signal("startGame")

func initializeLifebar():
    $"Lifebar Label".visible = true
    for i in range(maxLife):
        var lifeTexture = TextureRect.new()
        lifeTexture.texture = load("res://Textures/lifebar.png")
        lifeTexture.rect_position.x = 88*(1+i)+35
        lifeTexture.rect_position.y = 10
        lifebarTextures.push_back(lifeTexture)
        add_child(lifeTexture)

func loseLife():
    if lifebarTextures.size() > 1:
        lifebarTextures.pop_back().queue_free()
    else:
        gameOverScreen()
        emit_signal("gameOver")

func gameOverScreen():
    while lifebarTextures.size() > 0: lifebarTextures.pop_back().queue_free()
    $"Lifebar Label".visible = false
    $GameOver.visible = true
    $VolumeLabel.visible = true
