class_name Asteroid extends CharacterBody2D#RigidBody2D


signal hit()

const INVULNERABLE_TIME = 0.5


var health : int = 10
#var direction = Vector2(1, 1).normalized()
var timer : float = 0.0
var speed : float = 200.0
var _remainder : Vector2
var rubble_container


var _rotation : float

func _ready():
	get_random_rotation()
	get_random_velocity()


func _physics_process(delta):
	rotation += _rotation * delta
	var collision = move_and_collide(velocity * delta + velocity.normalized() * _remainder )
	_remainder = Vector2.ZERO
	
	timer -= delta
	
	if collision:
		var direction = velocity.normalized()
		_remainder = collision.get_remainder()
		velocity = direction.bounce(collision.get_normal()) * speed
		#%AnimationPlayer.play("rubble")
		
		if timer <= 0.0:
			health -= 1
			scale = scale / 1.1
			hit.emit()
			
			var rubble = load("res://scenes/game/rubble/rubble.tscn").instantiate()
			rubble.position = collision.get_position()
			rubble.scale = scale
			rubble_container.add_child(rubble)
			
			#print(scale)
			#scale *= Vector2(0.9, 0.9)
			if health == 0:
				
			#if scale <= Vector2(0.1, 0.1):
				queue_free()
				return
			timer = INVULNERABLE_TIME
			get_random_rotation()


func get_random_rotation():
	var random = RandomNumberGenerator.new()
	random.randomize()
	_rotation = random.randf_range(-5.0, 5.0)


func get_random_velocity():
	var random = RandomNumberGenerator.new()
	random.randomize()
	velocity.x = random.randf_range(0, 1.0) * speed
	velocity.y = random.randf_range(0, 1.0) * speed
	
