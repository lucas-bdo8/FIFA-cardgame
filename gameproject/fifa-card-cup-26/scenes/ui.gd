extends Control

@export var HomePlayer := 1
@export var AwayPlayer := 27

var adding_to : int

var PosFlag = 1

func _ready():
	
	HomePlayer = GlobalVariables.HomeTeam
	AwayPlayer = GlobalVariables.AwayTeam

	var home = DATA.get_player(HomePlayer)
	var away = DATA.get_player(AwayPlayer)

	if home.is_empty() or away.is_empty():
		return

	var homeCountry = home["Country"]
	var awayCountry = away["Country"]

	$Scoreboard/HomeFlag.texture = load("res://DATA/selecoes/"+GlobalHomeTeam.CountryName+"/Resources/Flag.webp")
	$Scoreboard/AwayFlag.texture = load("res://DATA/selecoes/"+GlobalAwayTeam.CountryName+"/Resources/Flag.webp")

	$Scoreboard/HomeColor.color = GlobalHomeTeam.Cor
	$Scoreboard/AwayColor.color = GlobalAwayTeam.Cor

	$Scoreboard/HomeTeamName.text = GlobalHomeTeam.Sigla
	$Scoreboard/AwayTeamName.text = GlobalAwayTeam.Sigla
	
	$"Squad Setup"/Scene1/HomeFlag.texture = load("res://DATA/selecoes/"+GlobalHomeTeam.CountryName+"/Resources/Flag.webp")
	$"Squad Setup"/Scene1/HomeTeamName.text = GlobalHomeTeam.Sigla
	print(GlobalHomeTeam.Sigla)
	
	$"Squad Setup/Scene1/Coach".texture = load("res://DATA/selecoes/"+GlobalHomeTeam.CountryName+"/Cartas/Coach.jpg")
	$"Squad Setup/Scene1/CoachName".text = GlobalHomeTeam.Tecnico[0]

	$"Squad Setup/Scene1/Add4".grab_focus()

func _on_card_hold_pressed() -> void:
	
	$"Squad Setup/Players_Select".visible = true
	pass # Replace with function body.
	
func _process(delta):
	
	if Input.is_action_just_pressed("B"):
		match $"Squad Setup/Players_Select".visible:
			true:
				$"Squad Setup/Players_Select".visible = false
				$"Squad Setup/Scene1/Add4".grab_focus()
		#$"Squad Setup/Players_Select".visible = true
	
	if Input.is_action_just_pressed("A"):
		if $"Squad Setup/Players_Select/PosFlag".has_focus():
			_on_pos_flag_pressed()

func _on_pos_flag_pressed() -> void:
	PosFlag += 1
	if PosFlag > 4:
		PosFlag = 1
	$"Squad Setup/Players_Select".OnHighlightedPosChange(PosFlag)
	match PosFlag:
		1:
			$"Squad Setup/Players_Select/PosFlag".texture_normal = load("res://Resources/UI/Game/ATAflag.png")
			$"Squad Setup/Players_Select/PosFlag".texture_focused = load("res://Resources/UI/Game/ATAflag-hover.png")
			$"Squad Setup/Players_Select/PosFlag".texture_hover = load("res://Resources/UI/Game/ATAflag-hover.png")
		
		

		2:
			$"Squad Setup/Players_Select/PosFlag".texture_normal = load("res://Resources/UI/Game/MEIflag.png")
			$"Squad Setup/Players_Select/PosFlag".texture_focused = load("res://Resources/UI/Game/MEIflag-hover.png")
			$"Squad Setup/Players_Select/PosFlag".texture_hover = load("res://Resources/UI/Game/MEIflag-hover.png")
			
		

		3:
			$"Squad Setup/Players_Select/PosFlag".texture_normal = load("res://Resources/UI/Game/DEFflag.png")
			$"Squad Setup/Players_Select/PosFlag".texture_focused = load("res://Resources/UI/Game/DEFflag-hover.png")
			$"Squad Setup/Players_Select/PosFlag".texture_hover = load("res://Resources/UI/Game/DEFflag-hover.png")
	

		4:
			
		
			#%"Card3/SubViewport/Player".setupPlayer()
			
			$"Squad Setup/Players_Select/PosFlag".texture_normal = load("res://Resources/UI/Game/GOLflag.png")
			$"Squad Setup/Players_Select/PosFlag".texture_focused = load("res://Resources/UI/Game/GOLflag-hover.png")
			$"Squad Setup/Players_Select/PosFlag".texture_hover = load("res://Resources/UI/Game/GOLflag-hover.png")
	pass # Replace with function body.
