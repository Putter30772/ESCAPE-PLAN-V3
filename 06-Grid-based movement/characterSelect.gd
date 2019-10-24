extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skins = null
var skins2 = null

# Called when the node enters the scene tree for the first time.
func _ready():
	skins = $MarginContainer/VBoxContainer/Prisoner.get_children()
	skins2 = $MarginContainer/VBoxContainer/Warden.get_children()
	skins[variable.skin_select].set("pressed", true)
	skins2[variable.skin2_select].set("pressed", true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if(variable.language==1):
		get_node('MarginContainer/VBoxContainer/Text1').set_text('นักโทษ')
		get_node('MarginContainer/VBoxContainer/Text2').set_text('ผู้คุม')
		get_node('MarginContainer/VBoxContainer/back/Label').set_text('กลับ')
	else: 
		get_node('MarginContainer/VBoxContainer/Text1').set_text('PRISONER')
		get_node('MarginContainer/VBoxContainer/Text2').set_text('WARDEN')
		get_node('MarginContainer/VBoxContainer/back/Label').set_text('BACK')

func _on_back_pressed():
	get_tree().change_scene("res://options.tscn")

 # Replace with function body.


func _on_Skin1_pressed():
	variable.skin_select = 0
	for i in range(4):
		if i != 0:
			skins[i].set("pressed", false)

func _on_Skin2_pressed():
	variable.skin_select = 1
	for i in range(4):
		if i != 1:
			skins[i].set("pressed", false)
	
func _on_Skin3_pressed():
	variable.skin_select = 2
	for i in range(4):
		if i != 2:
			skins[i].set("pressed", false)
			
func _on_Skin4_pressed():
	variable.skin_select = 3
	for i in range(4):
		if i != 3:
			skins[i].set("pressed", false)	 # Replace with function body.


func _on_1_pressed():
	variable.skin2_select = 0
	for i in range(4):
		if i != 0:
			skins2[i].set("pressed", false) # Replace with function body.


func _on_2_pressed():
	variable.skin2_select = 1
	for i in range(4):
		if i != 1:
			skins2[i].set("pressed", false) # Replace with function body.

func _on_3_pressed():
	variable.skin2_select = 2
	for i in range(4):
		if i != 2:
			skins2[i].set("pressed", false) 

func _on_4_pressed():
	variable.skin2_select = 3
	for i in range(4):
		if i != 3:
			skins2[i].set("pressed", false) 
