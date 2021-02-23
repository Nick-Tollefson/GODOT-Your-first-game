extends Area2D

export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO # The players movemnt vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):	
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):	
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):	
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Prevent player from leaving screen
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		# Activate animation while moving and flip sprite when moving left
		$AnimatedSprite.animation  = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		# Activate animation while moving and flip sprite when moving down
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
