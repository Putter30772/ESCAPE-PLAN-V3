extends WindowDialog

var playerName = variable.playerName

func _ready():
	pass
	
func _process(delta):
	if(variable.gameStart==0):
		popup_centered()
		get_node('Label').set_text('Greetings, '+ playerName + '\nWelcome to Escape Plan' + '\nClick the Start Button to Begin Playing') # Replace with function body.
	