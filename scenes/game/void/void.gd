extends Area2D


func _ready():
	body_entered.connect(_on_body_entered.bind())


func _on_body_entered(body):
	print(body)
	if body is Asteroid:
		body.queue_free()
