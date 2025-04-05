extends Node2D

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	var enemyScene = preload("res://scenes/enemy.tscn")
	var enemyNum = 20
	var enemyScale
	var randomX
	var randomY
	var playerMargin = 300
	for i in enemyNum:
		var instance = enemyScene.instantiate()
		
		randomX = rng.randf_range(-500.0, 500.0)
		randomY = rng.randf_range(-500.0, 500.0)
		while ((randomX >= $Player.position.x - playerMargin && randomX <= $Player.position.x + playerMargin) && (randomY >= $Player.position.y - playerMargin && randomY <= $Player.position.y + playerMargin)):
			randomX = rng.randf_range(-500.0, 500.0)
			randomY = rng.randf_range(-500.0, 500.0)
		
		instance.position.x = randomX
		instance.position.y = randomY
		instance.speed = 50
		add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
