# DATA.gd
extends Node

const PLAYERS_PER_TEAM := 26

const COUNTRIES = [
	"africa do sul",
	"alemanha",
	"argelia",
	"arabia saudita",
	"argentina",
	"australia",
	"austria",
	"belgica",
	"bosnia e herzegovina",
	"brasil",
	"cabo verde",
	"canada",
	"catar",
	"colombia",
	"coreia do sul",
	"costa do marfim",
	"croacia",
	"curacao",
	"egito",
	"equador",
	"escocia",
	"espanha",
	"estados unidos",
	"franca",
	"gana",
	"haiti",
	"inglaterra",
	"ira",
	"iraque",
	"japao",
	"jordania",
	"marrocos",
	"mexico",
	"noruega",
	"nova zelandia",
	"holanda",
	"paraguai",
	"panama",
	"portugal",
	"republica democratica do congo",
	"senegal",
	"suecia",
	"suica",
	"tchequia",
	"tunisia",
	"turquia",
	"uruguai",
	"uzbequistao"
]

var cache := {}

func get_player(id:int) -> Dictionary:

	var team_index = (id - 1) / PLAYERS_PER_TEAM

	if team_index < 0 or team_index >= COUNTRIES.size():
		return {}

	var country = COUNTRIES[team_index]

	if !cache.has(country):

		var path := "res://DATA/selecoes/%s/%s.json" % [country, country]

		if !FileAccess.file_exists(path):
			push_error("Arquivo não encontrado: " + path)
			return {}

		var file := FileAccess.open(path, FileAccess.READ)

		if file == null:
			push_error("Não foi possível abrir: " + path)
			return {}

		var json := JSON.new()

		if json.parse(file.get_as_text()) != OK:
			push_error("Erro ao ler JSON: " + path)
			return {}

		cache[country] = json.data

	var data = cache[country]

	if !data.has("Players"):
		push_error("Campo 'Players' inexistente.")
		return {}

	var players = data["Players"]

	if !players.has(str(id)):
		push_error("Jogador %d não existe em %s." % [id, country])
		return {}

	var player = players[str(id)]
	player["Country"] = country

	return player

func get_team_by_player(id:int) -> Dictionary:
	var player = get_player(id)
	if player.is_empty():
		return {}

	return get_team(player["Country"])

func get_team(country:String) -> Dictionary:
	if cache.has(country):
		return cache[country]

	var path = "res://DATA/selecoes/%s/%s.json" % [country, country]

	if !FileAccess.file_exists(path):
		return {}

	var file = FileAccess.open(path, FileAccess.READ)

	var json = JSON.new()
	if json.parse(file.get_as_text()) != OK:
		return {}

	cache[country] = json.data

	return cache[country]
	
func get_flag(country:String) -> Texture2D:
	return load("res://DATA/selecoes/%s/Resources/Flag.jpg" % country)

func get_coachCard(country:String) -> Texture2D:
	return load("res://DATA/selecoes/%s/Cartas/Coach.jpg" % country)

func get_flag_by_player(id:int) -> Texture2D:
	var p = get_player(id)
	if p.is_empty():
		return null

	var path = "res://DATA/selecoes/%s/Resources/Flag.jpg" % p["Country"]
	return load(path)

func get_color(country:String) -> Color:
	var team = get_team(country)

	if team.is_empty():
		return Color.WHITE

	return Color.html(team["Cor"])

func get_coach_name(country:String) -> String:
	var team = get_team(country)
	var tecnico = team["Tecnico"]
	return tecnico["Name"]

