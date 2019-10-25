extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cursor100_light = preload("res://TitleScreenRelated/cursor100_light.png")
var mute_light = preload("res://TitleScreenRelated/mute_light.png")
var unmute_light = preload("res://TitleScreenRelated/unmute_light.png")
var option_logo_light = preload("res://TitleScreenRelated/prison_options_light.png")
var cursor100 = preload("res://TitleScreenRelated/cursor100.png")
var mute = preload("res://TitleScreenRelated/mute.png")
var unmute = preload("res://TitleScreenRelated/unmute.png")
var option_logo = preload("res://TitleScreenRelated/prison_options.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/Mute.grab_focus()
	if(variable.check==false):
	#get_node('MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Mute_Button').pressed = true
		$MarginContainer/VBoxContainer/VBoxContainer/Mute.set("pressed",true)
		$MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/MuteSymbol.set("pressed",true)

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
	if variable.light_mode == 1 :
		$MarginContainer/VBoxContainer/VBoxContainer/Back.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Mute.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Character_Button.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Language_Button.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/LightMode.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/MuteSymbol.set("texture_normal", unmute_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/MuteSymbol.set("texture_pressed", mute_light)
		$MarginContainer/VBoxContainer/TextureRect.set("texture", option_logo_light)
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/Label').set("custom_colors/font_color", Color(0,0,0))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Character_Button/Label').set("custom_colors/font_color", Color(0,0,0))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Language_Button/Label').set("custom_colors/font_color", Color(0,0,0))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Back/Label').set("custom_colors/font_color", Color(0,0,0))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set("custom_colors/font_color", Color(0,0,0))
		
	if variable.light_mode == 0 :
		$MarginContainer/VBoxContainer/VBoxContainer/Back.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Mute.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Character_Button.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Language_Button.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/LightMode.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/MuteSymbol.set("texture_normal", unmute)
		$MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/MuteSymbol.set("texture_pressed", mute)
		$MarginContainer/VBoxContainer/TextureRect.set("texture", option_logo)
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/Label').set("custom_colors/font_color", Color(1,1,1))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Character_Button/Label').set("custom_colors/font_color", Color(1,1,1))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Language_Button/Label').set("custom_colors/font_color", Color(1,1,1))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Back/Label').set("custom_colors/font_color", Color(1,1,1))
		get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set("custom_colors/font_color", Color(1,1,1))
	
	if(variable.language==1):
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/Label').set_text('ปิดเสียง')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Character_Button/Label').set_text('ตัวละคร')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Language_Button/Label').set_text('ภาษา')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Back/Label').set_text('กลับ')	
		if variable.light_mode == 0 :
			get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('โหมดสว่าง')
		else :
			get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('โหมดมืด')
			
	else: 
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Mute/HBoxContainer/Label').set_text('MUTE')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Character_Button/Label').set_text('CHARACTER')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Language_Button/Label').set_text('LANGUAGE')
		get_node('MarginContainer/VBoxContainer/VBoxContainer/Back/Label').set_text('BACK')
		if variable.light_mode == 0 :
			get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('LIGHT MODE')
		else :
			get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('DARK MODE')
	

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


func _on_LightMode_pressed():
	if variable.light_mode == 0 :
		print("dark mode on")
		variable.light_mode = 1
		
		#if(variable.language == 0):
		#	get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('DARK MODE')
		#else :
		#	get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('โหมดมืด')
	elif variable.light_mode == 1 :
		print("light mode on")
		variable.light_mode = 0
		#if(variable.language == 0):
		#	get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('LIGHT MODE')
		#else :
		#	get_node('MarginContainer/VBoxContainer/VBoxContainer/LightMode/Label').set_text('โหมดสว่าง')
	 # Replace with function body.
	