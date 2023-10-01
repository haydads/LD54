extends Control


func _ready():
	%Next.pressed.connect(SceneManager.transition_to.bind("Tutorial4"))
	%Back.pressed.connect(SceneManager.transition_to.bind("Tutorial2"))


func _physics_process(delta):
	if not %AnimationPlayer.is_playing():
		%WormHole.position = Vector2(Random.integer_between(128, 1280 - 128), Random.integer_between(352, 616))
		%AnimationPlayer.play("spawn_wormhole")



func _add_asteroid():
	var asteroid = load("res://scenes/game/asteroid/asteroid.tscn").instantiate()
	asteroid.position = %WormHole.position
	asteroid.rubble_container = %Rubble
	%Asteroids.add_child(asteroid)
