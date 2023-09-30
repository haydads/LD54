extends HBoxContainer


signal game_over()

var health : int = 5:
	set(new_health):
		health = new_health
		if health == 0: game_over.emit()
		for child in get_children():
			if int(str(child.name)) <= health:
				child.texture = load("res://assets/textures/health/full_health.svg")
			else:
				child.texture = load("res://assets/textures/health/empty_health.svg")
