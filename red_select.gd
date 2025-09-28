extends Button

@onready var sprite: Sprite2D = get_node("../HiddenCoin")
@onready var cloth: Sprite2D = get_node("../cloth")
@onready var guess: Label = get_node("../coin_guess") 
var red_texture = preload("res://red_coin_better.png")
 

func _ready() -> void:
	self.pressed.connect(_button_pressed)

func _button_pressed() -> void:
	if sprite.texture == red_texture:
		guess.text = "Correct!"
	else:
		guess.text = "Incorrect..."
	guess.visible = true

	var timer = get_tree().create_timer(3.0)
	await timer.timeout
	guess.visible = false
