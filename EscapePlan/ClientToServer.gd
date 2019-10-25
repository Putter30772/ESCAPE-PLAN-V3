extends Node

onready var Obstacle = preload("res://Obstacle.tscn")
onready var Player = preload("res://Player.tscn")
onready var Player2 = preload("res://Player2.tscn")
onready var Exit = preload("res://exit.tscn")
var movePlayer2 = load("res://Player2.gd").new()

func _ready():

	pass # Replace with function body.

var room = null
#var test = Player2.instance()
var session_id = -1


func look_for_player():
	print("look for player")
	rpc_id(1,"match_make")
	
remote func player_found(session_id):
	print("player found")
	self.session_id = session_id
	if room != null:
		room.stop_looking()

func get_layout(layout):
	print("get layout")
	if session_id > -1:
		rpc_id(1, "serverclientgrid", session_id)
	else:
		print("session error")

func get_layoutcon(layout):
	print("get layout")
	if session_id > -1:
		rpc_id(1, "serverclientgridcon", session_id)
	else:
		print("session error")

remote func grid(grid):
	print("grid")
	variable.grid = []
	variable.grid = grid
	rpc_id(1, "serverclientposition", session_id)

remote func gridcon(grid):
	print("grid")
	variable.grid = []
	variable.grid = grid
	rpc_id(1, "serverclientpositioncon", session_id)
	
remote func positioning(position1, positions, play_pos, play2_pos, exit_pos):
	print("positioning")
	variable.position = positions
	variable.position1 = position1
	Grid.positions()
	variable.play_pos = play_pos
	variable.play2_pos = play2_pos
	variable.exit_pos = exit_pos
	Grid.play_pos()
	Grid.play2_pos()
	Grid.exit_pos()
	rpc_id(1, "player_role", session_id)

remote func positioningcon(position1, positions, play_pos, play2_pos, exit_pos):
	print("positioningcon")
	variable.position = positions
	variable.position1 = position1
	Grid.positions()
	variable.play_pos = play_pos
	variable.play2_pos = play2_pos
	variable.exit_pos = exit_pos
	Grid.play_pos()
	Grid.play2_pos()
	Grid.exit_pos()
	rpc_id(1, "player_rolecon", session_id)

remote func player1_role(player1_role):
	print("player1_role")
	if(player1_role == 0):
		print("this is warder")
	else:
		print("this is prisoner")
	variable.player_role = player1_role

remote func player1_rolecon():
	print("player1_rolecon")
	if(variable.winlose == 1):
		variable.player_role = 0
	else:
		variable.player_role = 1
	variable.winlose = 0

remote func player2_role(player2_role):
	print("player2_role")
	if(player2_role == 0):
		print("this is warder")
	else:
		print("this is prisoner")
	variable.player_role = player2_role

remote func player2_rolecon():
	print("player2_rolecon")
	if(variable.winlose == 1):
		variable.player_role = 0
	else: 
		variable.player_role = 1
	variable.winlose = 0

func send_on_ready():
	if session_id > -1:
		rpc_id(1, "serverclientgrid", session_id)
	else:
		print("session error")
		
func update_grid(sentdirection,sentposition,position2,session_id):
	print("update_grid")
	rpc_id(1,"update_grid",sentdirection,sentposition,position2,session_id)
	
remote func update_grid2(sentdirection,sentposition,position2):
	print("update_grid2")
	print(sentdirection)
	print(sentposition)
	variable.player2._move(sentdirection,sentposition,position2)

func update_gridfor1(sentdirection,sentposition,position2,session_id):
	print("update_gridfor1")
	rpc_id(1,"update_gridfor1",sentdirection,sentposition,position2,session_id)
	
remote func update_grid2for1(sentdirection,sentposition,position2):
	print("update_grid2for1")
	print(sentdirection)
	print(sentposition)
	variable.player1._move(sentdirection,sentposition,position2)

remote func onedisconnect():
	get_tree().set_network_peer(null)
	Grid.empty_grid()
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")
	variable.gameStart = 0
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0

func ready(session_id):
	print("ready")
	rpc_id(1,"start_game",session_id)
	
remote func start_timer():
	variable.ready = 1
	
remote func move0(move):
	variable.move = move

remote func reset_score():
	variable.score = 0
	variable.opponent_score = 0

func send_name(playerName,session_id):
	print(playerName)
	rpc_id(1,"playerName",playerName, session_id)

remote func opponent_name(opponentName):
	variable.opponentName =  opponentName

func clientreset(session_id):
	rpc_id(1,"clientreset", session_id)
	
func pause(session_id):
	print("pause")
	rpc_id(1,"pause",session_id)
	
remote func opponentPause():
	variable.pause = 1 

func continueGame(session_id):
	rpc_id(1,"continueGame",session_id)
 
remote func opponentContinue():
	print("oppnentContinue")
	variable.pause = 0