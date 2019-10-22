extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Back_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Back_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Hard_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Hard_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Normal_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Normal_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.grab_focus()

func _on_Hard_Button_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 1
	get_tree().change_scene("res://LAN.tscn")


func _on_Normal_Button_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 2
	get_tree().change_scene("res://LAN.tscn")


func _on_Easy_Button_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 1
	get_tree().change_scene("res://LAN.tscn")


func _on_Back_Button_pressed():
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")
