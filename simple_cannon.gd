extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func convert_position(angle: float, down: bool) -> int:
	print(angle)
	var count  = 1
	if down:
		count = 5
	
	if angle <= 22.5:
		count = 1
	elif angle > 22.5 and angle < 67.5:
		count = count + 1
	elif angle >= 67.5 and angle <= 112.5:
		count = count + 2
	
	elif angle > 112.5 and angle < 157.5:
		count = count + 3
	elif angle >= 157.5:
		count = 5
	
	return count
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var position = get_global_mouse_position()
	var angle = global_position.angle_to_point(position)
	#print(angle, "  ", rad_to_deg(angle))
	#$".".rotation = angle
	match convert_position(abs(rad_to_deg(angle)), angle >= 0):
		1:
			$".".rotation_degrees = 0
		2:
			$".".rotation_degrees = -45
		3:
			$".".rotation_degrees = -90
		4:
			$".".rotation_degrees = -135
		5:
			$".".rotation_degrees = 180
		6:
			$".".rotation_degrees = 45
		7:
			$".".rotation_degrees = 90
		8:
			$".".rotation_degrees = 135
	
	pass
