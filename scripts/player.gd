extends CharacterBody2D

#Variáveis do Player
@onready var end_of_gun = $EndOfGun
@export var speed: float = 300.0
var input_direction : Vector2
var is_dashing : bool = false #se estiver no meio  de um dash
var vida: int = 3

#Variáveis da Bala
@onready var bullet = preload("res://scenes/bullet.tscn")
const BULLET_INACCURATE = 10

# Funções
func  _process(_delta):
	look_at(get_global_mouse_position())

func _physics_process(_delta):
	walk()
	
	if Input.is_action_just_pressed("ui_click"):
		bullet_fire()

func get_input_direction():
	if !is_dashing:
		input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func walk():
	get_input_direction()
	velocity = input_direction * speed
	move_and_slide()

func bullet_fire():
	# Criando instancias da bala
	var bullet_instance = bullet.instantiate()
	bullet_instance.direction = get_global_mouse_position() - global_position
	bullet_instance.global_position = end_of_gun.global_position
	bullet_instance.direction.x += randf_range(-BULLET_INACCURATE, BULLET_INACCURATE)
	bullet_instance.direction.y += randf_range(-BULLET_INACCURATE, BULLET_INACCURATE)
	get_tree().get_root().add_child(bullet_instance)
