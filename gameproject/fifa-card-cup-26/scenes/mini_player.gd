extends Node3D

@export var Player := 1
@export var Name = ""
var actionState = ""
var BallPoss := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setupPlayer(Player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.GameState == "Start":
		if BallPoss == true:
			if Input.is_action_just_pressed("A"):
				actionState = "Run"
				$PlayerAnim.play("Walk")
				$"../../../Gameplay Cam/AnimationPlayer".play("Ball rolling")
			if Input.is_action_just_released("A"):
				actionState = ""
				$PlayerAnim.play("Idle")
				$"../../../Gameplay Cam/AnimationPlayer".stop()
			if actionState == "Run":
				global_position.x += delta/4
				$"../../../Ball".global_position.x = global_position.x + 0.06
				
	pass

func setupPlayer(Player: int):
	var p = DATA.get_player(Player)
	
	if !p.is_empty():
		Name = p["Stats"]["Name"]
	
	$PlayerName.text = Name
	
