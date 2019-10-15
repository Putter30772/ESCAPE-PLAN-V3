extends Node

onready var status_label = $LabelStatus
onready var user_count_label = $LabelUserCount
onready var players = $Players
var player = preload("res://Player.tscn")

func _ready():
	print("ready")
	var network = NetworkedMultiplayerENet.new()
	network.create_server(6969, 20)
	get_tree().set_network_peer(network)
	Lobby.server = self
	Lobby.players = players
	Lobby.in_game = $InGame
	Lobby.sessions = $GameSession
	network.connect("peer_connected",self,"_peer_connected")
	network.connect("peer_disconnected",self,"_peer_disconnected")

func _peer_connected(id):
	print("peer connected")
	status_label.text += "\n" + str(id) + " connected."
	user_count_label.text = "Total users: " +  str(get_tree().get_network_connected_peers().size())
	var new_player = player.instance()
	new_player.set_id(id)
	players.add_child(new_player)

func _peer_disconnected(id):
	print("peer disconnected")
	status_label.text += "\n" + str(id) + " disconnected."
	user_count_label.text = "Total users: " +  str(get_tree().get_network_connected_peers().size())
	for player in players.get_children():
		if player.name == str(id):
			player.queue_free()