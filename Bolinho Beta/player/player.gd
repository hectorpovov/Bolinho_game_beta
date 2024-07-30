class_name Player
extends CharacterBody2D


@onready var sprite: AnimatedSprite2D = %Sprite2D
@onready var hitbox_area: Area2D = $hitbox_area


# Variáveis para controlar a velocidade do player
@export var speed: float = 3
@export_range(0,1) var lerp_factor: float = 0.5


var hitbox_cooldown:float = 0.0

@export_category("troca de cena")
@export var restart: PackedScene
@export var restart_end: PackedScene

func _ready():
	GameManager.player = self

func _process(delta):
	#processar dano
	if GameManager.star_number == 3:
		GameManager.next_level()
	update_hitbox_detection(delta)

func _physics_process(delta):

	var coletor = hitbox_area.get_overlapping_areas()
	for body in coletor:
		if body.is_in_group("estrelas"):
			GameManager.star_number += 1
			print(GameManager.star_number)
			body.queue_free()
	if GameManager.star_number == 3:
		GameManager.reset()
		GameManager.next_level()
	# Captura a entrada do usuário
	var input_vector = Input.get_vector("move_left","move_right","move_up","move_down", 0.15)
	
	# Normaliza a velocidade para evitar movimento mais rápido na diagonal
	
	var target_velocity = input_vector * speed * 100
	velocity = lerp(velocity, target_velocity, lerp_factor)
	move_and_slide()
	# Move o player
	
	#girar sprite 
	if input_vector.x > 0:
		#desmarcar flip_h de sprite2D
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true
		# marcar flip_h do sprite2D
	
	

	



func update_hitbox_detection(delta: float):
	#temporizador
	hitbox_cooldown -= delta
	if hitbox_cooldown > 0: return
	#frequencia(2x por segundo)_
	hitbox_cooldown = 0.0
	
	var bodies = hitbox_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			Die()
			
	pass


# Função para matar o player
func Die():
	print("morreu")
	GameManager.reset()
	var var_restart = restart.instantiate()
	get_parent().add_child(var_restart)


func play_restart_animation():
	print("ta rodando a função")
	var var_restart_end = restart_end.instantiate()

	get_parent().add_child(var_restart_end)
	pass
	

