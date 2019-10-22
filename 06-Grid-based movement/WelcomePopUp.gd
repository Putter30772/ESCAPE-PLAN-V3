extends WindowDialog

var playerName = variable.playerName

func _ready():
	pass
	
func _process(delta):
	if(variable.gameStart==0):
		popup_centered()
		if(variable.language==1):
			get_node('Label').set_text('สวัสดี, '+ playerName + '\nยินดีต้อนรับสู่ Escape Plan!' + '\nกดปุ่ม "เริ่ม" เพิ่อเริ่มเกม')
			get_node('Start/Label').set_text('เริ่ม')
			get_node('Welcome').set_text('ยินดีต้อนรับ')
		else:
			get_node('Label').set_text('Greetings, '+ playerName + '.\nWelcome to Escape Plan!' + '\nClick the Start Button to Begin Playing.') # Replace with function body.
			get_node('Start/Label').set_text('Start')
			get_node('Welcome').set_text('Welcome')
	