extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if(variable.check==false):
		get_node('MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Mute_Button').pressed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Mute_Button_pressed():
	AudioServer.set_bus_mute(0,variable.check)
	variable.check = !variable.check # Replace with function body.


func _on_TextureButton_pressed():
	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn") # Replace with function body.
