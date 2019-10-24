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
func _on_RageQuit_pressed():
	get_tree().set_network_peer(null)
	Grid.empty_grid()
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")
	variable.gameStart = 0
	variable.gameState = 0
	variable.winner = 0
	variable.turn = 0
	
func _process(delta):
	if(variable.language==1):
		get_node("Label").set_text('ยอมแพ้')
	else:
		get_node("Label").set_text('RAGEQUIT')