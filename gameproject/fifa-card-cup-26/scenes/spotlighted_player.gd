extends AnimatedSprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Right") and $"../UI/ModesUI".Mode < 5:
		play("Walk")
		await get_tree().create_timer(0.05).timeout
		$"../Ball/AnimationPlayer".play("Roll")
		global_position.x = global_position.x + 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x + 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x + 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x + 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x + 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x + 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x + 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x + 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x + 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x + 0.01
		await get_tree().create_timer(0.05).timeout
		play("Breath")
		$"../Ball/AnimationPlayer".play("RESET")

	if Input.is_action_just_pressed("Left") and $"../UI/ModesUI".Mode > 1:
		play("Walk")
		await get_tree().create_timer(0.05).timeout
		$"../Ball/AnimationPlayer".play_backwards("Roll")
		global_position.x = global_position.x - 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x - 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x - 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x - 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x - 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x - 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x - 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x - 0.01
		await get_tree().create_timer(0.05).timeout
		global_position.x = global_position.x - 0.01
		$"../Ball".global_position.x = $"../Ball".global_position.x - 0.01
		await get_tree().create_timer(0.05).timeout
		play("Breath")
		$"../Ball/AnimationPlayer".play("RESET")
