extends Node2D



const MARGIN = 64
const WORMHOLE_RADIUS = 64

var score : int = 0
var player
var magnet
var time : float = 0.0
var target_asteroids = 10
var is_spawning_wormhole : bool = false


func _ready():
	%Magnet.player = %Player
	%Player.magnet = %Magnet
	%Player.hit.connect(_on_player_hit.bind())


func _physics_process(delta):
	time += delta
	
	if not %AnimationPlayer.is_playing():
	#if not is_spawning_wormhole:
		
		if %Asteroids.get_child_count() < target_asteroids:
			print("There are only %s asteroids. Spawn Wormhole" % %Asteroids.get_child_count())
			_spawn_wormhole()


func _spawn_wormhole():
	is_spawning_wormhole = true
	var random = RandomNumberGenerator.new()
	random.randomize()
	var offset = MARGIN + WORMHOLE_RADIUS
	var random_position = Vector2(random.randi_range(offset, 1280 - offset), random.randi_range(offset, 800 - offset))
	print("Trying to create wormhole at %s" % random_position)
	%WormHole.position = random_position
	#print(%WormHole.position)
	var required_asteroids : int = target_asteroids - %Asteroids.get_child_count()
	required_asteroids = min(required_asteroids, 3)
	print("Trying to create %s asteroids" % required_asteroids)
	match required_asteroids:
		3: %AnimationPlayer.play("wormhole_spawn_3")
		2: %AnimationPlayer.play("wormhole_spawn_2")
		1: %AnimationPlayer.play("wormhole_spawn_1")
		_: 
			printerr("WHY DID THIS TRIGGER?")
			is_spawning_wormhole = false


func _finished_wormhole():
	%WormHole.visible = false
	is_spawning_wormhole = false
	print("Removing wormhole")
	#%WormHole.position = Vector2.ZERO


func _add_asteroid():
	var asteroid = load("res://scenes/game/asteroid/asteroid.tscn").instantiate()
	asteroid.position = %WormHole.position
	asteroid.hit.connect(_on_asteroid_hit.bind())
	asteroid.rubble_container = %Rubble
	%Asteroids.add_child(asteroid)


func _on_player_hit():
	%HealthBar.health -= 1


func _on_asteroid_hit():
	score += 100
	%Score.text = "Score: %s" % score
