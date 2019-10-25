extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var p_skin1 = preload("res://Skins/P1G.png")
var p_skin2 = preload("res://Skins/P2G.png")
var p_skin3 = preload("res://Skins/P3G.png")
var p_skin4 = preload("res://Skins/P4G.png")
var w_skin1 = preload("res://Skins/W1G.png")
var w_skin2 = preload("res://Skins/W2G.png")
var w_skin3 = preload("res://Skins/W3G.png")
var w_skin4 = preload("res://Skins/W4G.png")
var skin_select = 0
var skin2_select = 0
var light_mode = 0

func _process(delta):
	if light_mode == 1 :
		VisualServer.set_default_clear_color(Color(1,1,1))
	else :
		VisualServer.set_default_clear_color(Color(0,0,0,0))

var turn = 0
var winner = 0
var gameState = 0
var gameSize = 5
var warderScore = 0
var prisonerScore = 0
var grid = []
var position = []
var play_pos = []
var play2_pos = []
var exit_pos = []
var position1 = []
var player_role
var playerName = ''
var opponentName = ''
var gameStart = 0
var player2 = null
var player1 = null
var startTime = 10
var ready = 0
var start = 0
var move = 0 
var score = 0
var opponent_score = 0
var winlose = 0
var check = true
var language = 0
var pause = 0