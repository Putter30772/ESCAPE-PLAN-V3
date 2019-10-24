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
	if (variable.skin_select == 0) :
		$Sprite.set("texture", variable.p_skin1)
	if (variable.skin_select == 1) :
		$Sprite.set("texture", variable.p_skin2)
	if (variable.skin_select == 2) :
		$Sprite.set("texture", variable.p_skin3)
	if (variable.skin_select == 3) :
		$Sprite.set("texture", variable.p_skin4)
	grid = get_parent()
	type = grid.PLAYER
	set_process(true)


func _process(delta):
	direction = Vector2()
	speed = 0
	if(variable.turn == 1)&&(variable.player_role == 1):
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
	if(counter == 0)&&(variable.player_role==1):
		sentdirection = direction
		sentposition = position
		print("record data")
	print("move1p")
	print(direction)
	if not is_moving and direction != Vector2():
				# if player is not moving and has no direction
				# then set the target direction
		print("move1.5")
		target_direction = direction.normalized()
		print(direction)
		print(position)
		
		if move.is_cell_vacant(position, direction):
			type = 1
			world_target_pos = move.update_child_pos(position, direction, type)
				
			is_moving = true
			print("move3")
			print(is_moving)
		else:
			counter = 0
					
	if is_moving:
		counter+=1
		print("move4")
		if(variable.turn == 1):
			speed = MAX_SPEED
			velocity = speed * target_direction * 0.2		
			var distance_to_target = position.distance_to(world_target_pos)
			var move_distance = velocity.length()
			print("move5")
		
				# Set the last movement distance to the distance to the target
				# this will make the player stop exaclty on the target
			if distance_to_target < move_distance:
					velocity = target_direction * distance_to_target
					is_moving = false
					variable.turn -= 1
					variable.move = 1
					counter = 0
					print("move6")
					print(position)
					print(direction)
					position2 = position
					if(variable.player_role == 1):
						Lobby.update_gridfor1(sentdirection,sentposition,position2,Lobby.session_id)
		
		
			elif(variable.player_role == 0):
				print("moveandcollide")
				move_and_collide(velocity)
				print(velocity)
				print("move7")
				if is_moving:
					counter += 1
					print("move8")
					if(variable.turn == 1):
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
								variable.move = 1
								counter -= 1
								variable.turn -= 1
								print(velocity)
								print("move10")
								print(position)
								print(direction)
								print("sent")
								print(sentdirection)
								print(sentposition)
								position = position2
								print(position)
								if(variable.player_role == 1):
									Lobby.update_gridfor1(sentdirection,sentposition,position2,Lobby.session_id)
			print("moveandcollide")
			move_and_collide(velocity)
			print(velocity)
			
			
		else: 
			pass