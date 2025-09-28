extends Button
@onready var screen = $"../StartScreen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _button_pressed() -> void:
	screen.visible = false
	disabled = true
	
