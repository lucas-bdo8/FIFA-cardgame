extends AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("B"):
		$"../B".play("Pressed")
	
	if Input.is_action_just_released("B"):
		$"../B".play("Idle")
