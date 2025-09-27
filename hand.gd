extends Node2D

@onready var sprite = $Hand/Sprite2D

func _ready():
	var random = randi() % 5
	var new_texture = load("res://rock1.png")
	sprite.texture = new_texture
