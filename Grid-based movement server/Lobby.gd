extends Node

func _ready():
	pass # Replace with function body.

var server = null
var players = null
var in_game = null
var sessions = null
var session = preload("res://Session.tscn")

var session_id = 0
var session_dict = {}

# warning-ignore:unused_argument
remote func match_make(info):
	randomize()
	var id = get_tree().get_rpc_sender_id()
	print(str(id) + " is looking for match")
	var filtered_player = players.get_children()
	
	if(filtered_player.size() == 0):
		return
	
	var candidate = filtered_player[randi()%filtered_player.size()]
	print("chosen candidate is: " + candidate.name)
	
	if candidate.name == str(id):
		return
	
	var new_session = session.instance()
	sessions.add_child(new_session)
	session_dict[session_id] = new_session
	
	var opponent = null
	for player in players.get_children():
		if player.name == str(id) || player.name == candidate.name:
			if player.name == str(id):
				player.connected_player = candidate
				opponent = player
			call_deferred("move_to_game", player)
			new_session.connected_players.append(player)
			rpc_id(int(player.name), "player_found", session_id)
	candidate.connected_player = opponent
	session_id += 1

func move_to_game(node):
	node.get_parent().remove_child(node)
	in_game.add_child(node)

func begin_game(session_id):
	var curr_session = session_dict[session_id]
	print("beginning game on: "+str(session_id))
	
	var turn = randi()%2 == 1
	rpc_id(int(curr_session.connected_players[0].name),"receive_game_begin", turn)
	rpc_id(int(curr_session.connected_players[1].name),"receive_game_begin", !turn)
	if turn:
		curr_session.player_turn = curr_session.connected_players[0]
	else: 
		curr_session.player_turn = curr_session.connected_players[1]