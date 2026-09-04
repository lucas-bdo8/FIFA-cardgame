extends Camera3D

func _ready() -> void:
	GlobalSignals.StartIntro.connect(_StartIntro)
		
func _StartIntro():
	$"../Intro Scene/Team_H/4".setup_player(GlobalVariables.Formation[4])
	$"../Intro Scene/Team_H/3".setup_player(GlobalVariables.Formation[3])
	$"../Intro Scene/Team_H/2".setup_player(GlobalVariables.Formation[2])
	$"../Intro Scene/Team_H/1".setup_player(GlobalVariables.Formation[1])
	$"../Intro Scene/Team_H/GL".setup_player(GlobalVariables.Formation[0])
	$"../Gameplay/TEAMs/Team_H/Mini4".setupPlayer(GlobalVariables.Formation[4])
	$"../Gameplay/TEAMs/Team_H/4".setup_player(GlobalVariables.Formation[4])
	$"../Gameplay/TEAMs/Team_H/3".setup_player(GlobalVariables.Formation[3])
	$"../Gameplay/TEAMs/Team_H/2".setup_player(GlobalVariables.Formation[2])
	$"../Gameplay/TEAMs/Team_H/1".setup_player(GlobalVariables.Formation[1])
	$"../Gameplay/TEAMs/Team_H/GL".setup_player(GlobalVariables.Formation[0])
	$AnimationPlayer.play("Animations/Intro")
	await get_tree().create_timer(2.6).timeout
	GlobalVariables.CamState = "Gameplay"
	current = false
	$"../Gameplay/Gameplay Cam".current = true
	$"../Intro Scene".visible = false
	$"../Gameplay".visible = true
	$"../UI".get_node("Scoreboard").visible = true
	$"../UI".get_node("Gameplay").visible = true
	GlobalVariables.GameState = "Start"
	$"../Intro Scene".queue_free()
