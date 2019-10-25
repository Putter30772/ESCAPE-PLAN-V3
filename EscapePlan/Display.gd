extends Label

func _ready():
	pass # Replace with function body.

func _process(delta):
	set_text(str(variable.turn))
	add_color_override("font_color", Color(1,1,1,1))

	if(variable.winner == 1):
		if(variable.player_role==1):
			if(variable.language==1):
				set_text(variable.playerName + " ชนะ\nคะแนนคุณ: " + str(variable.score) +"\nคะแนนคู่แข่ง: " + str(variable.opponent_score))
			else:
				set_text(variable.playerName + " WINS\n"+ variable.playerName + "'s score: " + str(variable.score) +"\n"+ variable.opponentName + "'s score: " + str(variable.opponent_score))
		else:
			if(variable.language==1):
				set_text(variable.opponentName + " ชนะ\nคะแนนคุณ: " + str(variable.score) +"\nคะแนนคู่แข่ง: " + str(variable.opponent_score))
			else:
				set_text(variable.opponentName + " WINS\n"+ variable.playerName + "'s score: " + str(variable.score) +"\n"+ variable.opponentName + "'s score: " + str(variable.opponent_score))
	if(variable.winner ==2):
		if(variable.player_role==0):
			if(variable.language==1):
				set_text(variable.playerName + " ชนะ\nคะแนนคุณ: " + str(variable.score) +"\nคะแนนคู่แข่ง: " + str(variable.opponent_score))
			else:
				set_text(variable.playerName + " WINS\n"+ variable.playerName + "'s score: " + str(variable.score) +"\n"+ variable.opponentName + "'s score: " + str(variable.opponent_score))
		else:
			if(variable.language==1):
				set_text(variable.opponentName + " ชนะ\nคะแนนคุณ: " + str(variable.score) +"\nคะแนนคู่แข่ง: " + str(variable.opponent_score))
			else:
				set_text(variable.opponentName + " WINS\n"+ variable.playerName + "'s score: " + str(variable.score) +"\n"+ variable.opponentName + "'s score: " + str(variable.opponent_score))