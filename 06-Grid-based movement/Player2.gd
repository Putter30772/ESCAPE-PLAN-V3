extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 400

var speed = 0
var velocity = Vector2()

var world_target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var type
var grid
var move = load("res://Grid.gd").new()

func _ready():
	grid = get_parent()
	type = grid.PLAYER2
	set_process(true)


func _process(delta):
	direction = Vector2()
	speed = 0
	if(variable.turn == 0)&&(variable.player_role==0):
		if Input.is_action_pressed("w"):
			direction.y = -1
		elif Input.is_action_pressed("s"):
			direction.y = 1
		if Input.is_action_pressed("a"):
			direction.x = -1
		elif Input.is_action_pressed("d"):
			direction.x = 1
		_move(direction,position,type)
	else:
		pass
func _move(direction,position,type):

	print("move1")
	print(direction)
	if not is_moving and direction != Vector2():
		# if player is not moving and has no direction
		# then set the target direction
		print("move1.5")
		target_direction = direction.normalized()
		print(direction)
		print(position)
		if move.is_cell_vacant(position, direction):
			print(type)
			
			world_target_pos = move.update_child_pos(position, direction, type)
			is_moving = true
			print("move3")
			print(is_moving)

	if is_moving:
		print("move4")
		variable.move = 1
		if(variable.turn == 0):
			speed = MAX_SPEED
			velocity = speed * target_direction *0.2

			var distance_to_target = position.distance_to(world_target_pos)
			var move_distance = velocity.length()
			print("move5")
		# Set the last movement distance to the distance to the target
		# this will make the player stop exaclty on the target
			if distance_to_target < move_distance:
					velocity = target_direction * distance_to_target
					is_moving = false
					variable.turn += 1
					print("move6")
					print(position)
					print(direction)
					if(variable.player_role == 0):
						Lobby.update_grid(direction,position,type,Lobby.session_id)
			move_and_collide(velocity)
		else: 
			pass