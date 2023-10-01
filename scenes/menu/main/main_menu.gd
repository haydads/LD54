extends Control


func _ready():
	%Play.pressed.connect(_on_play_pressed.bind())


func _process(delta):
	%WormHole.rotation += 3 * delta


func _on_play_pressed():
	if Global.has_completed_tutorial:
		SceneManager.transition_to("Game")
	else:
		SceneManager.transition_to("Tutorial1")
	
