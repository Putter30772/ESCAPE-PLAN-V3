extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/Play.grab_focus()
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Play.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Play.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Option.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Option.grab_focus()
		
#func _on_Play_pressed():
#	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")

func _on_Play_pressed():
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn") # Replace with function body.
