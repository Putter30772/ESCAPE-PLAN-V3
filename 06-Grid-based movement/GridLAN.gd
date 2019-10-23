extends TileMap

enum {EMPTY, PLAYER, PLAYER2, OBSTACLE, COLLECTIBLE}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
#var grid_size = Vector2(cell_quadrant_size, cell_quadrant_size)
var grid_size = Vector2(variableLAN.gameSize,variableLAN.gameSize)

var grid = []
onready var Obstacle = preload("res://Obstacle.tscn")
onready var Player = preload("res://PlayerLAN.tscn")
onready var Player2 = preload("res://Player2LAN.tscn")
onready var Exit = preload("res://exit.tscn")
#const PLAYER_STARTPOS = Vector2(4,4)
#const PLAYER2_STARTPOS = Vector2(0,0)

func _ready():
	print("START")
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(EMPTY)
	set_cell_size(Vector2(110,110))


	# Obstacles
	var positions = []
	for n in range(variableLAN.gameSize *variableLAN.gameSize * 0.2):
		var placed = false
		while not placed:
			randomize()
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			var forbidden1 = Vector2(1,1)
			var forbidden2 = Vector2(1,3)
			var forbidden3 = Vector2(2,2)
			var forbidden4 = Vector2(3,1)
			var forbidden5 = Vector2(3,3)
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos == forbidden1:
					if not grid_pos == forbidden2:
						if not grid_pos == forbidden3:
							if not grid_pos == forbidden4:
								if not grid_pos == forbidden5:
									if not grid_pos in positions:
										positions.append(grid_pos)
										placed = true

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos) + half_tile_size
		grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)

# Player

	var placed = false
	while not placed:
		randomize()
		var play_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid[play_pos.x][play_pos.y]:
			if not play_pos in positions:
				positions.append(play_pos)
				placed = true
				var new_player = Player.instance()
				new_player.position = map_to_world(play_pos) + half_tile_size
				grid[play_pos.x][play_pos.y] = PLAYER
				add_child(new_player)

	placed = false
	while not placed:
		randomize()
		var play2_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid[play2_pos.x][play2_pos.y]:
			if not play2_pos in positions:
				positions.append(play2_pos)
				placed = true
				var new_player2 = Player2.instance()
				new_player2.position = map_to_world(play2_pos) + half_tile_size
				grid[play2_pos.x][play2_pos.y] = PLAYER2
				add_child(new_player2)

	placed = false
	while not placed:
		randomize()
		var exit_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid[exit_pos.x][exit_pos.y]:
			if not exit_pos in positions:
				positions.append(exit_pos)
				placed = true
				var new_exit = Exit.instance()
				new_exit.position = map_to_world(exit_pos) + half_tile_size
				grid[exit_pos.x][exit_pos.y] = COLLECTIBLE
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
	
	set_cell_size(Vector2(110,110))
	half_tile_size = Vector2(55,55)
	var this = world_to_map(this_grid_pos)
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			if grid[target_grid_pos.x][target_grid_pos.y] == EMPTY :
				return true
			else :if grid[target_grid_pos.x][target_grid_pos.y] == PLAYER || grid[target_grid_pos.x][target_grid_pos.y] == PLAYER2 :
				print("PRISONER LOSE, WARDER WIN")
				variableLAN.winner = 2
				variableLAN.gameState = 2
				variableLAN.warderScore += 1
				return true
			else :if grid[target_grid_pos.x][target_grid_pos.y] == COLLECTIBLE && grid[this.x][this.y] == PLAYER:
				print("PRISONER WIN, WARDER LOSS")
				variableLAN.winner = 1
				variableLAN.gameState = 2
				variableLAN.prisonerScore += 1
				return true
			else:
				return false


# Remove node from current cell, add it to the new cell,
# returns the new world target position
func update_child_pos(this_world_pos, direction, type):
	set_cell_size(Vector2(110,110))
	half_tile_size = Vector2(55,55)
	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction

		# remove player from current grid location
	grid[this_grid_pos.x][this_grid_pos.y] = EMPTY

		# place player on new grid location
	grid[new_grid_pos.x][new_grid_pos.y] = type

	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos
	
func empty_grid():
    for pos in variableLAN.grid:
        for pos2 in pos:
            pos2 = EMPTY
    for obj in get_tree().get_nodes_in_group("to_delete"):
        obj.queue_free()

func _on_PlayAgain_pressed():
	print("reload")
	get_tree().reload_current_scene()
	variableLAN.ready = 1
	variableLAN.gameState = 0
	variableLAN.winner = 0
	variableLAN.turn = 0

func _on_Exit_pressed():
	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn")
	variableLAN.gameState = 0
	variableLAN.winner = 0
	variableLAN.turn = 0
	variableLAN.botdifficulty = 1
	variableLAN.mode = 0