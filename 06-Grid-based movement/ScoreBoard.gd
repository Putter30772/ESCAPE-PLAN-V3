extends Label

func _ready():
	pass # Replace with function body.

func _process(delta):
	set_text("Score: " + str(variable.score))

