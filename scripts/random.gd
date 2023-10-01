class_name Random
extends Node


static func integer_between(a : int, b : int) -> int:
	var random := RandomNumberGenerator.new()
	random.randomize()
	var result = random.randi_range(a, b)
	return result


static func float_between(a : float, b : float) -> float:
	var random := RandomNumberGenerator.new()
	random.randomize()
	var result = random.randf_range(a, b)
	return result
