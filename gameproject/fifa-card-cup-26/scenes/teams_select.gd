extends Node

var CurrentTeamEditing = 1

var HomeTeam = 1 
var AwayTeam = 2

var HomeRandomPlayer
var AwayRandomPlayer

func _process(delta):
	if Input.is_action_just_pressed("Left"):
		match CurrentTeamEditing:
			1:
				HomeTeam -= 1
				if HomeTeam <1:
					HomeTeam = 48
				_ChangeHome()
				
			2:
				AwayTeam -= 1
				if AwayTeam <1:
					AwayTeam = 48
				_ChangeAway()
	if Input.is_action_just_pressed("Right"):
		match CurrentTeamEditing:
			1:
				HomeTeam += 1
				if HomeTeam >48:
					HomeTeam = 1
				_ChangeHome()
				
			2:
				AwayTeam += 1
				if AwayTeam >48:
					AwayTeam = 1
				_ChangeAway()
	
	if Input.is_action_just_pressed("B"):
		if CurrentTeamEditing == 2:
			CurrentTeamEditing = 1
		else:
			get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
	
	if Input.is_action_just_pressed("A"):
		if CurrentTeamEditing == 1:
			GlobalVariables.HomeTeam = HomeTeam
			CurrentTeamEditing = 2
		else:
			GlobalVariables.AwayTeam = AwayTeam
			DATA.SetupHomeTeam(HomeTeam)
			DATA.SetupAwayTeam(AwayTeam)
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			
		

func _ChangeHome():
	$UI/TeamHome.text = DATA.COUNTRIES[HomeTeam-1]
	$UI/HomeFlag.texture = load("res://DATA/selecoes/"+DATA.COUNTRIES[HomeTeam-1]+"/Resources/Flag.webp")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	HomeRandomPlayer = rng.randi_range((HomeTeam-1)*26, (HomeTeam-1)*26+26)
	$Ambiente3D/HomeCard.setup_player(HomeRandomPlayer)
	$Ambiente3D/HomeMini.setupPlayer(HomeRandomPlayer)
	print(str(HomeRandomPlayer))

func _ChangeAway():
	$UI/TeamAway.text = DATA.COUNTRIES[AwayTeam-1]
	$UI/AwayFlag.texture = load("res://DATA/selecoes/"+DATA.COUNTRIES[AwayTeam-1]+"/Resources/Flag.webp")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	AwayRandomPlayer = rng.randi_range((AwayTeam-1)*26, (AwayTeam-1)*26+26)
	$Ambiente3D/AwayCard.setup_player(AwayRandomPlayer)
	$Ambiente3D/AwayMini.setupPlayer(AwayRandomPlayer)
