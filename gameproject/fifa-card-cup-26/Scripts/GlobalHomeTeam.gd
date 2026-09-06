extends Node

var CountryID = 1
var CountryName = ""
var Sigla = ""
var Cor = ""
var Tecnico = ["", "", ""]
var Players = {
	"1": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"2": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"3": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"4": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"5": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"6": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"7": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"8": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"9": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"10": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"11": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"12": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"13": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"14": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"15": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"16": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"17": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"18": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"19": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"20": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"21": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"22": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"23": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"24": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"25": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
	"26": {
		"Name": "",
		"Number": 0,
		"Foot": "",
		"POS": "",
		"ATK": 0,
		"DRI": 0,
		"DEF": 0,
		"VEL": 0,
		"PAS": 0,
		"STA": 0
	},
}

var TitularHomeTeam = [0,0,0,0,0]
var TitularAwayTeam = [0,0,0,0,0]
