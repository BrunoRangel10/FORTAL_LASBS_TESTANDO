extends Area2D


const SPEED = 300
var velocity = Vector2.ZERO
var direction = 1
var inimigo = load("res://script/Monstro.gd")


func set_direction(dir):
	direction = dir
	if direction == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h =  true

func _physics_process(delta):
	velocity.x = SPEED * direction * delta
	translate(velocity)


func _on_destrutor_kunai_screen_exited():
	queue_free()

		
func _on_kunai_certa_body_entered(body):
	if body.is_in_group("Inimigos"):
		#funcao que esta la no script do monstro pra tirar ele da cena
		body.dano()
		
		#print("teste no inimigo")
		queue_free()
	if body.is_in_group("Mapa"):
		#print("teste no mapa")
		queue_free()
