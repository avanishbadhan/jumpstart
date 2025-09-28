extends Button

@onready var popup_label = $"../Not_Green"
@onready var cutting = $"../machete/AudioStreamPlayer"
@onready var slice = $"../machete/AudioStreamPlayer2"
@onready var hiddenCoin = $"../../HiddenCoin"
@onready var hand = $"../../Hand/Sprite2D"
var fingers = 6

var blue_tTure = preload("res://blue_coin_better.png")
var red_tTure = preload("res://red_coin_better.png")
var yellow_tTure = preload("res://yellow_coin_better.png")
var green_tTure = preload("res://green_coin_better.png")

func _ready():
	# In Godot 4, you don’t need to connect like this if you connected via the editor.
	pressed.connect(_button_pressed)
	

func _button_pressed():
	popup_label.modulate = Color(0, 0, 0)
	slice.play()
	cutting.play()
	if(hiddenCoin.texture != blue_tTure):
		popup_label.text = "Drowning in doubt? It’s not blue."
	elif(hiddenCoin.texture != red_tTure):
		popup_label.text = "Not red. But you’ll still bleed."
	elif(hiddenCoin.texture != green_tTure):
		popup_label.text = "Green’s for life. You’re closer to death."
	if(hiddenCoin.texture != blue_tTure):
		popup_label.text = "No sunlight here. It isn’t yellow."
	
	var randomb = randi()%8
	fingers -= 1
	if fingers == 5:
		hand.texture = preload("res://Screenshot_2025-09-28_at_3.01.31_AM-removebg-preview.png")
	elif fingers == 4:
		hand.texture = preload("res://2.png")
	elif fingers == 3:
		hand.texture = preload("res://3.png")
	elif fingers == 2:
		hand.texture = preload("res://4.png")
	elif fingers == 1:
		hand.texture = preload("res://5.png")
	elif fingers < 1:
		hand.texture = preload("res://6.png")
		match randomb:
			0: popup_label.text = "That was the last one. You won’t be needing hands where you're going."
			1: popup_label.text = "Guessing’s hard without fingers, isn’t it?"
			2: popup_label.text = "You bet your hands... and lost it all."
			3: popup_label.text = "Oops. House wins again."
			4: popup_label.text = "The colors fade. So do you."
			5: popup_label.text = "Nothing left to give. And still, you guessed wrong."
			6: popup_label.text = "You were never meant to win."
			7: popup_label.text = "Did you think this was fair?"
	popup_label.visible = true
	
	print(hand.texture)
	
	var timer = get_tree().create_timer(3.0)
	await timer.timeout
	popup_label.visible = false