func SetupHomeTeam(Team: int) -> void:

	print("")
	print("==================================================")
	print("[HOME TEAM] INICIANDO SetupHomeTeam()")
	print("==================================================")
	print("[HOME TEAM] Team recebido: ", Team)


	# ==================================================
	# 1. VALIDAR ID
	# ==================================================

	print("[HOME TEAM] Total de países: ", COUNTRIES.size())

	if Team < 1 or Team > COUNTRIES.size():

		push_error(
			"[HOME TEAM][ERRO] Team inválido: " + str(Team)
		)

		print(
			"[HOME TEAM][ERRO] O Team deve estar entre 1 e ",
			COUNTRIES.size()
		)

		return

	print("[HOME TEAM][OK] ID da seleção válido.")


	# ==================================================
	# 2. CONVERTER ID PARA ÍNDICE DO ARRAY
	# ==================================================

	var country_index: int = Team - 1

	print(
		"[HOME TEAM] Team ",
		Team,
		" corresponde ao índice ",
		country_index,
		" do COUNTRIES."
	)


	# ==================================================
	# 3. PEGAR NOME DO PAÍS
	# ==================================================

	var country_name: String = COUNTRIES[country_index]

	print("[HOME TEAM][OK] País encontrado: ", country_name)


	# ==================================================
	# 4. MONTAR CAMINHO
	# ==================================================

	var path: String = "res://DATA/selecoes/%s/%s.json" % [
		country_name,
		country_name
	]

	print("[HOME TEAM] Caminho esperado:")
	print("             ", path)


	# ==================================================
	# 5. VERIFICAR JSON
	# ==================================================

	if not FileAccess.file_exists(path):

		push_error(
			"[HOME TEAM][ERRO] JSON não encontrado!"
		)

		print(
			"[HOME TEAM][ERRO] Caminho procurado: ",
			path
		)

		print(
			"[HOME TEAM][ERRO] País: ",
			country_name
		)

		return

	print("[HOME TEAM][OK] JSON encontrado!")


	# ==================================================
	# 6. ABRIR JSON
	# ==================================================

	var file := FileAccess.open(path, FileAccess.READ)

	if file == null:

		push_error(
			"[HOME TEAM][ERRO] Não foi possível abrir o JSON!"
		)

		print("[HOME TEAM][ERRO] Caminho: ", path)

		return

	print("[HOME TEAM][OK] JSON aberto com sucesso.")


	# ==================================================
	# 7. LER JSON
	# ==================================================

	var json_text: String = file.get_as_text()

	file.close()

	print(
		"[HOME TEAM][OK] JSON lido. Tamanho: ",
		json_text.length(),
		" caracteres."
	)


	if json_text.is_empty():

		push_error(
			"[HOME TEAM][ERRO] JSON está vazio!"
		)

		return


	# ==================================================
	# 8. PARSE
	# ==================================================

	var json = JSON.parse_string(json_text)

	if json == null:

		push_error(
			"[HOME TEAM][ERRO] Não foi possível interpretar o JSON!"
		)

		print("[HOME TEAM][ERRO] Arquivo: ", path)

		return


	if not json is Dictionary:

		push_error(
			"[HOME TEAM][ERRO] JSON principal não é Dictionary!"
		)

		return

	print("[HOME TEAM][OK] JSON interpretado com sucesso.")


	# ==================================================
	# 9. LIMPAR GLOBAL
	# ==================================================

	print("[HOME TEAM] Limpando GlobalHomeTeam...")

	GlobalHomeTeam.CountryID = Team
	GlobalHomeTeam.CountryName = country_name
	GlobalHomeTeam.Sigla = ""
	GlobalHomeTeam.Cor = ""

	GlobalHomeTeam.Tecnico = ["", "", ""]

	GlobalHomeTeam.Players.clear()

	print("[HOME TEAM][OK] GlobalHomeTeam limpo.")


	# ==================================================
	# 10. DADOS DA SELEÇÃO
	# ==================================================

	print("")
	print("[HOME TEAM] ===== DADOS DA SELEÇÃO =====")


	if json.has("Sigla"):

		GlobalHomeTeam.Sigla = str(
			json["Sigla"]
		)

		print(
			"[HOME TEAM][OK] Sigla: ",
			GlobalHomeTeam.Sigla
		)

	else:

		push_error(
			"[HOME TEAM][ERRO] Campo 'Sigla' não encontrado!"
		)


	if json.has("Cor"):

		GlobalHomeTeam.Cor = str(
			json["Cor"]
		)

		print(
			"[HOME TEAM][OK] Cor: ",
			GlobalHomeTeam.Cor
		)

	else:

		push_error(
			"[HOME TEAM][ERRO] Campo 'Cor' não encontrado!"
		)


	print(
		"[HOME TEAM][OK] CountryID: ",
		GlobalHomeTeam.CountryID
	)

	print(
		"[HOME TEAM][OK] CountryName: ",
		GlobalHomeTeam.CountryName
	)


	# ==================================================
	# 11. TÉCNICO
	# ==================================================

	print("")
	print("[HOME TEAM] ===== TÉCNICO =====")


	if not json.has("Tecnico"):

		push_error(
			"[HOME TEAM][ERRO] Campo 'Tecnico' não encontrado!"
		)

	else:

		var tecnico_data = json["Tecnico"]


		if not tecnico_data is Dictionary:

			push_error(
				"[HOME TEAM][ERRO] 'Tecnico' não é Dictionary!"
			)

		else:

			var tecnico_name: String = str(
				tecnico_data.get("Name", "")
			)

			var bonus_type: String = str(
				tecnico_data.get("BonusType", "")
			)

			var bonus_value: int = int(
				tecnico_data.get("BonusValue", 0)
			)


			GlobalHomeTeam.Tecnico = [
				tecnico_name,
				bonus_type,
				bonus_value
			]


			print(
				"[HOME TEAM][OK] Técnico: ",
				tecnico_name
			)

			print(
				"[HOME TEAM][OK] BonusType: ",
				bonus_type
			)

			print(
				"[HOME TEAM][OK] BonusValue: ",
				bonus_value
			)


	# ==================================================
	# 12. JOGADORES
	# ==================================================

	print("")
	print("[HOME TEAM] ===== JOGADORES =====")


	if not json.has("Players"):

		push_error(
			"[HOME TEAM][ERRO] Campo 'Players' não encontrado!"
		)

		return


	var players_data = json["Players"]


	if not players_data is Dictionary:

		push_error(
			"[HOME TEAM][ERRO] 'Players' não é Dictionary!"
		)

		return


	print(
		"[HOME TEAM][OK] Players encontrado."
	)

	print(
		"[HOME TEAM] Quantidade no JSON: ",
		players_data.size()
	)


	var loaded_players: int = 0


	# ==================================================
	# 13. CARREGAR JOGADORES
	# ==================================================

	for player_key in players_data:

		print("")
		print("------------------------------------------")
		print(
			"[HOME TEAM] Processando slot: ",
			player_key
		)
		print("------------------------------------------")


		var player_data = players_data[player_key]


		if not player_data is Dictionary:

			push_error(
				"[HOME TEAM][ERRO] Slot " +
				str(player_key) +
				" não é Dictionary!"
			)

			continue


		# ------------------------------------------
		# CID
		# ------------------------------------------

		if not player_data.has("CID"):

			push_error(
				"[HOME TEAM][ERRO] Jogador " +
				str(player_key) +
				" não possui CID!"
			)

			continue


		var cid: int = int(
			player_data["CID"]
		)


		print(
			"[HOME TEAM][OK] CID: ",
			cid
		)


		# ------------------------------------------
		# NUMBER
		# ------------------------------------------

		var number: int = int(
			player_data.get("Number", 0)
		)


		# ------------------------------------------
		# FOOT
		# ------------------------------------------

		var foot: String = str(
			player_data.get("Foot", "")
		)


		# ------------------------------------------
		# STATS
		# ------------------------------------------

		if not player_data.has("Stats"):

			push_error(
				"[HOME TEAM][ERRO] Jogador CID " +
				str(cid) +
				" não possui Stats!"
			)

			continue


		var stats = player_data["Stats"]


		if not stats is Dictionary:

			push_error(
				"[HOME TEAM][ERRO] Stats do CID " +
				str(cid) +
				" não é Dictionary!"
			)

			continue


		# ------------------------------------------
		# NOME
		# ------------------------------------------

		var player_name: String = str(
			stats.get("Name", "")
		)


		# ------------------------------------------
		# POSIÇÃO
		# ------------------------------------------

		var pos: String = str(
			stats.get("POS", "")
		)


		# ------------------------------------------
		# STATS
		# ------------------------------------------

		var atk: int = int(
			stats.get("ATK", 0)
		)

		var dri: int = int(
			stats.get("DRI", 0)
		)

		var def: int = int(
			stats.get("DEF", 0)
		)

		var vel: int = int(
			stats.get("VEL", 0)
		)

		var pas: int = int(
			stats.get("PAS", 0)
		)

		var sta: int = int(
			stats.get("STA", 0)
		)


		# ==================================================
		# CRIAR PLAYER
		# ==================================================

		var player: Dictionary = {

			"CID": cid,

			"Name": player_name,

			"Number": number,

			"Foot": foot,

			"POS": pos,

			"ATK": atk,

			"DRI": dri,

			"DEF": def,

			"VEL": vel,

			"PAS": pas,

			"STA": sta
		}


		# ==================================================
		# SALVAR
		# ==================================================

		var slot: String = str(
			player_key
		)


		GlobalHomeTeam.Players[slot] = player

		loaded_players += 1

