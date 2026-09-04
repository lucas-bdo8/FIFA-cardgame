extends AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("X"):
		$"../X".play("Pressed")
	
	if Input.is_action_just_released("X"):
		$"../X".play("Idle")
