extends Node3D

@export var Player := 1
@export_enum("Common", "Rare", "Epic", "Legend") var Rarity := "Common"
@export var Name = ""
@export var Country = ""
@export var ATK := 0
@export var DRI := 0
@export var DEF := 0
@export var VEL := 0
@export var PAS := 0
@export var STA := 0
@export_enum("GOL", "DEF", "MEI", "ATA") var POS := ""



func _ready():
	var p = DATA.get_player(Player)

	if !p.is_empty():
		Name = p["Stats"]["Name"]
		Country = p["Country"]
		
		ATK = p["Stats"]["ATK"]
		DRI = p["Stats"]["DRI"]
		DEF = p["Stats"]["DEF"]
		VEL = p["Stats"]["VEL"]
		PAS = p["Stats"]["PAS"]
		STA = p["Stats"]["STA"]
		POS = p["Stats"]["POS"]
		
	var image_path = "res://DATA/selecoes/%s/Cartas/%s/%d.png" % [
			Country,
			Rarity,
			Player
		]
	$CARTA.texture = load(image_path)
	
func _process(delta):
	$HUD.animation = Rarity
	$INFO/Name.text = Name
	$INFO/ATK.text = "ATK " + str(ATK)
	$INFO/DRI.text = "DRI " + str(DRI)
	$INFO/DEF.text = "DEF " + str(DEF)
	$INFO/VEL.text = "VEL " + str(VEL)
	$INFO/PAS.text = "PAS " + str(PAS)
	$INFO/STA.text = "STA " + str(STA)
	


	
