# Collection of functions to work with a Grid. Stores all its children in the grid array
extends TileMap
enum {EMPTY, PLAYER, PLAYER2, OBSTACLE, COLLECTIBLE}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
#var grid_size = Vector2(cell_quadrant_size, cell_quadrant_size)
var grid_size = Vector2(variable.gameSize,variable.gameSize)

onready var Obstacle = preload("res://Obstacle.tscn")
onready var Player = preload("res://Player.tscn")
onready var Player2 = preload("res://Player2.tscn")
onready var Exit = preload("res://exit.tscn")
#const PLAYER_STARTPOS = Vector2(4,4)
#const PLAYER2_STARTPOS = Vector2(0,0)

func _ready():
	print("START")
	for x in range(grid_size.x):
		variable.grid.append([])
		for y in range(grid_size.y):
			variable.grid[x].append(EMPTY)
#	change this variable below to change cell size
	set_cell_size(Vector2(110,110))
	print(tile_size)
	print(half_tile_size)
	

func empty_grid():
    for pos in variable.grid:
        for pos2 in pos:
            pos2 = EMPTY
    for obj in get_tree().get_nodes_in_group("to_delete"):
        obj.queue_free()

func positions():
	empty_grid()
	variable.turn = 0
#	change these two below for all func too        half_tile_size is cell_size/2
	
	for pos in variable.position1:
		set_cell_size(Vector2(110,110))
		half_tile_size = Vector2(55,55)
		var new_obstacle = Obstacle.instance()
		new_obstacle.add_to_group("to_delete")
		new_obstacle.position = map_to_world(pos) + half_tile_size
		variable.grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)

func play_pos():	
	set_cell_size(Vector2(110,110))
	half_tile_size = Vector2(55,55)
	var new_player = Player.instance()
	variable.player1 = new_player
	new_player.add_to_group("to_delete")
	new_player.position = map_to_world(variable.play_pos) + half_tile_size
	variable.grid[variable.play_pos.x][variable.play_pos.y] = PLAYER
	add_child(new_player)
        
func play2_pos():
	set_cell_size(Vector2(110,110))
	half_tile_size = Vector2(55,55)
	var new_player2 = Player2.instance()
	variable.player2 = new_player2
	new_player2.add_to_group("to_delete")
	new_player2.position = map_to_world(variable.play2_pos) + half_tile_size
	variable.grid[variable.play2_pos.x][variable.play2_pos.y] = PLAYER2
	add_child(new_player2)

func exit_pos():
	set_cell_size(Vector2(110,110))
	half_tile_size = Vector2(55,55)
	var new_exit = Exit.instance()
	new_exit.add_to_group("to_delete")
	new_exit.position = map_to_world(variable.exit_pos) + half_tile_size
	variable.grid[variable.exit_pos.x][variable.exit_pos.y] = COLLECTIBLE
	add_child(new_exit)

# Check if cell at direction is vacant
func is_cell_vacant(this_grid_pos=Vector2(), direction=Vector2()):
	set_cell_size(Vector2(110,110))
	half_tile_size = Vector2(55,55)
	print("move2")
	var this = world_to_map(this_grid_pos)
	var target_grid_pos = world_to_map(this_grid_pos) + direction
	
	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		print("move2.1")
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			print("move2.2")
			if variable.grid[target_grid_pos.x][target_grid_pos.y] == EMPTY :
				print("move2.3")
				return true 
			else :if variable.grid[target_grid_pos.x][target_grid_pos.y] == PLAYER || variable.grid[target_grid_pos.x][target_grid_pos.y] == PLAYER2 :
				print("PRISONER LOSE, WARDER WIN")
				if(variable.player_role==0):
					variable.score += 1
					variable.winlose = 1
				else:
					variable.opponent_score += 1
				variable.ready = 0
				variable.winner = 2
				variable.gameState = 2
				variable.warderScore += 1
				print("move2.4")
				return true
			else :if variable.grid[target_grid_pos.x][target_grid_pos.y] == COLLECTIBLE && variable.grid[this.x][this.y] == PLAYER:
				print("PRISONER WIN, WARDER LOSS")
				if(variable.player_role==1):
					variable.score += 1
					variable.winlose = 1
				else:
					variable.opponent_score += 1
				variable.ready = 0
				variable.winner = 1
				variable.gameState = 2
				variable.prisonerScore += 1
				print("move2.5")
				return true
			else:
				print("move2.6")
				return false


# Remove node from current cell, add it to the new cell,
# returns the new world target position
func update_child_pos(this_world_pos, direction, type):
	set_cell_size(Vector2(110,110))
	half_tile_size = Vector2(55,55)
	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction
	
		# remove player from current grid location
	variable.grid[this_grid_pos.x][this_grid_pos.y] = EMPTY
	
		# place player on new grid location
	variable.grid[new_grid_pos.x][new_grid_pos.y] = type
	
	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos
	

func _on_PlayAgain_pressed():
	print("PlayAgain")
	get_tree().change_scene("res://Game.tscn")
	Lobby.ready(Lobby.session_id)
	Lobby.get_layoutcon(variable.grid)
	variable.gameStart = 1
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0

func _on_Exit_pressed():
	print("Exit")
	get_tree().set_network_peer(null)
	empty_grid()
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")
	variable.gameStart = 0
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0

func _on_Start_pressed():
	print("Welcome Start")
	Lobby.ready(Lobby.session_id)
	get_tree().reload_current_scene()
	variable.gameStart = 1
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0
	
func _on_Reset_pressed():
	Lobby.clientreset(Lobby.session_id)


func _on_RageQuit_pressed():
	get_tree().set_network_peer(null)
	empty_grid()
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")
	variable.gameStart = 0
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0
