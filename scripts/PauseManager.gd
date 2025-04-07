extends Node

var endHasBegun = false
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$StartTimer.start()
	$"../Player/PlayerAnimation".play("startFall")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ($StartTimer.is_stopped() && endHasBegun == false):
		get_tree().paused = false
	
	if($EndTimer.is_stopped() && endHasBegun == true):
		get_tree().reload_current_scene()
		
	if ($"../Enemies".get_child_count() <= 0 && endHasBegun == false):
		get_tree().paused = true
		$EndTimer.start()
		endHasBegun = true
		if ($"../Player/PlayerAnimation".current_animation != "endRise"):
			$"../Player/PlayerAnimation".play("endRise")

