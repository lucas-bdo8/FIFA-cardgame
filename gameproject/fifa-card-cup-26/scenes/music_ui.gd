extends Control

@onready var label = $Label

func _ready():
	GlobalSignals.SongChanged.connect(update_song_title)

func update_song_title(song_name: String):
	$Label.text = song_name

func _process(delta):
	if Input.is_action_just_pressed("X"):
		GlobalSignals.NextSong.emit()
