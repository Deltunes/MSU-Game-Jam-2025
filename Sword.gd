extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mousePos = $"../CharacterSprite".get_local_mouse_position()
	var mouseAng = mousePos.angle() / PI * 180
	$".".rotation_degrees = mouseAng;
	if (mouseAng < -30 || mouseAng > 120):
		$".".z_index = -1
	elif (mouseAng >= -30 && mouseAng <= 120):
		$".".z_index = 1
	print(mouseAng)
	print($".".z_index)
