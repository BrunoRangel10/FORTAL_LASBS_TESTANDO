extends KinematicBody2D 
 
const ORB = preload("res://cenas/kunai_certa.tscn")

var motion = Vector2()
const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500

var player_health = 3
var max_health = 3


signal change_life(player_health)

func _ready():
	connect("change_life", get_parent().get_node("HUD/Itens_coletados"), "on_change_life")
	emit_signal("change_life", max_health)

func _physics_process(delta):
	#$Sprite.play("atacando")
	
	motion.y += GRAVITY
	
	if Input.is_action_just_pressed("fireball"):
		atirar_kunai()
	
	
	
	
	#if Input.is_action_pressed("atirar"):
		#$Sprite.play("atacando")	
	
	if Input.is_action_pressed("ui_right"):
		
		motion.x = SPEED
		if sign($kunai_point.position.x) == -1:
			$kunai_point.position.x *= -1
		$Sprite.play("correndo")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		if sign($kunai_point.position.x) == 1:
			$kunai_point.position.x *= -1
		$Sprite.play("correndo")
		$Sprite.flip_h = true
	else:
		motion.x = 0
		$Sprite.play("parado")
	
	motion = move_and_slide(motion, UP)		
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT				
	
	else:$Sprite.play("pulando")
	
	motion = move_and_slide(motion, UP)
		

func _on_pes_body_entered(body):
	body.dano()
	motion.y = JUMP_HEIGHT	


func _on_dano_body_entered(body):
	
	player_health -= 1
	#get_node("AnimationPlayer").play("sofrer_dano")
	emit_signal("change_life", player_health)

	if player_health == 0:
		$".".queue_free()
		get_tree().change_scene("res://cenas/Control.tscn")
		
func atirar_kunai():
	#tiro de kunai
	
		#$Sprite.play("correndo")
		var kunai_instance = ORB.instance()
		if sign($kunai_point.position.x) == 1:
			kunai_instance.set_direction(1)
		else:
			kunai_instance.set_direction(-1)	
		get_parent().add_child(kunai_instance)
		kunai_instance.position = $kunai_point.global_position		



	
		



	

	
