extends Label

onready var status_label = $LabelStatus
onready var user_count_label = $LabelUserCount
onready var players = $Players
var player = preload("res://Player.tscn")

func _ready():
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
	text = text + "\nUser " + str(id) + " connected"
	get_parent().get_node("LabelUserCount").text = "Total Users:" + str(get_tree().get_network_connected_peers().size())
	var new_player = player.instance()
	new_player.set_id(id)
	players.add_child(new_player)

func _peer_disconnected(id):
	text = text + "\nUser " + str(id) + " disconnected"
	get_parent().get_node("LabelUserCount").text = "Total Users:" + str(get_tree().get_network_connected_peers().size())
	for player in players.get_children():
		if player.name == str(id):
			player.queue_free()