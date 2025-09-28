extends Button

@onready var popup_label = $"../Not_Green"
@onready var cutting = $"../machete/AudioStreamPlayer"
@onready var slice = $"../machete/AudioStreamPlayer2"
var fingers := 5

func _ready():
	# In Godot 4, you don’t need to connect like this if you connected via the editor.
	pressed.connect(_button_pressed)

func _button_pressed():
	popup_label.modulate = Color(0, 0, 0)
	slice.play()
	cutting.play()
	var random = randi() % 4
	var randomb = randi() % 8
	match random:
		0: popup_label.text = "Green’s for life. You’re closer to death."
		1: popup_label.text = "Drowning in doubt? It’s not blue."
		2: popup_label.text = "Not red. But you’ll still bleed."
		3: popup_label.text = "No sunlight here. It isn’t yellow."

	fingers -= 1
	if fingers < 1:
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

	var timer = get_tree().create_timer(3.0)
	await timer.timeout
	popup_label.visible = false
