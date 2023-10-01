class_name Magnet extends CharacterBody2D


var player
#var speed : int = 1000


func _physics_process(_delta : float):
	#var distance : Vector2 =  get_global_mouse_position() - position
	#var direction : Vector2 = (distance).normalized()
	
	#print(distance.x * 0.1)
	#velocity = distance * 100.0
	
	#move_and_collide(velocity * delta)
	position = get_global_mouse_position()
	#velocity = direction * delta
	#move_and_collide(velocity * delta)
	look_at(player.position)
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	pass
