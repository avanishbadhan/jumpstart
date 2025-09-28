extends Node2D
# --- Nodes ---
@onready var red_button: Button = $red_select
@onready var blue_button: Button = $blue_select
@onready var yellow_button: Button = $yellow_select
@onready var green_button: Button = $green_select
@onready var sprite: Sprite2D = $HiddenCoin
@onready var fade_rect: ColorRect = $CanvasLayer/FadeRect
@onready var popup_label: Label = $coin_guess

@export var wrongCounter = 0
# --- Textures for coins ---
var textures = {
	1: preload("res://blue_coin_better.png"),
	2: preload("res://green_coin_better.png"),
	3: preload("res://red_coin_better.png"),
	4: preload("res://yellow_coin_better.png")
}

# The currently hidden coin for this round
var hidden_coin: Texture2D

# --- Assign a "color ID" to each button ---
var button_colors = {}

func _ready():
	randomize()

	# Assign color IDs
	button_colors = {
		red_button: 3,
		blue_button: 1,
		green_button: 2,
		yellow_button: 4
	}

	# Connect button signals
	for button in button_colors.keys():
		button.pressed.connect(_on_button_pressed.bind(button))

	start_new_round()


# --- Called when a button is pressed ---
func _on_button_pressed(pressed_button: Button):
	_disable_all_buttons()
	
	if button_colors[pressed_button] == get_key_by_value(textures, hidden_coin):
		popup_label.text = "Correct!"
	else:
		popup_label.text = "Incorrect..."
	
	# Fade out → black
	await fade_to_black()
	# Wait 1 second in black
	await get_tree().create_timer(1.0).timeout
	# Fade back in
	await fade_from_black()
	
	start_new_round()


# --- Start a new round ---
func start_new_round():
	# Pick a random coin
	var rand_index = randi() % textures.size()
	hidden_coin = textures.values()[rand_index]
	sprite.texture = hidden_coin
	
	popup_label.text = ""  # Clear previous message
	_enable_all_buttons()


# --- Enable/disable all buttons ---
func _disable_all_buttons():
	for button in button_colors.keys():
		button.disabled = true

func _enable_all_buttons():
	for button in button_colors.keys():
		button.disabled = false


# --- Fade functions ---
func fade_to_black() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0) # fade over 1 sec
	await tween.finished

func fade_from_black() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 1.0) # fade over 1 sec
	await tween.finished


# --- Helper function: get the key of a dictionary by its value ---
func get_key_by_value(dict: Dictionary, val):
	for k in dict.keys():
		if dict[k] == val:
			return k
	return null

func _process(delta: float) -> void:
	if(wrongCounter > 3):
		var timer2 = get_tree().create_timer(1.0)
		await timer2.timeout
		get_tree().change_scene_to_file("res://gameover.tscn")
