extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#MusicManager.stop_all_music()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.CamState == "Intro":
		$"Intro Scene".visible = true
