extends WindowDialog


func _ready():
	
	pass # Replace with function body.


func _process(delta):
	if(variable.gameState == 2):
		variable.ready = 0
		popup_centered()
	if(variable.language==1):
		get_node("PlayAgain/Label").set_text("เล่นใหม่")
		get_node("Exit/Label").set_text("ออก")
	else:
		get_node("PlayAgain/Label").set_text("Play Again")
		get_node("Exit/Label").set_text("Exit")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



