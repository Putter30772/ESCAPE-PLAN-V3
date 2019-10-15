extends Node

enum {EMPTY, PLAYER, PLAYER2, OBSTACLE, COLLECTIBLE}

func _ready():
	pass # Replace with function body.

var server = null
var players = null
var in_game = null
var sessions = null
var session = preload("res://Session.tscn")
var counter = 0
var session_id = 0
var session_dict = {}
var player1_role = 0
var player2_role = 0
# warning-ignore:unused_argument
remote func match_make(info):
	print("match make")
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
	print("move to game")
	node.get_parent().remove_child(node)
	in_game.add_child(node)
		
remote func serverclientgrid(session_id):
	print("serverclientgrid")
	counter += 1
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	for x in range(variable.grid_size.x):
		variable.grid.append([])
		for y in range(variable.grid_size.y):
			variable.grid[x].append(EMPTY)
	if (counter == 2): 
		rpc_id(int(curr_session.connected_players[0].name), "grid", variable.grid)
		rpc_id(int(curr_session.connected_players[1].name), "grid", variable.grid)
		counter = 0

remote func serverclientposition(session_id):
	print("serverclientpositions")
	counter += 1
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	var positions = []
	var position1 = []
	for n in range(variable.gameSize *variable.gameSize * 0.2):
		var placed = false
		while not placed:
			randomize()
			var grid_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
			if not variable.grid[grid_pos.x][grid_pos.y]:
				if not variable.grid[1][1] || variable.grid[1][3] || variable.grid[2][2] || variable.grid[3][1] || variable.grid[3][3]:
					if not grid_pos in positions:
						positions.append(grid_pos)
						position1.append(grid_pos)
						placed = true
						
	var placed = false
	var play_pos = 0
	while not placed:
		randomize()
		play_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
		if not variable.grid[play_pos.x][play_pos.y]:
			if not play_pos in positions:
				positions.append(play_pos)
				placed = true
	placed = false
	var play2_pos = 0
	while not placed:
		randomize()
		play2_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
		if not variable.grid[play2_pos.x][play2_pos.y]:
			if not play2_pos in positions:
				positions.append(play2_pos)
				placed = true
	placed = false
	var exit_pos = 0
	while not placed:
		randomize()
		exit_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
		if not variable.grid[exit_pos.x][exit_pos.y]:
			if not exit_pos in positions:
				positions.append(exit_pos)
				placed = true
	if (counter == 2):
		rpc_id(int(curr_session.connected_players[0].name), "positioning", position1, positions, play_pos, play2_pos, exit_pos)
		rpc_id(int(curr_session.connected_players[1].name), "positioning", position1, positions, play_pos, play2_pos, exit_pos)
		counter = 0

remote func player_role(session_id):
	print("player_role")
	counter += 1
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	if (counter == 1):
		randomize()
		player1_role = randi()%2
		if player1_role == 0:
			player2_role = 1
		if player1_role == 1:
			player2_role = 0
		print(player1_role)
		print(player2_role)
	if (counter == 2):
		rpc_id(int(curr_session.connected_players[0].name), "player1_role", player1_role)
		print("to 1")
		rpc_id(int(curr_session.connected_players[1].name), "player2_role", player2_role)
		print("to 2")
		counter = 0