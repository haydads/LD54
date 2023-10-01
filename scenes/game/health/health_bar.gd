extends HBoxContainer


signal game_over()

var max_health : int = 5
var health : int = 5:
	set(new_health):
		health = new_health
		if health == 0: game_over.emit()
		if health > max_health: health = max_health
		for child in get_children():
			if int(str(child.name)) <= health:
				child.texture = load("res://assets/textures/health/full_health.svg")
			else:
				child.texture = load("res://assets/textures/health/empty_health.svg")
