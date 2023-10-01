extends Label


signal second(value)


var last_value : int = 0
var value : float = 0.0:
	set(new_value):
		value = new_value
		text = "TIME: %ss" % int(value)


func _process(delta):
	value += delta
	var current_value : int = floor(value)
	if current_value > last_value:
		last_value = current_value
		second.emit(current_value)

