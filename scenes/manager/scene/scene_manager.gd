extends Node


var target
var scenes : Dictionary = {
	"MainMenu" : "res://scenes/menu/main/main_menu.tscn",
	"Game" : "res://scenes/game/game.tscn",
	"GameOver" : "res://scenes/game_over/game_over.tscn",
	"Tutorial1" : "res://scenes/tutorial/tutorial1.tscn",
	"Tutorial2" : "res://scenes/tutorial/tutorial2.tscn",
	"Tutorial3" : "res://scenes/tutorial/tutorial_3.tscn",
	"Tutorial4" : "res://scenes/tutorial/tutorial4.tscn"
}


func _ready():
	transition_to("MainMenu")


func transition_to(scene : String):
	target = scenes.get(scene)
	%AnimationPlayer.play("Fade")


func _change():
	get_tree().change_scene_to_file(target)
	target = ""
