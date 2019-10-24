extends Button

func _ready():
	pass # Replace with function body.

func _on_Pause_pressed():
	if(variable.ready==1):
		Lobby.pause(Lobby.session_id)
		variable.pause = 1 # Replace with function body.

func _process(delta):
	if(variable.language==1):
		get_node("Label").set_text('หยุดเกม')
	else:
		get_node("Label").set_text('Pause')