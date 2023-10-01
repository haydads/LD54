extends Node2D



const MARGIN = 64
const WORMHOLE_RADIUS = 64

var score : int = 0
var player
var magnet
var time : float = 0.0
var target_asteroids = 1
var is_spawning_wormhole : bool = false
var available_health_pickups : int = 3


func _ready():
	Global.score = 0
	Global.time = 0
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	%Magnet.player = %Player
	%Player.magnet = %Magnet
	%Player.hit.connect(_on_player_hit.bind())
	%Time.second.connect(_on_second_passed.bind())
	%Coin.collected.connect(_on_coin_collected.bind())
	%HealthBar.game_over.connect(_on_game_over.bind())


func _physics_process(delta):
	time += delta
	
	if not %AnimationPlayer.is_playing():
	#if not is_spawning_wormhole:
		
		if %Asteroids.get_child_count() < target_asteroids:
			#print("There are only %s asteroids. Spawn Wormhole" % %Asteroids.get_child_count())
			_spawn_wormhole()


func _spawn_wormhole():
	is_spawning_wormhole = true
	var offset = MARGIN + WORMHOLE_RADIUS
	var random_position = Vector2(Random.integer_between(offset, 1280 - offset), Random.integer_between(offset, 800 - offset))
	%WormHole.position = random_position
	var required_asteroids : int = target_asteroids - %Asteroids.get_child_count()
	required_asteroids = min(required_asteroids, 5)
	match required_asteroids:
		5: %AnimationPlayer.play("wormhole_spawn_5")
		4: %AnimationPlayer.play("wormhole_spawn_4")
		3: %AnimationPlayer.play("wormhole_spawn_3")
		2: %AnimationPlayer.play("wormhole_spawn_2")
		1: %AnimationPlayer.play("wormhole_spawn_1")
		_: 
			printerr("WHY DID THIS TRIGGER?")
			is_spawning_wormhole = false


func _finished_wormhole():
	is_spawning_wormhole = false



func _add_asteroid():
	var asteroid = load("res://scenes/game/asteroid/asteroid.tscn").instantiate()
	asteroid.position = %WormHole.position
	asteroid.rubble_container = %Rubble
	%Asteroids.add_child(asteroid)


func _add_health_pickup():
	var pickup = load("res://scenes/game/pickup/health/health.tscn").instantiate()
	var offset : int = 256
	pickup.position = Vector2(Random.integer_between(offset, 1280 - offset), Random.integer_between(offset, 800 - offset))
	pickup.collected.connect(_on_health_collected.bind())
	%Pickups.add_child(pickup)
	available_health_pickups -= 1


func move_coin():
	var offset : int = 256
	%Coin.position = Vector2(Random.integer_between(offset, 1280 - offset), Random.integer_between(offset, 800 - offset))


func _on_player_hit():
	%HealthBar.health -= 1


func _on_health_collected():
	%HealthBar.health += 1


func _on_coin_collected():
	move_coin()
	%Score.add()


func _on_second_passed(second : int):
	%Score.add()
	@warning_ignore("integer_division")
	target_asteroids = min(floor(second / 5) + 1, 20)
	#print("%s out of %s" % [%Asteroids.get_child_count(), target_asteroids])
	
	match second:
		30: %Player.speed = 350
		60: %Player.speed = 400
		90: %Player.speed = 450
		120: %Player.speed = 500
	
	if available_health_pickups > 0:
		if %HealthBar.health < %HealthBar.max_health:
			var has_health_pickup : bool = false
			for pickup in %Pickups.get_children():
				if pickup is HealthPickup:
					has_health_pickup = true
		
			if not has_health_pickup:
				if second % 8 == 0:
					_add_health_pickup()


func _on_game_over():
	Global.time = %Time.value
	Global.score = %Score.value
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SceneManager.transition_to("GameOver")
