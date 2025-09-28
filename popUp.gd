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
	match random:
		0: popup_label.text = "The color isn't green"
		1: popup_label.text = "The color isn't blue"
		2: popup_label.text = "The color isn't red"
		3: popup_label.text = "The color isn't yellow"

	fingers -= 1
	if fingers < 1:
		popup_label.text = "Lost too many fingers, you died..."

	popup_label.visible = true

	var timer = get_tree().create_timer(3.0)
	await timer.timeout
	popup_label.visible = false
