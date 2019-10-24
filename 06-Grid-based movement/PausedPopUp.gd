extends WindowDialog

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(variable.pause==1):
		popup_centered()
		if(variable.language==1):
			get_node("Label").set_text("เกมส์ของคุณถูกหยุดชั่วคราว \nกดปุ่่ม 'เล่นต่อ' เพื่อเล่นเกมส์ต่อ")
			get_node("Paused").set_text("เกมส์หยุดชั่วคราว")
			get_node("Continue/Label").set_text("เล่นต่อ")
		else:
			get_node("Label").set_text("Your game has been paused. \nClick 'Continue' to continue playing.")
			get_node("Paused").set_text("Paused")
			get_node("Continue/Label").set_text("Continue")
	else: 
		hide()

func _on_Continue_pressed():
	Lobby.continueGame(Lobby.session_id)
	variable.pause = 0
	 # Replace with function body.
