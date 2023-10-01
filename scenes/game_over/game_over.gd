extends Control


func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	%Body.text = "You scored %s points in %s seconds!" % [Global.score, Global.time]
	%Retry.pressed.connect(_on_retry_pressed.bind())
	%MainMenu.pressed.connect(_on_main_menu_pressed.bind())


func _on_retry_pressed():
	SceneManager.transition_to("Game")


func _on_main_menu_pressed():
	SceneManager.transition_to("MainMenu")
