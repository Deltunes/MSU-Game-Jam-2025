extends CharacterBody2D

@export var hitSpeed = 500
@export var goldKills: int
@export var speed = 150

var rng = RandomNumberGenerator.new()
var hitable = true
var direction = Vector2(0, 0)
var health = 300
var otherHitSpeed
var prevGoldKills

func _ready():
	var swordHitbox = $"CharacterSprite/Weapon Controller/Sword/Hitbox"
	swordHitbox.damage = 10
	goldKills = 0
	prevGoldKills = 0

func _physics_process(_delta):
	if (goldKills == prevGoldKills + 1):
		$"CharacterSprite/Weapon Controller/Sword".scale.x += 1
		$"CharacterSprite/Weapon Controller/Sword".scale.y += 1
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
		var randomPitch = rng.randf_range(0.8, 1.2)
		$SwordSlashSound.pitch_scale = randomPitch
		$SwordSlashSound.play()
		$WeaponAnimation.play("swordSwipe")
	
	# Walking
	walkingAnim()
	
	prevGoldKills = goldKills
	
	move_and_slide()
	
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
