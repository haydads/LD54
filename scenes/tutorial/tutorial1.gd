extends Control


func _ready():
	%Next.pressed.connect(SceneManager.transition_to.bind("Tutorial2"))
