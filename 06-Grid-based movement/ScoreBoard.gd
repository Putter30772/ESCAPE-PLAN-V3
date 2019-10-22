extends Label

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(variable.language==1):
		set_text("คะแนน: " + str(variable.score))
	else:
		set_text("Score: " + str(variable.score))

