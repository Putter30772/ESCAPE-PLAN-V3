extends Node

func _ready():
	Lobby.lobby = self
	pass

func _on_Play_pressed():
	print("on Play pressed")
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(network)
	network.connect("connection_failed",self,"_on_connection_failed")
	network.connect("connection_succeeded",self,"_success")
	
func _on_connection_failed(error):
	$labelStatus.text = "Error connecting to server " + error

func _success():
	print("success")
	Lobby.look_for_player(null)

func stop_looking():
	print("stop looking")
	get_tree().change_scene("res://Game.tscn")
	Lobby.get_layout(variable.grid)


