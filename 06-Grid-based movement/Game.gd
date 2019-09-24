extends Node

func _ready():
	set_process_input(true)
	set_pause_mode(PAUSE_MODE_PROCESS)
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")
	

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().is_paused():
			get_tree().set_pause(false)
		else:
			get_tree().set_pause(true)
			
func _on_packet_received(id,packet):
	$TrollData.text = packet.get_string_from_ascii()