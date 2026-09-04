extends Control

@export var CardViewports: Array[SubViewport] = []
@export var CardsButtons: Array[TextureButton] = []

var PlayersID: Array[int] = []

var ATA: Array = []
var MEI: Array = []
var DEF: Array = []
var GOL: Array = []

var ATAC: Array[TextureButton] = []
var MEIC: Array[TextureButton] = []
var DEFC: Array[TextureButton] = []
var GOLC: Array[TextureButton] = []

var Adding_to: int = 0

var highlightedPOS := "ATA"

var PlayerSelected: int

func _ready() -> void:
	print("========== PLAYER ORGANIZER ==========")
	print("_ready() executou!")
	print("======================================")
	OrganizarJogadoresHome()


func OrganizarJogadoresHome() -> void:
	
	ATA.clear()
	MEI.clear()
	DEF.clear()
	GOL.clear()

	ATAC.clear()
	MEIC.clear()
	DEFC.clear()
	GOLC.clear()

	if GlobalHomeTeam.Players.is_empty():
		push_error(
			"[PLAYER ORGANIZER][ERRO] GlobalHomeTeam.Players está vazio!"
		)
		return

	if CardsButtons.size() < 26:
		push_error(
			"[PLAYER ORGANIZER][ERRO] CardsButtons possui apenas ",
			CardsButtons.size(),
			" botões. Esperado: 26."
		)
		return
	
	var player_index := 0

	for player_id in GlobalHomeTeam.Players:

		var player: Dictionary = GlobalHomeTeam.Players[player_id]

		var pos: String = str(
			player.get("POS", "")
		)

		match pos:

			"ATA":
				ATA.append(player_id)

			"MEI":
				MEI.append(player_id)

			"DEF":
				DEF.append(player_id)

			"GOL":
				GOL.append(player_id)

			_:
				push_warning(
					"[PLAYER ORGANIZER][AVISO] " +
					"Posição desconhecida para o jogador " +
					str(player_id) +
					": " +
					pos
				)

	# Agora que temos o tamanho de cada posição,
	# distribuímos os jogadores nos CardsButtons.
	
	var card_index := 0
	print("========== DEBUG ==========")
	print("Players: ", GlobalHomeTeam.Players.size())
	print("ATA size: ", ATA.size())
	print("MEI size: ", MEI.size())
	print("DEF size: ", DEF.size())
	print("GOL size: ", GOL.size())
	print("============================")


	# =========================
	# ATA
	# =========================

	for player_id in ATA:

		var card := CardsButtons[card_index]

		card.visible = true

		CardViewports[player_index].get_node("Player").setupPlayer(
			int(player_id)
		)

		card.texture_normal = CardViewports[player_index].get_texture()

		card.pressed.connect(
			_on_card_pressed.bind(int(player_id), card)
		)

		ATAC.append(card)

		player_index += 1
		card_index += 1
		print("teste:"+ str(ATA[0]))
		print("teste:"+ str(ATAC[0]))


	# =========================
	# MEI
	# =========================

	for player_id in MEI:

		var card := CardsButtons[card_index]

		card.visible = false

		CardViewports[player_index].get_node("Player").setupPlayer(
			int(player_id)
		)

		card.texture_normal = CardViewports[player_index].get_texture()

		card.pressed.connect(
			_on_card_pressed.bind(int(player_id), card)
		)

		MEIC.append(card)

		player_index += 1
		card_index += 1


	# =========================
	# DEF
	# =========================

	for player_id in DEF:

		var card := CardsButtons[card_index]

		card.visible = false

		CardViewports[player_index].get_node("Player").setupPlayer(
			int(player_id)
		)

		card.texture_normal = CardViewports[player_index].get_texture()

		card.pressed.connect(
			_on_card_pressed.bind(int(player_id), card)
		)

		DEFC.append(card)

		player_index += 1
		card_index += 1


	# =========================
	# GOL
	# =========================

	for player_id in GOL:

		var card := CardsButtons[card_index]

		card.visible = false

		CardViewports[player_index].get_node("Player").setupPlayer(
			int(player_id)
		)

		card.texture_normal = CardViewports[player_index].get_texture()

		card.pressed.connect(
			_on_card_pressed.bind(int(player_id), card)
		)

		GOLC.append(card)

		player_index += 1
		card_index += 1


	# Configura o Focus somente depois
	# que todos os grupos estiverem completos.

	ConfigurarFocusButtons(ATAC)
	ConfigurarFocusButtons(MEIC)
	ConfigurarFocusButtons(DEFC)
	ConfigurarFocusButtons(GOLC)


func _process(delta: float) -> void:

	match highlightedPOS:

		"ATA":
			for card in ATAC:
				card.visible = true

			for card in MEIC:
				card.visible = false

			for card in DEFC:
				card.visible = false

			for card in GOLC:
				card.visible = false


		"MEI":
			for card in ATAC:
				card.visible = false

			for card in MEIC:
				card.visible = true

			for card in DEFC:
				card.visible = false

			for card in GOLC:
				card.visible = false


		"DEF":
			for card in ATAC:
				card.visible = false

			for card in MEIC:
				card.visible = false

			for card in DEFC:
				card.visible = true

			for card in GOLC:
				card.visible = false


		"GOL":
			for card in ATAC:
				card.visible = false

			for card in MEIC:
				card.visible = false

			for card in DEFC:
				card.visible = false

			for card in GOLC:
				card.visible = true


