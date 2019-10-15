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

	# Obstacles
#	var positions = []
#	for n in range(variable.gameSize *variable.gameSize * 0.2):
#		var placed = false
#		while not placed:
#			randomize()
#			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
#			if not variable.grid[grid_pos.x][grid_pos.y]:
#				if not variable.grid[1][1] || variable.grid[1][3] || variable.grid[2][2] || variable.grid[3][1] || variable.grid[3][3]:
#					if not grid_pos in positions:
#						positions.append(grid_pos)
#						placed = true
				
# Obstacle

func set_name(name):
	variable.player_role.text = name

func positions():
	for pos in variable.position1:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos) + half_tile_size
		variable.grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)
## Player
#	var placed = false
#	while not placed:
#		randomize()
#		var play2_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
#		if not variable.grid[play2_pos.x][play2_pos.y]:
#			if not play2_pos in positions:
#				positions.append(play2_pos)
#				placed = true
func play_pos():
	var new_player = Player.instance()
	new_player.position = map_to_world(variable.play_pos) + half_tile_size
	variable.grid[variable.play_pos.x][variable.play_pos.y] = PLAYER
	add_child(new_player)
		
func play2_pos():
	var new_player2 = Player2.instance()			
	new_player2.position = map_to_world(variable.play2_pos) + half_tile_size
	variable.grid[variable.play2_pos.x][variable.play2_pos.y] = PLAYER2
	add_child(new_player2)
#
#	placed = false
#	while not placed:
#		randomize()
#		var exit_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
#		if not variable.grid[exit_pos.x][exit_pos.y]:
#			if not exit_pos in positions:
#				positions.append(exit_pos)
#				placed = true
func exit_pos():
	var new_exit = Exit.instance()
	new_exit.position = map_to_world(variable.exit_pos) + half_tile_size
	variable.grid[variable.exit_pos.x][variable.exit_pos.y] = COLLECTIBLE
	add_child(new_exit)

#	var new_player = Player.instance()
#	new_player.position = map_to_world(PLAYER_STARTPOS) + half_tile_size
#	grid[PLAYER_STARTPOS.x][PLAYER_STARTPOS.y] = PLAYER
#	add_child(new_player)
#	var new_player2 = Player2.instance()
#	new_player2.position = map_to_world(PLAYER2_STARTPOS) + half_tile_size
#	grid[PLAYER2_STARTPOS.x][PLAYER2_STARTPOS.y] = PLAYER
#	add_child(new_player2)

#func get_cell_entity_type(pos=Vector2()):
#	return grid[pos.x][pos.y]


# Check if cell at direction is vacant
func is_cell_vacant(this_grid_pos=Vector2(), direction=Vector2()):
	var this = world_to_map(this_grid_pos)
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			if variable.grid[target_grid_pos.x][target_grid_pos.y] == EMPTY :
				return true 
			else :if variable.grid[target_grid_pos.x][target_grid_pos.y] == PLAYER || variable.grid[target_grid_pos.x][target_grid_pos.y] == PLAYER2 :
				print("PRISONER LOSE, WARDER WIN")
				variable.winner = 2
				variable.gameState = 2
				variable.warderScore += 1
				return true
			else :if variable.grid[target_grid_pos.x][target_grid_pos.y] == COLLECTIBLE && variable.grid[this.x][this.y] == PLAYER:
				print("PRISONER WIN, WARDER LOSS")
				variable.winner = 1
				variable.gameState = 2
				variable.prisonerScore += 1
				return true
			else:
				return false


# Remove node from current cell, add it to the new cell,
# returns the new world target position
func update_child_pos(this_world_pos, direction, type):
	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction
	
		# remove player from current grid location
	variable.grid[this_grid_pos.x][this_grid_pos.y] = EMPTY
	
		# place player on new grid location
	variable.grid[new_grid_pos.x][new_grid_pos.y] = type
	
	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos
	

func _on_ToolButton_pressed():
	print("reload")
	get_tree().reload_current_scene()
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0

func _on_ToolButton2_pressed():
	get_tree().set_network_peer(null)
	get_tree().change_scene("res://TitleScreenRelated/Title Screen.tscn")
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0