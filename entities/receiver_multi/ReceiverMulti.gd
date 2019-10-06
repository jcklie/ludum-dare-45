extends StaticBody2D

export(int) var max_capacity = 2

var inputs = {}

func check_error():
	$Error.visible = !(inputs.size() <= max_capacity)
	

