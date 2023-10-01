class_name Asteroid extends CharacterBody2D#RigidBody2D


signal hit()

const INVULNERABLE_TIME = 1.0


var health : int = 10
var timer : float = 0.0
var speed : float = 200.0
var _remainder : Vector2
var rubble_container
var is_invulnerable : bool = false


var _rotation : float

func _ready():
	speed = Random.float_between(200.0, 350.0)
	get_random_rotation()
	get_random_velocity()


func _physics_process(delta):
	rotation += _rotation * delta
	
	var collision = move_and_collide(velocity * delta + velocity.normalized() * _remainder )
	_remainder = Vector2.ZERO
	
	if is_invulnerable: timer -= delta
	if timer <= 0: is_invulnerable = false
	
	if collision:
		var direction = velocity.normalized()
		_remainder = collision.get_remainder()
		velocity = direction.bounce(collision.get_normal()) * speed
		if timer <= 0.0:
			health -= 1
			scale = scale / 1.1
			hit.emit()
			
			var rubble = load("res://scenes/game/rubble/rubble.tscn").instantiate()
			rubble.position = collision.get_position()
			rubble.rotation_degrees = Random.float_between(0.0, 360.0)
			rubble.scale = scale
			rubble_container.add_child(rubble)

			if health == 0:
				remove_asteroid()
				return
			timer = INVULNERABLE_TIME
			is_invulnerable = true
			get_random_rotation()


func get_random_rotation():
	var random = RandomNumberGenerator.new()
	random.randomize()
	_rotation = random.randf_range(-5.0, 5.0)


func get_random_velocity():
	var random = RandomNumberGenerator.new()
	random.randomize()
	velocity.x = random.randf_range(-1.0, 1.0) * speed
	velocity.y = random.randf_range(-1.0, 1.0) * speed


func remove_asteroid():
	for i in 3:
		var rubble = load("res://scenes/game/rubble/rubble.tscn").instantiate()
		rubble.position = position
		rubble.rotation_degrees = Random.float_between(0.0, 360.0)
		rubble_container.add_child(rubble)
	queue_free()
