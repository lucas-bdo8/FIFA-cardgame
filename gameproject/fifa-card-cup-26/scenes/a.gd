extends AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("A"):
		$"../A".play("Pressed")
		
	
	if Input.is_action_just_released("A"):
		$"../A".play("Idle")
