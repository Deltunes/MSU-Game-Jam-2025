extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stream = load("res://Audio/GameJamFightTheme.wav")
	autoplay = true
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
