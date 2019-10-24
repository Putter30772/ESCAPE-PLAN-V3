extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/Mute.grab_focus()
	if(variable.check==false):
		get_node('MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Mute_Button').pressed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _on_Mute_Button_pressed():
#	$MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/MuteSymbol.pressed
#	AudioServer.set_bus_mute(0,variable.check)
#	variable.check = !variable.check # Replace with function body.

#func _on_TextureButton_pressed():
#	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn") # Replace with function body.

func _on_Language_Button_pressed():
	get_node('WindowDialog').popup_centered()

func _on_English_pressed():
	variable.language = 0 
	get_node("WindowDialog").hide()

func _on_Thai_pressed():
	variable.language = 1
	get_node("WindowDialog").hide()
	
func _process(delta):
	if(variable.language==1):
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/Label').set_text('ปิดเสียง')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Character_Button/Label').set_text('ตัวละคร')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Language_Button/Label').set_text('ภาษา')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Back/Label').set_text('กลับ')
	else: 
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/Label').set_text('MUTE')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Character_Button/Label').set_text('CHARACTER')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Language_Button/Label').set_text('LANGUAGE')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Back/Label').set_text('BACK')
	

func _on_Back_pressed():
	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn") # Replace with function body.


func _on_Mute_pressed():
	$MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/MuteSymbol.set("pressed", variable.check)
	AudioServer.set_bus_mute(0,variable.check)
	variable.check = !variable.check # Replace with function body.
	
func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Back.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Back.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Character_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Character_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Mute.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Mute.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Language_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Language_Button.grab_focus()


func _on_Character_Button_pressed():
	get_tree().change_scene("res://characterSelect.tscn") # Replace with function body.
