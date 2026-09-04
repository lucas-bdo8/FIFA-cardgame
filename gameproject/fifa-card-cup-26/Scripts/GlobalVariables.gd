extends Node

@export_enum("Squad Setup", "Squad Setup Transition", "Intro", "Intro Transition", "Gameplay") var CamState = "Squad Setup"

var GameState = "Intro"

@export var HomeTeam := 1
@export var AwayTeam := 2

@export var Formation : Array[int] = [0,0,0,0,0]
