extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotateWeapon()
	
func rotateWeapon():
	var mousePos = $"..".get_local_mouse_position()
	var mouseAng = mousePos.angle() / PI * 180
	$".".rotation_degrees = mouseAng;
