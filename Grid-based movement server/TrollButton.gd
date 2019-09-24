extends Button

func _on_TrollButton_pressed():
	print("Sending data to client")
	var textToSend = get_parent().get_node("Troll").text
	get_tree().multiplayer.send_bytes(textToSend.to_ascii())