func SetupAwayTeam(Team: int) -> void:

	print("")
	print("==================================================")
	print("[AWAY TEAM] INICIANDO SetupAwayTeam()")
	print("==================================================")
	print("[AWAY TEAM] Team recebido: ", Team)


	# ==================================================
	# 1. VALIDAR ID DA SELEÇÃO
	# ==================================================

	print("[AWAY TEAM] Total de países: ", COUNTRIES.size())

	if Team < 1 or Team > COUNTRIES.size():

		push_error(
			"[AWAY TEAM][ERRO] Team inválido: " + str(Team)
		)

		print(
			"[AWAY TEAM][ERRO] O Team deve estar entre 1 e ",
			COUNTRIES.size()
		)

		return

	print("[AWAY TEAM][OK] ID da seleção válido.")


	# ==================================================
	# 2. CONVERTER ID PARA ÍNDICE DO ARRAY
	# ==================================================

	var country_index: int = Team - 1

	print(
		"[AWAY TEAM] Team ",
		Team,
		" corresponde ao índice ",
		country_index,
		" do COUNTRIES."
	)


	# ==================================================
	# 3. PEGAR NOME DO PAÍS
	# ==================================================

	var country_name: String = COUNTRIES[country_index]

	print(
		"[AWAY TEAM][OK] País encontrado: ",
		country_name
	)


	# ==================================================
	# 4. MONTAR CAMINHO DO JSON
	# ==================================================

	var path: String = "res://DATA/selecoes/%s/%s.json" % [
		country_name,
		country_name
	]

	print("[AWAY TEAM] Caminho esperado:")
	print("             ", path)


	# ==================================================
	# 5. VERIFICAR JSON
	# ==================================================

	if not FileAccess.file_exists(path):

		push_error(
			"[AWAY TEAM][ERRO] JSON não encontrado!"
		)

		print(
			"[AWAY TEAM][ERRO] Caminho procurado: ",
			path
		)

		print(
			"[AWAY TEAM][ERRO] País: ",
			country_name
		)

		return

	print("[AWAY TEAM][OK] JSON encontrado!")


	# ==================================================
	# 6. ABRIR JSON
	# ==================================================

	var file := FileAccess.open(path, FileAccess.READ)

	if file == null:

		push_error(
			"[AWAY TEAM][ERRO] Não foi possível abrir o JSON!"
		)

		print(
			"[AWAY TEAM][ERRO] Caminho: ",
			path
		)

		return

	print(
		"[AWAY TEAM][OK] JSON aberto com sucesso."
	)


	# ==================================================
	# 7. LER JSON
	# ==================================================

	var json_text: String = file.get_as_text()

	file.close()

	print(
		"[AWAY TEAM][OK] JSON lido. Tamanho: ",
		json_text.length(),
		" caracteres."
	)


	if json_text.is_empty():

		push_error(
			"[AWAY TEAM][ERRO] JSON está vazio!"
		)

		return


	# ==================================================
	# 8. PARSE DO JSON
	# ==================================================

	var json = JSON.parse_string(json_text)

	if json == null:

		push_error(
			"[AWAY TEAM][ERRO] Não foi possível interpretar o JSON!"
		)

		print(
			"[AWAY TEAM][ERRO] Arquivo: ",
			path
		)

		return


	if not json is Dictionary:

		push_error(
			"[AWAY TEAM][ERRO] JSON principal não é Dictionary!"
		)

		return

	print(
		"[AWAY TEAM][OK] JSON interpretado com sucesso."
	)


	# ==================================================
	# 9. LIMPAR GLOBAL AWAY
	# ==================================================

	print(
		"[AWAY TEAM] Limpando GlobalAwayTeam..."
	)

	GlobalAwayTeam.CountryID = Team
	GlobalAwayTeam.CountryName = country_name
	GlobalAwayTeam.Sigla = ""
	GlobalAwayTeam.Cor = ""

	GlobalAwayTeam.Tecnico = ["", "", ""]

	GlobalAwayTeam.Players.clear()

	print(
		"[AWAY TEAM][OK] GlobalAwayTeam limpo."
	)


	# ==================================================
	# 10. DADOS DA SELEÇÃO
	# ==================================================

	print("")
	print("[AWAY TEAM] ===== DADOS DA SELEÇÃO =====")


	if json.has("Sigla"):

		GlobalAwayTeam.Sigla = str(
			json["Sigla"]
		)

		print(
			"[AWAY TEAM][OK] Sigla: ",
			GlobalAwayTeam.Sigla
		)

	else:

		push_error(
			"[AWAY TEAM][ERRO] Campo 'Sigla' não encontrado!"
		)


	if json.has("Cor"):

		GlobalAwayTeam.Cor = str(
			json["Cor"]
		)

		print(
			"[AWAY TEAM][OK] Cor: ",
			GlobalAwayTeam.Cor
		)

	else:

		push_error(
			"[AWAY TEAM][ERRO] Campo 'Cor' não encontrado!"
		)


	print(
		"[AWAY TEAM][OK] CountryID: ",
		GlobalAwayTeam.CountryID
	)

	print(
		"[AWAY TEAM][OK] CountryName: ",
		GlobalAwayTeam.CountryName
	)


	# ==================================================
	# 11. TÉCNICO
	# ==================================================

	print("")
	print("[AWAY TEAM] ===== TÉCNICO =====")


	if not json.has("Tecnico"):

		push_error(
			"[AWAY TEAM][ERRO] Campo 'Tecnico' não encontrado!"
		)

	else:

		var tecnico_data = json["Tecnico"]


		if not tecnico_data is Dictionary:

			push_error(
				"[AWAY TEAM][ERRO] 'Tecnico' não é Dictionary!"
			)

		else:

			var tecnico_name: String = str(
				tecnico_data.get("Name", "")
			)

			var bonus_type: String = str(
				tecnico_data.get("BonusType", "")
			)

			var bonus_value: int = int(
				tecnico_data.get("BonusValue", 0)
			)


			GlobalAwayTeam.Tecnico = [
				tecnico_name,
				bonus_type,
				bonus_value
			]


			print(
				"[AWAY TEAM][OK] Técnico: ",
				tecnico_name
			)

			print(
				"[AWAY TEAM][OK] BonusType: ",
				bonus_type
			)

			print(
				"[AWAY TEAM][OK] BonusValue: ",
				bonus_value
			)


	# ==================================================
	# 12. JOGADORES
	# ==================================================

	print("")
	print("[AWAY TEAM] ===== JOGADORES =====")


	if not json.has("Players"):

		push_error(
			"[AWAY TEAM][ERRO] Campo 'Players' não encontrado!"
		)

		return


	var players_data = json["Players"]


	if not players_data is Dictionary:

		push_error(
			"[AWAY TEAM][ERRO] 'Players' não é Dictionary!"
		)

		return


	print(
		"[AWAY TEAM][OK] Players encontrado."
	)

	print(
		"[AWAY TEAM] Quantidade no JSON: ",
		players_data.size()
	)


	var loaded_players: int = 0


	# ==================================================
	# 13. CARREGAR JOGADORES
	# ==================================================

	for player_key in players_data:

		print("")
		print("------------------------------------------")
		print(
			"[AWAY TEAM] Processando slot: ",
			player_key
		)
		print("------------------------------------------")


		var player_data = players_data[player_key]


		if not player_data is Dictionary:

			push_error(
				"[AWAY TEAM][ERRO] Slot " +
				str(player_key) +
				" não é Dictionary!"
			)

			continue


		# ------------------------------------------
		# CID
		# ------------------------------------------

		if not player_data.has("CID"):

			push_error(
				"[AWAY TEAM][ERRO] Jogador " +
				str(player_key) +
				" não possui CID!"
			)

			continue


		var cid: int = int(
			player_data["CID"]
		)


		print(
			"[AWAY TEAM][OK] CID: ",
			cid
		)


		# ------------------------------------------
		# NUMBER
		# ------------------------------------------

		var number: int = int(
			player_data.get("Number", 0)
		)


		# ------------------------------------------
		# FOOT
		# ------------------------------------------

		var foot: String = str(
			player_data.get("Foot", "")
		)


		# ------------------------------------------
		# STATS
		# ------------------------------------------

		if not player_data.has("Stats"):

			push_error(
				"[AWAY TEAM][ERRO] Jogador CID " +
				str(cid) +
				" não possui Stats!"
			)

			continue


		var stats = player_data["Stats"]


		if not stats is Dictionary:

			push_error(
				"[AWAY TEAM][ERRO] Stats do CID " +
				str(cid) +
				" não é Dictionary!"
			)

			continue


		# ------------------------------------------
		# NOME
		# ------------------------------------------

		var player_name: String = str(
			stats.get("Name", "")
		)


		# ------------------------------------------
		# POSIÇÃO
		# ------------------------------------------

		var pos: String = str(
			stats.get("POS", "")
		)


		# ------------------------------------------
		# STATS
		# ------------------------------------------

		var atk: int = int(
			stats.get("ATK", 0)
		)

		var dri: int = int(
			stats.get("DRI", 0)
		)

		var def: int = int(
			stats.get("DEF", 0)
		)

		var vel: int = int(
			stats.get("VEL", 0)
		)

		var pas: int = int(
			stats.get("PAS", 0)
		)

		var sta: int = int(
			stats.get("STA", 0)
		)


		# ==================================================
		# 14. CRIAR PLAYER
		# ==================================================

		var player: Dictionary = {

			"CID": cid,

			"Name": player_name,

			"Number": number,

			"Foot": foot,

			"POS": pos,

			"ATK": atk,

			"DRI": dri,

			"DEF": def,

			"VEL": vel,

			"PAS": pas,

			"STA": sta
		}


		# ==================================================
		# 15. SALVAR NO GLOBAL
		# ==================================================

		var slot: String = str(
			player_key
		)


		GlobalAwayTeam.Players[slot] = player

		loaded_players += 1


		print(
			"[AWAY TEAM][SUCESSO] Jogador carregado:"
		)

		print(
			"    Slot: ",
			slot
		)

		print(
			"    CID: ",
			cid
		)

		print(
			"    Nome: ",
			player_name
		)

		print(
			"    Número: ",
			number
		)

		print(
			"    Foot: ",
			foot
		)

		print(
			"    POS: ",
			pos
		)

		print(
			"    ATK: ",
			atk,
			" | DRI: ",
			dri,
			" | DEF: ",
			def
		)

		print(
			"    VEL: ",
			vel,
			" | PAS: ",
			pas,
			" | STA: ",
			sta
		)


	# ==================================================
	# 16. RESULTADO FINAL
	# ==================================================

	print("")
	print("==================================================")
	print("[AWAY TEAM] CARREGAMENTO FINALIZADO")
	print("==================================================")


	print(
		"[AWAY TEAM] ID: ",
		GlobalAwayTeam.CountryID
	)

	print(
		"[AWAY TEAM] País: ",
		GlobalAwayTeam.CountryName
	)

	print(
		"[AWAY TEAM] Sigla: ",
		GlobalAwayTeam.Sigla
	)

	print(
		"[AWAY TEAM] Cor: ",
		GlobalAwayTeam.Cor
	)

	print(
		"[AWAY TEAM] Técnico: ",
		GlobalAwayTeam.Tecnico[0]
	)

	print(
		"[AWAY TEAM] Jogadores no JSON: ",
		players_data.size()
	)

	print(
		"[AWAY TEAM] Jogadores carregados: ",
		loaded_players
	)

	print(
		"[AWAY TEAM] Jogadores no GlobalAwayTeam: ",
		GlobalAwayTeam.Players.size()
	)


	if loaded_players == players_data.size():

		print(
			"[AWAY TEAM][SUCESSO] TODOS OS JOGADORES FORAM CARREGADOS!"
		)

	else:

		push_warning(
			"[AWAY TEAM][AVISO] Alguns jogadores não foram carregados!"
		)


	print("==================================================")
	print("[AWAY TEAM] SetupAwayTeam() FINALIZADO")
	print("==================================================")
	print("")
