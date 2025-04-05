extends Node2D

var rng = RandomNumberGenerator.new()
var enemyScene = preload("res://scenes/enemy.tscn")
var enemyNumOnStart = 10
var enemyNumGradual = 70
var enemyScale
var randomX
var randomY
var playerMarginX = 640
var playerMarginY = 360
var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in enemyNumOnStart:
		instantiate_enemy()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (i < enemyNumGradual):
		if ($Timer.time_left <= 0):
			instantiate_enemy()
			$Timer.start()
			i += 1
		else:
			pass
			
func instantiate_enemy():
	var instance = enemyScene.instantiate()
	var randomX = rng.randf_range(-800.0, 800.0)
	var randomY = rng.randf_range(-500.0, 500.0)
	while ((randomX >= $Player.position.x - playerMarginX && randomX <= $Player.position.x + playerMarginX) && (randomY >= $Player.position.y - playerMarginY && randomY <= $Player.position.y + playerMarginY)):
		randomX = rng.randf_range(-800.0, 800.0)
		randomY = rng.randf_range(-500.0, 500.0)
			
	instance.position.x = randomX
	instance.position.y = randomY
	instance.speed = 50
			
	add_child(instance)
