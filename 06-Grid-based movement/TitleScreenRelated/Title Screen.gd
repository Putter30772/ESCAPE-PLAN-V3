extends Node

func _ready():
	Lobby.lobby = self
	pass

func _on_Play_pressed():
	print("Connect")
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(network)
	network.connect("connection_failed",self,"_on_connection_failed")
	network.connect("connection_succeeded",self,"_success")
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")
	
func _on_connection_failed(error):
	$labelStatus.text = "Error connecting to server " + error

func _success():
	Lobby.look_for_player(null)

func _on_packet_received(id,packet):
	$TrollData.text = packet.get_string_from_ascii()

func stop_looking():
	get_tree().change_scene("res://Game.tscn")