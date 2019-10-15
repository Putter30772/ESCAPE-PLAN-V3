extends Node

onready var Obstacle = preload("res://Obstacle.tscn")
onready var Player = preload("res://Player.tscn")
onready var Player2 = preload("res://Player2.tscn")
onready var Exit = preload("res://exit.tscn")

func _ready():
	pass # Replace with function body.

var lobby = null

var session_id = -1

func look_for_player(info):
	print("look for player")
	rpc_id(1,"match_make", info)
	
remote func player_found(session_id):
	print("player found")
	self.session_id = session_id
	if lobby != null:
		lobby.stop_looking()

func get_layout(layout):
	print("get layout")
	if session_id > -1:
		rpc_id(1, "serverclientgrid", session_id)
	else:
		print("session error")

remote func grid(grid):
	print("grid")
	variable.grid = grid
	rpc_id(1, "serverclientposition", session_id)
	
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

remote func player1_role(player1_role):
	print("player1_role")
	variable.player_role = player1_role

remote func player2_role(player2_role):
	print("player2_role")
	variable.player_role = player2_role
		
func send_on_ready():
	if session_id > -1:
		rpc_id(1, "serverclientgrid", session_id)
	else:
		print("session error")