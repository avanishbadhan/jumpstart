extends Button

@onready var sprite: Sprite2D = get_node("../HiddenCoin")
@onready var cloth: Sprite2D = get_node("../cloth")
@onready var guess: Label = get_node("../coin_guess") 
var red_texture = preload("res://red_coin_better.png")
 

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	guess.modulate = Color(0, 0, 0)
	if sprite.texture == red_texture:
		guess.text = "Correct!"
	else:
		$"..".wrongCounter+=1
		guess.text = "Incorrect..."
	guess.visible = true

	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	guess.visible = false
	disabled = true
	$"../yellow_select".disabled = true
	$"../blue_select".disabled = true
	$"../green_select".disabled = true
	
	var tween = create_tween()
	tween.tween_property(cloth, "modulate:a", 0.0, 0.1)
	tween.tween_property(cloth, "modulate:a", 1.0, 0.1).set_delay(1.5)
	sprite.pick_random_number()
	disabled = false
	$"../yellow_select".disabled = false
	$"../blue_select".disabled = false
	$"../green_select".disabled = false
