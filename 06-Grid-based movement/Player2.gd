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
var sentdirection
var sentposition
var counter = 0
var position2
func _ready():
	grid = get_parent()
	type = grid.PLAYER2
	set_process(true)


func _process(delta):
	direction = Vector2()
	speed = 0
	if(variable.turn == 0)&&(variable.player_role==0):
		if(variable.ready==1):
			if Input.is_action_pressed("move_up")||Input.is_action_pressed("w"):
				direction.y = -1
			elif Input.is_action_pressed("move_down")||Input.is_action_pressed("s"):
				direction.y = 1
			if Input.is_action_pressed("move_left")||Input.is_action_pressed("a"):
				direction.x = -1
			elif Input.is_action_pressed("move_right")||Input.is_action_pressed("d"):
				direction.x = 1
		_move(direction,position,position2)
	else:
		pass
func _move(direction,position,position2):
	if(counter == 0)&&(variable.player_role==0):
		sentdirection = direction
		sentposition = position
		print("record data")
		
	print(sentdirection)
	print(sentposition )
	print("move1w")
	print(direction)
	print(position)
	if not is_moving and direction != Vector2():
		# if player is not moving and has no direction
		# then set the target direction
		print("move1.5")
		target_direction = direction.normalized()
		print(direction)
		print(position)
		print(target_direction)
		if move.is_cell_vacant(position, direction):
			type = 2
			print(type)
			
			world_target_pos = move.update_child_pos(position, direction, type)
			print(world_target_pos)
			is_moving = true
			print("move3")
			print(is_moving)
		else:
			counter = 0

	if is_moving:
		counter += 1
		print("move4")
		if(variable.turn == 0):
			speed = MAX_SPEED
			velocity = speed * target_direction *0.2
			print(velocity)
			var distance_to_target = position.distance_to(world_target_pos)
			var move_distance = velocity.length()
			print("move5")
			print(distance_to_target)
			print(move_distance)	
		# Set the last movement distance to the distance to the target
		# this will make the player stop exaclty on the target
			if distance_to_target < move_distance:
					velocity = target_direction * distance_to_target
					is_moving = false
					counter = 0
					variable.move = 1
					variable.turn += 1
					print(velocity)
					print("move6")
					print(position)
					print(direction)
					print("sent")
					print(sentdirection)
					print(sentposition)
					position2 = position
					if(variable.player_role == 0):
						Lobby.update_grid(sentdirection,sentposition,position2,Lobby.session_id)
				
			
			elif(variable.player_role == 1):
				print("moveandcollide")
				move_and_collide(velocity)
				print(velocity)
				print("move7")
				if is_moving:
					counter += 1
					print("move8")
					if(variable.turn == 0):
						speed = MAX_SPEED
						velocity = speed * target_direction *0.2
						distance_to_target = position2.distance_to(world_target_pos)
						move_distance = velocity.length()
						print("move9")
						print(distance_to_target)
						print(move_distance)
						# Set the last movement distance to the distance to the target
						# this will make the player stop exaclty on the target
						if distance_to_target < move_distance:
								velocity = target_direction * distance_to_target
								is_moving = false
								counter -= 1
								variable.move = 1
								variable.turn += 1
								print(velocity)
								print("move10")
								print(position)
								print(direction)
								print("sent")
								print(sentdirection)
								print(sentposition)
								position = position2
								print(position)
								if(variable.player_role == 0):
									Lobby.update_grid(sentdirection,sentposition,position2,Lobby.session_id)
			print("moveandcollide")
			move_and_collide(velocity)
			print(velocity)
			
			
		else: 
			pass