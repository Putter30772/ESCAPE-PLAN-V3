extends Node

func _ready():
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().is_paused():
			get_tree().set_pause(false)
		else:
			get_tree().set_pause(true)
			