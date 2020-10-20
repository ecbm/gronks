extends KinematicBody2D

export (int) var speed = 50
var arse = true
var velocity = Vector2.ZERO
var dead = false

func _ready():
	velocity.x += speed
	velocity.y = 0
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.flip_h = true

func _physics_process(_delta):
	if dead == true:
		$CollisionShape2D.disabled = true
	else:
		if is_on_wall():
			if arse == false :
				$AnimatedSprite.flip_h = true
				velocity.x += speed
				arse = true
			else:
				$AnimatedSprite.flip_h = false
				velocity.x -= speed
				arse = false
		velocity = move_and_slide(velocity, Vector2.UP)

func _on_SwordArea_area_entered(_area):
		velocity.x = 0
		$AnimatedSprite.animation = "death"
		dead = true
