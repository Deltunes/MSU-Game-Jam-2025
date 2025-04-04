extends CharacterBody2D

var inAir = false;

func _physics_process(_delta):
	# Player Movement
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	var speed = 100
	velocity = direction * speed
	
	# Weapon Attack
	if (Input.is_action_just_pressed("leftClick")):
		$WeaponAnimation.play("swordSwipe")
	
	# Is Player in Air?
	if ($PlayerAnimation.current_animation == "jump"):
		inAir = true
	else:
		inAir = false
	
	# Jump
	if (Input.is_action_just_pressed("spaceBar")):
		$PlayerAnimation.play("jump")
	
	elif (direction.x != 0 && inAir == false):
		if(!$PlayerAnimation.is_playing()):
			$PlayerAnimation.play("forwardWalk")
	
	if move_and_slide():
		resolve_collisions()
		
func resolve_collisions():
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider() as RigidBody2D
		if body:
			body.apply_force(-500 * collision.get_normal())
