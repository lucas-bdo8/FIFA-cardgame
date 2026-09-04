extends Control
var Mode = 1
signal Selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Selected.connect(select)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Right"):
		if Mode < 5:
			Mode += 1

	if Input.is_action_just_pressed("Left"):
		if Mode > 1:
			Mode -= 1
	
	match Mode:
		1: # WorldCup
			$WorldCup_Mode.global_position.x = 30
			$Draft_Mode.global_position.x = 180
			$VS_Mode.global_position.x = 280
			$Album_Mode.global_position.x = 380
			$Options_Mode.global_position.x = 480
			
			$WorldCup_Mode.global_position.y = 545
			$Draft_Mode.global_position.y = 565
			$VS_Mode.global_position.y = 565
			$Album_Mode.global_position.y = 565
			$Options_Mode.global_position.y = 565
			
			$WorldCup_Mode.scale.x = 2.5
			$WorldCup_Mode.scale.y = 2.0
			$Draft_Mode.scale.x = 2.0
			$Draft_Mode.scale.y = 1.6
			$VS_Mode.scale.x = 2.0
			$VS_Mode.scale.y = 1.6
			$Album_Mode.scale.x = 2.0
			$Album_Mode.scale.y = 1.6
			$Options_Mode.scale.x = 2.0
			$Options_Mode.scale.y = 1.6
			
			$WorldCup_Mode.z_index = 0
			$Draft_Mode.z_index = -1
			$VS_Mode.z_index = -2
			$Album_Mode.z_index = -3
			$Options_Mode.z_index = -4

		2: # Draft
			$WorldCup_Mode.global_position.x = -120
			$Draft_Mode.global_position.x = 30
			$VS_Mode.global_position.x = 180
			$Album_Mode.global_position.x = 280
			$Options_Mode.global_position.x = 380
			
			$WorldCup_Mode.global_position.y = 565
			$Draft_Mode.global_position.y = 545
			$VS_Mode.global_position.y = 565
			$Album_Mode.global_position.y = 565
			$Options_Mode.global_position.y = 565
			
			$WorldCup_Mode.scale.x = 2.0
			$WorldCup_Mode.scale.y = 1.6
			$Draft_Mode.scale.x = 2.5
			$Draft_Mode.scale.y = 2.0
			$VS_Mode.scale.x = 2.0
			$VS_Mode.scale.y = 1.6
			$Album_Mode.scale.x = 2.0
			$Album_Mode.scale.y = 1.6
			$Options_Mode.scale.x = 2.0
			$Options_Mode.scale.y = 1.6
			
			$WorldCup_Mode.z_index = -1
			$Draft_Mode.z_index = 0
			$VS_Mode.z_index = -1
			$Album_Mode.z_index = -2
			$Options_Mode.z_index = -3

		3: # VS
			$WorldCup_Mode.global_position.x = -220
			$Draft_Mode.global_position.x = -120
			$VS_Mode.global_position.x = 30
			$Album_Mode.global_position.x = 180
			$Options_Mode.global_position.x = 280
			
			$WorldCup_Mode.global_position.y = 565
			$Draft_Mode.global_position.y = 565
			$VS_Mode.global_position.y = 545
			$Album_Mode.global_position.y = 565
			$Options_Mode.global_position.y = 565
			
			$WorldCup_Mode.scale.x = 2.0
			$WorldCup_Mode.scale.y = 1.6
			$Draft_Mode.scale.x = 2.0
			$Draft_Mode.scale.y = 1.6
			$VS_Mode.scale.x = 2.5
			$VS_Mode.scale.y = 2.0
			$Album_Mode.scale.x = 2.0
			$Album_Mode.scale.y = 1.6
			$Options_Mode.scale.x = 2.0
			$Options_Mode.scale.y = 1.6
			
			$WorldCup_Mode.z_index = -2
			$Draft_Mode.z_index = -1
			$VS_Mode.z_index = 0
			$Album_Mode.z_index = -1
			$Options_Mode.z_index = -2

		4: # Album
			$WorldCup_Mode.global_position.x = -320
			$Draft_Mode.global_position.x = -220
			$VS_Mode.global_position.x = -120
			$Album_Mode.global_position.x = 30
			$Options_Mode.global_position.x = 180
			
			$WorldCup_Mode.global_position.y = 565
			$Draft_Mode.global_position.y = 565
			$VS_Mode.global_position.y = 565
			$Album_Mode.global_position.y = 545
			$Options_Mode.global_position.y = 565
			
			$WorldCup_Mode.scale.x = 2.0
			$WorldCup_Mode.scale.y = 1.6
			$Draft_Mode.scale.x = 2.0
			$Draft_Mode.scale.y = 1.6
			$VS_Mode.scale.x = 2.0
			$VS_Mode.scale.y = 1.6
			$Album_Mode.scale.x = 2.5
			$Album_Mode.scale.y = 2.0
			$Options_Mode.scale.x = 2.0
			$Options_Mode.scale.y = 1.6
			
			$WorldCup_Mode.z_index = -3
			$Draft_Mode.z_index = -2
			$VS_Mode.z_index = -1
			$Album_Mode.z_index = 0
			$Options_Mode.z_index = -1

		5: # Options
			$WorldCup_Mode.global_position.x = -420
			$Draft_Mode.global_position.x = -320
			$VS_Mode.global_position.x = -220
			$Album_Mode.global_position.x = -120
			$Options_Mode.global_position.x = 30
			
			$WorldCup_Mode.global_position.y = 565
			$Draft_Mode.global_position.y = 565
			$VS_Mode.global_position.y = 565
			$Album_Mode.global_position.y = 565
			$Options_Mode.global_position.y = 545
			
			$WorldCup_Mode.scale.x = 2.0
			$WorldCup_Mode.scale.y = 1.6
			$Draft_Mode.scale.x = 2.0
			$Draft_Mode.scale.y = 1.6
			$VS_Mode.scale.x = 2.0
			$VS_Mode.scale.y = 1.6
			$Album_Mode.scale.x = 2.0
			$Album_Mode.scale.y = 1.6
			$Options_Mode.scale.x = 2.5
			$Options_Mode.scale.y = 2.0
			
			$WorldCup_Mode.z_index = -4
			$Draft_Mode.z_index = -3
			$VS_Mode.z_index = -2
			$Album_Mode.z_index = -1
			$Options_Mode.z_index = 0

func select():
	match Mode:
		1:
			get_tree().change_scene_to_file("res://scenes/teams_select.tscn")
