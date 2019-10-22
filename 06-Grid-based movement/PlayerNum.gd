extends Label
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (variable.player_role == 0):
		if(variable.language==1):
			set_text("ผู้คุม: "+ variable.playerName)
		else:
			set_text("warder: "+ variable.playerName)
	else:
		if(variable.language==1):
			set_text("นักโทษ: "+ variable.playerName)
		else:
			set_text("prisoner: " + variable.playerName)