extends Control

@onready var iniciar_button: Button = %iniciar_button
@onready var quit_button: Button = %quit_button


func _process(delta):
	if iniciar_button.is_pressed():
		GameManager.load_level(1)
	
	if quit_button.is_pressed():
		get_tree().quit()
	



 
