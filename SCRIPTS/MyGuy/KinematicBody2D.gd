extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -500
export (int) var gravity = 1500

var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		animate("running")

		$AnimatedSprite.flip_h = false
		$sword.flip_h = false
		$sword.position.x = $AnimatedSprite.position.x + 21

	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		animate("running")
		
		$AnimatedSprite.flip_h = true
		$sword.flip_h = true
		$sword.position.x = $AnimatedSprite.position.x - 21

	else:
		velocity.x = 0
		animate("idle")

	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	$swing.play("hitbox")
	$sword.set_frame(0)

func animate(string):
	if $AnimatedSprite.animation == "slice":
		if $AnimatedSprite.get_frame() == 4:
			$AnimatedSprite.animation =  string
	else:
		$AnimatedSprite.play(string)
	pass
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	if velocity.y < 0:
		animate("rising")
	elif velocity.y > 0:
		animate("falling")
