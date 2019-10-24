extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Reset_pressed():
	Lobby.clientreset(Lobby.session_id)
	
func _process(delta):
	if(variable.language==1):
		get_node("Label").set_text('รีเซ็ต')
	else:
		get_node("Label").set_text('Reset')