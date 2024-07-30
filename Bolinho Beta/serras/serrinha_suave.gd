extends RigidBody2D

@onready var hitbox_area_x: Area2D = $hitbox_area_x
@onready var hitbox_area_y: Area2D = $hitbox_area_y


@export var speed: float = 10
var velocity: Vector2
var hitbox_cooldown:float = 0.0

func _ready():
	# Inicializa a velocidade em uma direção aleatória
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * speed * 10
	
	
func _physics_process(delta):
	# Aplica a velocidade à serrinha
	#update_hitbox_detection(delta)
	rotation_degrees = 0
	update_hitbox_detection(delta)
	linear_velocity = velocity
	
func update_hitbox_detection(delta: float):
	#temporizador
	hitbox_cooldown -= delta
	if hitbox_cooldown > 0: return
	#frequencia(2x por segundo)_
	hitbox_cooldown = 0.01
	
	
	#colisão x
	var bodies_x = hitbox_area_x.get_overlapping_bodies()
	for body in bodies_x:
		if body.is_in_group("bounce") and (body != self):
			velocity.x = -velocity.x
	
	#colisao y
	var bodies_y = hitbox_area_y.get_overlapping_bodies()
	for body in bodies_y:
		if body.is_in_group("bounce") and (body != self):
			velocity.y = -velocity.y
	
	if bodies_x.size() == 0 and bodies_y.size() == 0: return
	
			
