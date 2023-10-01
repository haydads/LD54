extends Control


var timer : float = 0.0


func _ready():
	%Player.magnet = %Magnet
	%Magnet.player = %Player
	%Next.pressed.connect(SceneManager.transition_to.bind("Tutorial3"))
	%Back.pressed.connect(SceneManager.transition_to.bind("Tutorial1"))
	%Player.hit.connect(_on_player_hit.bind())


func _physics_process(delta):
	%DamageWarning.visible = bool(timer > 0.0)
	if timer > 0.0: timer -= delta


func _on_player_hit():
	timer = 2.0
