extends Node

onready var timer = $PlayerSearchTimeout

func _ready():
	Lobby.room = self
	pass

func _on_Play_pressed():
	print("on Play pressed")
	variable.score = 0
	variable.opponent_score = 0
	variable.playerName = get_node("Insert Name Dialog/LineEdit").get_text()
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(network)
	network.connect("connection_failed",self,"_on_connection_failed")
	network.connect("connection_succeeded",self,"_success")
	
func _on_connection_failed(error):
	$labelStatus.text = "Error connecting to the server " + error

func _success():
	print("success")
	timer.start()
	Lobby.look_for_player()

func stop_looking():
	print("stop looking")
	timer.stop()
	get_tree().change_scene("res://Game.tscn")
	Lobby.get_layout(variable.grid)

func _on_PlayerSearchTimeout_timeout():
	Lobby.look_for_player()


func _on_Back_pressed():
	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn")

func _on_PVP_ShareScreen_pressed():
	variableLAN.mode = 1
	get_tree().change_scene("res://LAN.tscn")
func _on_PVE_pressed():
	get_tree().change_scene("res://BotModeScreen.tscn")