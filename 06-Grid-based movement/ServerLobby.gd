extends Node

func _ready():
	pass # Replace with function body.

var lobby = null
var session_id = -1

func look_for_player(info):
	rpc_id(1,"match_make", info)
	
remote func player_found(session_id):
	print("found player")
	self.session_id = session_id
	if lobby != null:
		lobby.stop_looking()