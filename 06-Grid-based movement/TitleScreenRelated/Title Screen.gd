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
	
func _player_connected(id):
	print("Player connected to server!")
	globals.otherPlayerId = id
	var game = preload("res://Game.tscn").instance()
	get_tree().get_root().add_child(game)
	$Menu.hide()
	
func _on_connection_failed(error):
	$labelStatus.text = "Error connecting to server " + error
	