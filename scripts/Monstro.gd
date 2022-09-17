extends KinematicBody2D

var flip = true
#var posicao_inicial
#var posicao_final
var velocity = Vector2.ZERO
var speed = 30
var up = Vector2(0,-1)
#const GRAVITY = 20
var motion = 1
#var cont_ray = 1000
const JUMP_HEIGHT = 200
#var gravity = -1
#var up = Vector2(0,-1)


#func _ready():
	#$Sprite.play("andando")
	#posicao_inicial = $".".position.x
	#posicao_final = posicao_inicial + 100
	
func _physics_process(delta):	
	
	#velocity.y += gravity
	#velocity = move_and_slide(velocity, up)	
	$Sprite.play("andando")
	velocity.x = speed * motion
	velocity = move_and_slide(velocity)
	_verificardor_de_parede()
	_verificar_chao()
	#if motion == 1:
		#$Sprite.flip_h = false
	#else:
		#$Sprite.flip_h = true
	
		
		
		
	
	
		#$Sprite.play("parado")	
	
	#$".".position.y += GRAVITY
	
	
	#if(posicao_inicial <= posicao_final and flip):
		#$".".position.x += velocidade
		#$Sprite.flip_h = false
		#if($".".position.x >= posicao_final):
			#flip = false
	#if($".".position.x >= posicao_inicial and !flip):
		#$".".position.x -= velocidade
		#$Sprite.flip_h = true
		#if($".".position.x <= posicao_inicial):
			#flip = true
func _verificar_chao():
	if is_on_floor():
		pass
	else:	
		velocity.y = JUMP_HEIGHT	
	
	#velocity = move_and_slide(velocity,up)
			
func _verificardor_de_parede():
	if	$RayCast2D.is_colliding() and velocity.x > 0:
			#$Sprite.play("parado")
			$Sprite.flip_h = true
			$RayCast2D.scale.x *= -1 
			motion *= -1
			#cont_ray = cont_ray + $".".position.x
			#print("colidiu")
			#print($".".position.x)
			#print(cont_ray)
	if	$RayCast2D.is_colliding() and velocity.x < 0:
			#print("colidiu")	
			#$Sprite.play("parado")
			#print($".".position.x)
		#	print(cont_ray)
			$Sprite.flip_h = false
			$RayCast2D.scale.x *= -1 
			motion *= -1			
	#else:
		#$Sprite.play("parado")
		#$Sprite.flip_h = false
		#$RayCast2D.scale.x *= -1 
		#motion *= -1		
			
func dano():
	get_node("anim").play("morrer")
	$audioMonstro.play()
	
		
func morrer():
	$".".queue_free()



# só um teste
#func _on_bater_parede_body_entered(body):
	#if body.is_in_group("Mapa"):
		#print("teste")
		
		