func OnHighlightedPosChange(Pos: int):

	match Pos:

		1:
			highlightedPOS = "ATA"

			if ATAC.size() > 0:
				ATAC[0].grab_focus()


		2:
			highlightedPOS = "MEI"

			if MEIC.size() > 0:
				MEIC[0].grab_focus()


		3:
			highlightedPOS = "DEF"

			if DEFC.size() > 0:
				DEFC[0].grab_focus()


		4:
			highlightedPOS = "GOL"

			if GOLC.size() > 0:
				GOLC[0].grab_focus()


func _on_card_pressed(
	player_id: int,
	card: TextureButton
) -> void:

	print("Carta pressionada!")
	print("ID do jogador: ", player_id)

	$SelectedCard.texture = card.texture_normal
	#$SelectedCard/PlayerName.text = GlobalHomeTeam.
	#alterar $SelectedCard/PlayerName para nome do jogador baseado no seu ID
	match Adding_to:
		4:
			GlobalVariables.Formation[4] = player_id
			$"../Scene1/Add4".texture_normal = card.texture_normal
		3:
			GlobalVariables.Formation[3] = player_id
			$"../Scene1/Add3".texture_normal = card.texture_normal
		2:
			GlobalVariables.Formation[2] = player_id
			$"../Scene1/Add2".texture_normal = card.texture_normal
		1:
			GlobalVariables.Formation[1] = player_id
			$"../Scene1/Add1".texture_normal = card.texture_normal
		5:
			GlobalVariables.Formation[0] = player_id
			$"../Scene1/AddGL".texture_normal = card.texture_normal

func ConfigurarFocusButtons(
	cards: Array[TextureButton]
) -> void:

	for i in range(cards.size()):

		var card := cards[i]

		card.focus_mode = Control.FOCUS_ALL

		# Esquerda
		if i > 0:
			card.focus_neighbor_left = cards[i - 1].get_path()
		else:
			card.focus_neighbor_left = NodePath()

		# Direita
		if i < cards.size() - 1:
			card.focus_neighbor_right = cards[i + 1].get_path()
		else:
			card.focus_neighbor_right = NodePath()

		# Bloqueia navegação vertical
		card.focus_neighbor_top = card.get_path()
		card.focus_neighbor_bottom = card.get_path()


func _on_add_4_pressed() -> void:
	Adding_to = 4
	visible = true
	$"PosFlag".grab_focus()
	$"../..".PosFlag = 1
	OnHighlightedPosChange(1)
	$PosFlag.texture_normal = load("res://Resources/UI/Game/ATAflag.png")
	$PosFlag.texture_focused = load("res://Resources/UI/Game/ATAflag-hover.png")
	$PosFlag.texture_hover = load("res://Resources/UI/Game/ATAflag-hover.png")
	pass # Replace with function body.


func _on_add_3_pressed() -> void:
	Adding_to = 3
	visible = true
	$"PosFlag".grab_focus()
	$"../..".PosFlag = 2
	OnHighlightedPosChange(2)
	$PosFlag.texture_normal = load("res://Resources/UI/Game/MEIflag.png")
	$PosFlag.texture_focused = load("res://Resources/UI/Game/MEIflag-hover.png")
	$PosFlag.texture_hover = load("res://Resources/UI/Game/MEIflag-hover.png")
	pass # Replace with function body.

func _on_add_2_pressed() -> void:
	Adding_to = 2
	visible = true
	$"PosFlag".grab_focus()
	$"../..".PosFlag = 2
	OnHighlightedPosChange(2)
	$PosFlag.texture_normal = load("res://Resources/UI/Game/MEIflag.png")
	$PosFlag.texture_focused = load("res://Resources/UI/Game/MEIflag-hover.png")
	$PosFlag.texture_hover = load("res://Resources/UI/Game/MEIflag-hover.png")
	pass # Replace with function body.

func _on_add_1_pressed() -> void:
	Adding_to = 1
	visible = true
	$"PosFlag".grab_focus()
	$"../..".PosFlag = 3
	OnHighlightedPosChange(3)
	$PosFlag.texture_normal = load("res://Resources/UI/Game/DEFflag.png")
	$PosFlag.texture_focused = load("res://Resources/UI/Game/DEFflag-hover.png")
	$PosFlag.texture_hover = load("res://Resources/UI/Game/DEFflag-hover.png")
	pass # Replace with function body.

func _on_add_gl_pressed() -> void:
	Adding_to = 5
	visible = true
	$"PosFlag".grab_focus()
	$"../..".PosFlag = 4
	OnHighlightedPosChange(4)
	$PosFlag.texture_normal = load("res://Resources/UI/Game/GOLflag.png")
	$PosFlag.texture_focused = load("res://Resources/UI/Game/GOLflag-hover.png")
	$PosFlag.texture_hover = load("res://Resources/UI/Game/GOLflag-hover.png")
	pass # Replace with function body.
