extends Control


var timer : float = 0.0
var heart_timer : float = 6.0
var hearts_available : int = 3


func _ready():
	%Player.magnet = %Magnet
	%Magnet.player = %Player
	%Back.pressed.connect(SceneManager.transition_to.bind("Tutorial3"))
	%Play.pressed.connect(_on_play_pressed.bind())
	%Coin.collected.connect(_on_coin_collected.bind())
	%Player.hit.connect(_on_player_hit.bind())


func _physics_process(delta):
	%DamageWarning.visible = bool(timer > 0.0)
	if timer > 0.0: timer -= delta
	
	if hearts_available > 0:
		if heart_timer > 0.0: heart_timer -= delta
		if heart_timer <= 0.0:
			var pickup = load("res://scenes/game/pickup/health/health.tscn").instantiate()
			pickup.position = Vector2(Random.integer_between(128, 1280 - 128), Random.integer_between(352, 616))
			%Pickups.add_child(pickup)
			hearts_available -= 1
			heart_timer = 8.0


func _on_play_pressed():
	Global.has_completed_tutorial = true
	SceneManager.transition_to("Game")


func _on_player_hit():
	timer = 2.0


func _on_coin_collected():
	%Coin.position = Vector2(Random.integer_between(128, 1280 - 128), Random.integer_between(352, 616))
