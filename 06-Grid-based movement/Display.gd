extends Label

func _ready():
	pass # Replace with function body.

func _process(delta):
	set_text(str(variable.turn))
	add_color_override("font_color", Color(1,1,1,1))

	if(variable.winner == 1):
		set_text("PRISONER WINS\nYour Score: " + str(variable.score) +"\nOpponent Score: " + str(variable.opponent_score))
	if(variable.winner ==2):
		set_text("WARDER WINS\nYour Score: " + str(variable.score) +"\nOpponent Score: " + str(variable.opponent_score))
