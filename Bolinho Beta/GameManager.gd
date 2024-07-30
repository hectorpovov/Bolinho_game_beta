extends Node


var player: Player
var player_position: Vector2
var star_number: int = 0 
var current_level: int = 1

#func _ready():
	#_find_player()

	
func load_level(level: int):
	current_level = level
	get_tree().change_scene_to_file("res://scenes/niveis/level_" + str(level) + ".tscn")
	#call_deferred("_find_player")
	print(player)
	print(current_level)
	if player != null:
		print("passou do if")
		player.play_restart_animation()


func load_level_again(level: int):
	current_level = level
	get_tree().change_scene_to_file("res://scenes/niveis/level_" + str(level) + ".tscn")
	#call_deferred("_find_player")
	print(player)
	if player != null:
		print("passou do if")
		player.play_restart_animation()
	

func next_level():
	current_level += 1
	load_level(current_level)

func restart_level():
	load_level_again(current_level)


func reset():
	star_number = 0

func _find_player():
	var root = get_tree().get_first_node_in_group("player")
	print(root)
	
	player = root.get_node("Player")
	if player == null:
		print("Player not found after loading level!")
