extends AnimatedSprite2D

@export_enum("Gameplay", "Squad Setup") var Scene = ""

func _process(delta):
	if Input.is_action_just_pressed("Y"):
		$"../Y".play("Pressed")
		
		match Scene:
			"Squad Setup":
				GlobalVariables.CamState = "Squad Setup Transition"
				GlobalSignals.SST.emit()
				%"Squad Setup".visible = false
				Scene = ""
	
	if Input.is_action_just_released("Y"):
		$"../Y".play("Idle")
