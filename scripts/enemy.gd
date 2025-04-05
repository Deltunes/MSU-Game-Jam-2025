extends CharacterBody2D

@export var speed = 200
@export var hitSpeed = 500

var direction = Vector2(0, 0)
var otherHitSpeed
var health = 50
var hitable = true
var player
var mousePos

func _ready():
	player = $"../Player"
	$Hitbox.damage = 10

func _physics_process(_delta):
	if ($Timer.is_stopped()):
		if (health <= 0):
			self.queue_free()
		hitable = true
		$AnimationPlayer.play("RESET")
		direction = Vector2(player.position.x - $".".position.x, player.position.y - $".".position.y).normalized()
		velocity = direction * speed
	else:
		hitable = false
		velocity = direction * otherHitSpeed
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
