extends Button

@onready var sprite: Sprite2D = get_node("../HiddenCoin")
@onready var cloth: Sprite2D = get_node("../cloth")
@onready var guess: Label = get_node("../coin_guess") 
var blue_texture = preload("res://blue_coin_better.png")
 
var num = 1
func _ready() -> void:
	self.pressed.connect(_button_pressed)

func _button_pressed() -> void:
	guess.modulate = Color(0, 0, 0)
	print(sprite.number, " ", num, " ", sprite.number == num)
	if sprite.number == num:
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
	$"../red_select".disabled = true
	$"../green_select".disabled = true
	
	var tween = create_tween()
	tween.tween_property(cloth, "modulate:a", 0.0, 1.0)
	tween.tween_property(cloth, "modulate:a", 1.0, 1.0).set_delay(1.5)
	await tween.finished
	sprite.pick_random_number()
	disabled = false
	$"../yellow_select".disabled = false
	$"../red_select".disabled = false
	$"../green_select".disabled = false
