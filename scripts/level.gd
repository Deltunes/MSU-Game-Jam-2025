extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var enemyScene = preload("res://scenes/enemy.tscn")
	var enemyNum = 3
	for i in enemyNum:
		var instance = enemyScene.instantiate()
		instance.position.x = i * 100
		instance.position.y = -i * 100
		instance.speed = i * 20
		add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
