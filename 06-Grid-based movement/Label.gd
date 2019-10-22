extends Label
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_text(str(variable.turn))
	add_color_override("font_color", Color(1,1,1,1))
	if(variable.turn == 1):
		if(variable.language==1):
			set_text("ตานักโทษ")
		else:
			set_text("PRISONER'S TURN")
	if(variable.turn == 0):
		if(variable.language==1):
			set_text("ตาผู้คุม")
		else:
			set_text("WARDER'S TURN")
	if(variable.winner == 1):
		if(variable.language==1):
			set_text("นักโทษชนะ")
		else:
			set_text("PRISONER WINS")
	if(variable.winner ==2):
		if(variable.language==1):
			set_text("ผู้คุมชนะ")
		else:
			set_text("WARDER WINS")