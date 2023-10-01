class_name HealthPickup extends Area2D


signal collected()


func _ready():
	body_entered.connect(_on_body_entered.bind())


func _on_body_entered(body):
	if body is Player:
		collected.emit()
		queue_free()
