extends CharacterBody2D

@export var speed = 100
var health = 100
var hitSpeed = 500
var hitable = true

func _on_hurtbox_area_entered(hitbox):
	if (hitable == true):
		var damage = hitbox.damage
		self.health -= damage
		$AnimationPlayer.play("hurt")
		print("Enemy hit!")
		$Timer.start()
	
func _physics_process(_delta):
	if ($Timer.is_stopped()):
		hitable = true
		hitSpeed = 500
		var direction = Vector2($"../Player".position.x - $".".position.x, $"../Player".position.y - $".".position.y).normalized()
		velocity = direction * speed
	else:
		hitable = false
		var mousePos = $"../Player".get_local_mouse_position().normalized()
		velocity = mousePos * hitSpeed
		hitSpeed *= 0.9
	
	if (health <= 0):
		self.queue_free()
	
	move_and_slide()
