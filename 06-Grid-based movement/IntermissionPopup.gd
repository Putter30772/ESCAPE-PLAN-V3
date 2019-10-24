extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func popupmatch():
	$MarginContainer/IntermissionPopup.popup_centered()

func connecting():
	get_node("MarginContainer/IntermissionPopup/Label").set_text("Connecting To Server")

func matching():
	get_node("MarginContainer/IntermissionPopup/Label").set_text("Matching with an Opponent")