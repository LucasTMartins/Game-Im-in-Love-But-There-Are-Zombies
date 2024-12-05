extends CharacterBody2D
 
#@onready var player = get_node("/root/MainScene/Player")
var speed: float = 270
var player: Node2D
var direction = Vector2.ZERO
var vida: int = 3

func _ready():
	add_to_group("enemy")
	player = get_node("/root/MainScene/Player")

func _process(_delta):
	if vida <= 0:
		queue_free()

func _physics_process(_delta):
	set_rotation(direction.angle())
	
	if player:
		direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func atualiza_vida(dano):
	vida -= dano

func _on_area_attack_body_entered(body):
	if body.is_in_group("player"):
		body.atualiza_vida(1)
