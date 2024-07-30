
extends Control

@onready var restart_button:Button = %restart_button
@onready var quit_button: Button = %quit_button

func _process(delta):
	
	if restart_button.is_pressed():
		GameManager.load_level(1)
		
	if quit_button.is_pressed():
		get_tree().quit()
