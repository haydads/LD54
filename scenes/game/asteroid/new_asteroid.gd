extends RigidBody2D


func _ready():
	var test = Vector2(Random.float_between(-1.0, 1.0), Random.float_between(-1.0, 1.0)).normalized()
	
	add_constant_force(test)
#	apply_impulse(Vector2(Random.float_between(-500.0, 500.0), Random.float_between(-500.0, 500.0)))



func _physics_process(delta):
	##apply_force()
	
