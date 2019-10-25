extends Node

enum {EMPTY, PLAYER, PLAYER2, OBSTACLE, COLLECTIBLE}

func _ready():
	pass
	
var n = 0
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
var positions = []
var position1 = []
var play_pos = 0
var play2_pos = 0
var exit_pos = 0

var player_start = 0

remote func match_make():
	print("match make")
	var id = get_tree().get_rpc_sender_id()
	print(str(id) + " is looking for a match")
	var playersearch = players.get_children()
	
	if(playersearch.size() == 0):
		return
	
	randomize()
	var candidate = playersearch[randi()%playersearch.size()]
	print("chosen opponent is: " + candidate.name)
	
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
	
remote func client_reset(session_id):
		var id = get_tree().get_rpc_sender_id()
		var curr_session = session_dict[session_id]
		for x in range(variable.grid_size.x):
			variable.grid.append([])
			for y in range(variable.grid_size.y):
				variable.grid[x].append(EMPTY)
		rpc_id(int(curr_session.connected_players[0].name), "grid", variable.grid)
		rpc_id(int(curr_session.connected_players[1].name), "grid", variable.grid)
		counter = 0

remote func serverclientgrid(session_id):
	print("serverclientgrid")
	counter += 1
	if (counter == 2): 
		var id = get_tree().get_rpc_sender_id()
		var curr_session = session_dict[session_id]
		if (variable.grid.size() == 0):
			for x in range(variable.grid_size.x):
				variable.grid.append([])
				for y in range(variable.grid_size.y):
					variable.grid[x].append(EMPTY)
		rpc_id(int(curr_session.connected_players[0].name), "grid", variable.grid)
		rpc_id(int(curr_session.connected_players[1].name), "grid", variable.grid)
		counter = 0
		
remote func serverclientgridcon(session_id):
	print("serverclientgridcon")
	counter += 1
	if (counter == 2): 
		var id = get_tree().get_rpc_sender_id()
		var curr_session = session_dict[session_id]
		if (variable.grid.size() == 0):
			for x in range(variable.grid_size.x):
				variable.grid.append([])
				for y in range(variable.grid_size.y):
					variable.grid[x].append(EMPTY)
		rpc_id(int(curr_session.connected_players[0].name), "gridcon", variable.grid)
		rpc_id(int(curr_session.connected_players[1].name), "gridcon", variable.grid)
		counter = 0

remote func serverclientposition(session_id):
	print("serverclientpositions")
	counter += 1
	if (counter == 2):
		var id = get_tree().get_rpc_sender_id()
		var curr_session = session_dict[session_id]
		# Obstacles
		for n in range(variable.gameSize *variable.gameSize * 0.2):
			var placed = false
			while not placed:
				randomize()
				var grid_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
				var forbidden1 = Vector2(1,1)
				var forbidden2 = Vector2(1,3)
				var forbidden3 = Vector2(2,2)
				var forbidden4 = Vector2(3,1)
				var forbidden5 = Vector2(3,3)
				if not variable.grid[grid_pos.x][grid_pos.y]:
					if not grid_pos == forbidden1:
						if not grid_pos == forbidden2:
							if not grid_pos == forbidden3:
								if not grid_pos == forbidden4:
									if not grid_pos == forbidden5:
										if not grid_pos in positions:
											positions.append(grid_pos)
											position1.append(grid_pos)
											placed = true
	                                        
		var placed = false
		while not placed:
			randomize()
			play_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
			if not variable.grid[play_pos.x][play_pos.y]:
				if not play_pos in positions:
					positions.append(play_pos)
					placed = true
		placed = false
		while not placed:
			randomize()
			play2_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
			if not variable.grid[play2_pos.x][play2_pos.y]:
				if not play2_pos in positions:
					positions.append(play2_pos)
					placed = true
		placed = false
		while not placed:
			randomize()
			exit_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
			if not variable.grid[exit_pos.x][exit_pos.y]:
				if not exit_pos in positions:
					positions.append(exit_pos)
					placed = true
		rpc_id(int(curr_session.connected_players[0].name), "positioning", position1, positions, play_pos, play2_pos, exit_pos)
		rpc_id(int(curr_session.connected_players[1].name), "positioning", position1, positions, play_pos, play2_pos, exit_pos)
		position1 = []
		positions = []
		play_pos = 0
		play2_pos = 0
		exit_pos = 0
		variable.grid = []
		for x in range(variable.grid_size.x):
			variable.grid.append([])
			for y in range(variable.grid_size.y):
				variable.grid[x].append(EMPTY)
		counter = 0

