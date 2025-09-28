extends Sprite2D

var textures = {
	1: preload("res://blue_coin_better.png"),
	2: preload("res://green_coin_better.png"),
	3: preload("res://red_coin_better.png"),
	4: preload("res://yellow_coin_better.png"),
}

var numbers = [1,1,1,1,1,
			   2,2,2,2,2,
			   3,3,3,3,3,
			   4,4,4,4,4]

func _ready():
	randomize()
	pick_random_number()

func pick_random_number():
	if numbers.size() == 0:
		print("You win!")   # Or trigger a win screen
		return

	var rand_index = randi() % numbers.size()
	var value = numbers[rand_index]
	numbers.remove_at(rand_index)

	# since this script is ON a Sprite2D, just use `texture`
	set_texture(textures[value])
	print(value)
