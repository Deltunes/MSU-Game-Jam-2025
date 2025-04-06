extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$StartTimer.start()
	$"../Player/PlayerAnimation".play("startFall")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ($StartTimer.is_stopped()):
		get_tree().paused = false

