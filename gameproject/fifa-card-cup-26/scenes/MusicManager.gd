extends Node



# CONFIGURAÇÕES
@export var music_files: Array[AudioStream] = []
@export var volume_db: float = 0.0
@export var transition_time: float = 0.5

# VARIÁVEIS
var audio_player: AudioStreamPlayer
var current_queue: Array = []
var current_index: int = -1
var next_music: AudioStream = null
var MusicName = ""#:= "Shakira & Burna Boy - Dai Dai"

func _ready():
	GlobalSignals.NextSong.connect(_play_next_music)
	# Cria o player de áudio
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.volume_db = volume_db
	audio_player.finished.connect(_on_music_finished)
	
	if music_files.size() > 0:
		_generate_new_shuffle_queue()
		_play_next_music()
		var song_name = next_music.resource_path.get_file().replace(".mp3", "").replace(".wav", "").replace(".ogg", "")
		MusicName = song_name
		GlobalSignals.SongChanged.emit(song_name)

# Gera nova fila (primeira música fixa, resto aleatório)
func _generate_new_shuffle_queue():
	if music_files.size() == 0: return
	var first_music = music_files[0]
	var remaining_music = music_files.slice(1)
	remaining_music.shuffle()
	current_queue = [first_music] + remaining_music
	current_index = -1
	

# Toca a próxima música
func _play_next_music():
	current_index += 1
	if current_index >= current_queue.size():
		_generate_new_shuffle_queue()
		current_index = 0
	
	next_music = current_queue[current_index]
	
	# Atualiza Label se existir na cena


	var song_name = next_music.resource_path.get_file().replace(".mp3", "").replace(".wav", "").replace(".ogg", "")
	GlobalSignals.SongChanged.emit(song_name)
	audio_player.stream = next_music
	audio_player.play()

func _on_music_finished():
	_play_next_music()

func skip_music():
	if audio_player:
		audio_player.stop()
		_play_next_music()

# ============================================================
# FUNÇÃO CRÍTICA: PARE TUDO (Chamada pela cena de jogo)
# ============================================================
func stop_all_music():
	if audio_player:
		audio_player.stop()
		# Opcional: Limpa o stream para garantir que nada toque acidentalmente
		audio_player.stream = null


# Opcional: Reiniciar se voltar ao menu
func resume_music():
	if music_files.size() > 0 and not audio_player.playing:
		if current_queue.is_empty():
			_generate_new_shuffle_queue()
		_play_next_music()
