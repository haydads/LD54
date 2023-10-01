extends Label


var value : int = 0:
	set(new_value):
		value = new_value
		text = "SCORE: %s" % value


func add(amount : int = 1):
	value += amount
