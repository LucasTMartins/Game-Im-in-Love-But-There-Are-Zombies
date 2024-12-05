extends Area2D

const SPEED = 1000.0

var direction = Vector2.ZERO

func _ready():
	set_rotation(direction.angle())

# MOVIMENTAÇÃO DA BALA
func _physics_process(_delta):
	translate(direction.normalized() * SPEED * _delta)

# DELETA A BALA QUANDO SAI DA CENA
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.atualiza_vida(1)
		queue_free()
