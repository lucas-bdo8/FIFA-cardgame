extends Node3D

@export var Player := 1
@export_enum("Common", "Rare", "Epic", "Legend") var Rarity := "Common"

@export var Name := ""
@export var Country := ""

@export var ATK := 0
@export var DRI := 0
@export var DEF := 0
@export var VEL := 0
@export var PAS := 0
@export var STA := 0

@export_enum("GOL", "DEF", "MEI", "ATA") var POS := ""


func _ready() -> void:

	setup_player(Player)


# ============================================================
# CARREGA / ATUALIZA O JOGADOR
# ============================================================

func setup_player(player_id: int) -> void:

	Player = player_id

	var p = DATA.get_player(Player)


	# --------------------------------------------------------
	# Jogador inválido
	# --------------------------------------------------------

	if p.is_empty():

		clear_card()

		return


	# --------------------------------------------------------
	# Dados
	# --------------------------------------------------------

	Name = p["Stats"]["Name"]
	Country = p["Country"]

	ATK = p["Stats"]["ATK"]
	DRI = p["Stats"]["DRI"]
	DEF = p["Stats"]["DEF"]
	VEL = p["Stats"]["VEL"]
	PAS = p["Stats"]["PAS"]
	STA = p["Stats"]["STA"]
	POS = p["Stats"]["POS"]


	# --------------------------------------------------------
	# Caminho da carta
	# --------------------------------------------------------

	var image_path := "res://DATA/selecoes/%s/Cartas/%s/%d.png" % [
		Country,
		Rarity,
		Player
	]


	var card = get_node_or_null(
		"SubViewportContainer/SubViewport/Player"
	)


	# --------------------------------------------------------
	# Segurança
	# --------------------------------------------------------

	if card == null:

		push_error(
			"Player não encontrado dentro do SubViewport da carta."
		)

		return


	# --------------------------------------------------------
	# Atualiza visual
	# --------------------------------------------------------

	var carta = card.get_node_or_null("CARTA")

	if carta != null:
		carta.texture = load(image_path)
	else:
		push_error("CARTA não encontrada dentro de Player.")


	var home_flag = card.get_node_or_null("INFO/HomeFlag")

	if home_flag != null:
		home_flag.texture = DATA.get_flag(Country)


	var hud = card.get_node_or_null("HUD")

	if hud != null:
		hud.animation = Rarity


	var name_label = card.get_node_or_null("INFO/Name")

	if name_label != null:
		name_label.text = Name


	var atk_label = card.get_node_or_null("INFO/ATK")

	if atk_label != null:
		atk_label.text = "ATK " + str(ATK)


	var dri_label = card.get_node_or_null("INFO/DRI")

	if dri_label != null:
		dri_label.text = "DRI " + str(DRI)


	var def_label = card.get_node_or_null("INFO/DEF")

	if def_label != null:
		def_label.text = "DEF " + str(DEF)


	var vel_label = card.get_node_or_null("INFO/VEL")

	if vel_label != null:
		vel_label.text = "VEL " + str(VEL)


	var pas_label = card.get_node_or_null("INFO/PAS")

	if pas_label != null:
		pas_label.text = "PAS " + str(PAS)


	var sta_label = card.get_node_or_null("INFO/STA")

	if sta_label != null:
		sta_label.text = "STA " + str(STA)


	# Carta visível



# ============================================================
# ESCONDE A CARTA
# ============================================================

func clear_card() -> void:

	Player = 0

	Name = ""
	Country = ""

	ATK = 0
	DRI = 0
	DEF = 0
	VEL = 0
	PAS = 0
	STA = 0

	POS = ""

	visible = false
