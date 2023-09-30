class_name Player extends CharacterBody2D #RigidBody


signal hit()

#var health : int = 5
var timer : float = 0.0
var speed : int = 200
var magnet
var is_invulnerable : bool = false


func _physics_process(delta : float):

	var distance = magnet.position - position
	var direction = (distance).normalized()

	velocity = direction * speed

	if timer > 0.0 and is_invulnerable: timer -= delta
	if timer <= 0.0:
		is_invulnerable = false
		#if %AnimationPlayer.is_playing()
		%AnimationPlayer.stop()
		%Sprite2D.modulate = Color(1, 1, 1, 1)
		
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if timer <= 0.0:
			hit.emit()
			timer = 5.0
			is_invulnerable = true
			%AnimationPlayer.play("invulnerable")
	
	look_at(magnet.position)
	#print(rotation_degrees)

