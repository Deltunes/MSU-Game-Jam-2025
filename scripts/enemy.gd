extends CharacterBody2D

@export var speed = 100
@export var hitSpeed = 500
@export var health = 50
@export var hitDampener: float = 1.0

var rng = RandomNumberGenerator.new()
var direction = Vector2(0, 0)
var hitable = true
var spriteText: String
var otherHitSpeed
var player
var mousePos

func _ready():
	player = $"../../Player"
	$Hitbox.damage = 10
	var goldChance = rng.randi_range(1, 8)
	if (goldChance == 1):
		$Sprite2D2.texture = load("res://images/ladybugAnimGold.png")
		self.scale *= 0.8
		spriteText = "gold"
	else:
		$Sprite2D2.texture = load("res://images/ladybugAnim.png")
		spriteText = "red"

func _physics_process(_delta):
	if ($Timer.is_stopped()):
		if (health <= 0):
			if (spriteText == "gold"):
				player.goldKills += 1
			self.queue_free()
		hitable = true
		if ($AnimationPlayer.current_animation != "walk"):
			$AnimationPlayer.stop()
			$AnimationPlayer.play("walk")
		direction = Vector2(player.position.x - $".".position.x, player.position.y - $".".position.y).normalized()
		velocity = direction * speed
	else:
		hitable = false
		velocity = direction * otherHitSpeed * hitDampener
		otherHitSpeed *= 0.95
		
	move_and_slide()

func _on_hurtbox_area_entered(hitbox):
	if (hitable == true):
		direction = player.get_local_mouse_position().normalized()
		otherHitSpeed = player.hitSpeed 
		var damage = hitbox.damage
		self.health -= damage
		
		$Timer.start()
		$AnimationPlayer.play("hurt")
