extends Node

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("server_disconnected",self,"serverGotDisconnected")

func _on_Play_pressed():
	print("Connect")
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 4242)
	get_tree().set_network_peer(network)
	network.connect("connection_failed",self,"_on_connection_failed")
	network.connect("connection_succeeded",self,"_success")
	
func _player_connected(id):
	print("Player connected to server!")
	globals.otherPlayerId = id
	
func _on_connection_failed(error):
	$labelStatus.text = "Error connecting to server " + error

func _success():
	get_tree().change_scene("res://Game.tscn")