remote func serverclientpositioncon(session_id):
	print("serverclientpositionscon")
	counter += 1
	if (counter == 2):
		var id = get_tree().get_rpc_sender_id()
		var curr_session = session_dict[session_id]
		# Obstacles
		for n in range(variable.gameSize *variable.gameSize * 0.2):
			var placed = false
			while not placed:
				randomize()
				var grid_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
				var forbidden1 = Vector2(1,1)
				var forbidden2 = Vector2(1,3)
				var forbidden3 = Vector2(2,2)
				var forbidden4 = Vector2(3,1)
				var forbidden5 = Vector2(3,3)
				if not variable.grid[grid_pos.x][grid_pos.y]:
					if not grid_pos == forbidden1:
						if not grid_pos == forbidden2:
							if not grid_pos == forbidden3:
								if not grid_pos == forbidden4:
									if not grid_pos == forbidden5:
										if not grid_pos in positions:
											positions.append(grid_pos)
											position1.append(grid_pos)
											placed = true
	                                        
		var placed = false
		while not placed:
			randomize()
			play_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
			if not variable.grid[play_pos.x][play_pos.y]:
				if not play_pos in positions:
					positions.append(play_pos)
					placed = true
		placed = false
		while not placed:
			randomize()
			play2_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
			if not variable.grid[play2_pos.x][play2_pos.y]:
				if not play2_pos in positions:
					positions.append(play2_pos)
					placed = true
		placed = false
		while not placed:
			randomize()
			exit_pos = Vector2(randi() % int(variable.grid_size.x), randi() % int(variable.grid_size.y))
			if not variable.grid[exit_pos.x][exit_pos.y]:
				if not exit_pos in positions:
					positions.append(exit_pos)
					placed = true
		rpc_id(int(curr_session.connected_players[0].name), "positioningcon", position1, positions, play_pos, play2_pos, exit_pos)
		rpc_id(int(curr_session.connected_players[1].name), "positioningcon", position1, positions, play_pos, play2_pos, exit_pos)
		position1 = []
		positions = []
		play_pos = 0
		play2_pos = 0
		exit_pos = 0
		variable.grid = []
		for x in range(variable.grid_size.x):
			variable.grid.append([])
			for y in range(variable.grid_size.y):
				variable.grid[x].append(EMPTY)
		counter = 0

remote func player_role(session_id):
	print("player_role this is server")
	counter += 1
	if (counter == 2):
		var id = get_tree().get_rpc_sender_id()
		var curr_session = session_dict[session_id]
		randomize()
		player1_role = randi()%2
		if player1_role == 0:
			player2_role = 1
		if player1_role == 1:
			player2_role = 0
		print("player1_role = " + str(player1_role))
		print("player2_role = " + str(player2_role))
		rpc_id(int(curr_session.connected_players[0].name), "player1_role", player1_role)
		print("to 1")
		rpc_id(int(curr_session.connected_players[1].name), "player2_role", player2_role)
		print("to 2")
		player1_role = 0
		player2_role = 0
		counter = 0

remote func player_rolecon(session_id):
	print("player_role this is server")
	counter += 1
	if (counter == 2):
		var id = get_tree().get_rpc_sender_id()
		var curr_session = session_dict[session_id]
		rpc_id(int(curr_session.connected_players[0].name), "player1_rolecon")
		print("to 1")
		rpc_id(int(curr_session.connected_players[1].name), "player2_rolecon")
		print("to 2")
		counter = 0

remote func update_grid(sentdirection,sentposition,position2,session_id):
	print("update_grid")
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	if id == int(curr_session.connected_players[0].name):
		rpc_id(int(curr_session.connected_players[1].name), "update_grid2", sentdirection,sentposition,position2)
		print("update_grid2")
	else:
		rpc_id(int(curr_session.connected_players[0].name), "update_grid2", sentdirection,sentposition,position2)
		print("update_grid2")
		
remote func update_gridfor1(sentdirection,sentposition,position2,session_id):
	print("update_gridfor1")
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	if id == int(curr_session.connected_players[0].name):
		rpc_id(int(curr_session.connected_players[1].name), "update_grid2for1", sentdirection,sentposition,position2)
		print("update_grid2for1")
	else:
		rpc_id(int(curr_session.connected_players[0].name), "update_grid2for1", sentdirection,sentposition,position2)
		print("update_grid2for1")

func onedisconnect(session_id):
	player_start = 0
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	rpc_id(int(curr_session.connected_players[0].name), "onedisconnect") 
	rpc_id(int(curr_session.connected_players[1].name), "onedisconnect") 
	
remote func start_game(session_id):
	print("start game")
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	player_start += 1
	if(player_start==2):
		rpc_id(int(curr_session.connected_players[0].name),"start_timer")
		rpc_id(int(curr_session.connected_players[1].name), "start_timer")
		player_start = 0

remote func start_game2(session_id):
	print("start game")
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	rpc_id(int(curr_session.connected_players[0].name),"start_timer")
	rpc_id(int(curr_session.connected_players[1].name), "start_timer")
	player_start = 0

func move0(session_id):
	variable.move = 1
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	rpc_id(int(curr_session.connected_players[0].name),"move0", variable.move)
	rpc_id(int(curr_session.connected_players[1].name), "move0", variable.move)

func reset_score(session_id):
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	rpc_id(int(curr_session.connected_players[0].name),"reset_score")
	rpc_id(int(curr_session.connected_players[1].name),"reset_score")

remote func clientreset(session_id):
	client_reset(session_id)
	start_game2(session_id)
	move0(session_id)
	reset_score(session_id)

remote func playerName(playerName, session_id):
	print(playerName)
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	if id == int(curr_session.connected_players[0].name):
		rpc_id(int(curr_session.connected_players[1].name),"opponent_name",playerName)
	else: 
		rpc_id(int(curr_session.connected_players[0].name),"opponent_name",playerName)

remote func pause(session_id):
	print("pause")
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	if id == int(curr_session.connected_players[0].name):
		rpc_id(int(curr_session.connected_players[1].name),"opponentPause")
	else: 
		rpc_id(int(curr_session.connected_players[0].name),"opponentPause")

remote func continueGame(session_id):
	print("continue")
	var id = get_tree().get_rpc_sender_id()
	var curr_session = session_dict[session_id]
	if id == int(curr_session.connected_players[0].name):
		rpc_id(int(curr_session.connected_players[1].name),"opponentContinue")
	else: 
		rpc_id(int(curr_session.connected_players[0].name),"opponentContinue")