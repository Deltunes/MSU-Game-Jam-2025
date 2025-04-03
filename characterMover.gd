extends CharacterBody2D

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	var speed = 250
	velocity = direction * speed
	
	if (Input.is_action_just_pressed("leftClick")):
		$WeaponAnimation.play("swordSwipe")
		
	if (Input.is_action_just_pressed("spaceBar")):
		$PlayerAnimation.play("jump")
	
	if move_and_slide():
		resolve_collisions()
		
func resolve_collisions():
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider() as RigidBody2D
		if body:
			body.apply_force(-500 * collision.get_normal())
