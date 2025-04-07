extends Control

@export var gameStart: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect2.visible = false

func _on_start_clicked():
	get_tree().change_scene_to_file("res://scenes/levelMain.tscn")
	gameStart = true


func _on_credits_clicked():
	if ($TextureRect2.visible == true):
		$TextureRect2.visible = false
	elif ($TextureRect2.visible == false):
		$TextureRect2.visible = true
