extends CharacterBody2D

@export var hitSpeed = 500

var hitable = true
var direction = Vector2(0, 0)
var speed = 100
var health = 100
var otherHitSpeed

func _ready():
	var swordHitbox = $"CharacterSprite/Weapon Controller/Sword/Hitbox"
	swordHitbox.damage = 10

func _physics_process(_delta):
	# Player Movement
	if ($HitTimer.is_stopped()):
		hitable = true
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		velocity = direction * speed
	else:
		hitable = false
		velocity = direction * otherHitSpeed
		otherHitSpeed *= 0.9
		

	# Weapon Attack
	if (Input.is_action_pressed("leftClick") && !$WeaponAnimation.is_playing()):
		$WeaponAnimation.play("swordSwipe")
	
	# Walking
	walkingAnim()
	
	if move_and_slide():
		resolve_collisions()
	
func resolve_collisions():
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider() as RigidBody2D
		if body:
			body.apply_force(-500 * collision.get_normal())
			
func _on_hurtbox_area_entered(hitbox):
	if (hitable == true):
		var damage = hitbox.damage
		self.health -= damage
		if (health <= 0):
			get_tree().reload_current_scene()
		direction = Vector2($".".position.x - hitbox.get_parent().position.x, $".".position.y - hitbox.get_parent().position.y).normalized()
		otherHitSpeed = hitbox.get_parent().hitSpeed
		$HitTimer.start()
		print("Hit! Health: ", self.health)

func walkingAnim():
	var mouseAng = $".".get_local_mouse_position().angle() / PI * 180
	
	if (mouseAng >= 45 && mouseAng <= 135 && !$PlayerAnimation.current_animation == "forwardWalk"):
		$PlayerAnimation.stop()
		$PlayerAnimation.play("forwardWalk")
	elif (mouseAng < -45 && mouseAng > -135 && !$PlayerAnimation.current_animation == "backwardWalk"):
		$PlayerAnimation.stop()
		$PlayerAnimation.play("backwardWalk")
	elif (mouseAng < 45 && mouseAng > -45 && !$PlayerAnimation.current_animation == "rightWalk"):
		$PlayerAnimation.stop()
		$PlayerAnimation.play("rightWalk")
	elif ((mouseAng < -135 || mouseAng > 135) && !$PlayerAnimation.current_animation == "leftWalk"):
		$PlayerAnimation.stop()
		$PlayerAnimation.play("leftWalk")
