extends KinematicBody2D

const ORB = preload("res://cenas/kunai_certa.tscn")
var motion = Vector2()
const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
var player_health = 3
var max_health = 3
var enter_state = true
var current_state = 0
enum {IDLE, RUN, JUMP, ATTACK, FALL}
signal change_life(player_health)

func _ready():
	connect("change_life", get_parent().get_node("HUD/Itens_coletados"), "on_change_life")
	emit_signal("change_life", max_health)

	
func _physics_process(delta):
	if Input.is_action_just_pressed("fireball"):
		_atirar_kunai()
	
	
	
	match current_state:
		IDLE:
			_idle_state()
		RUN:
			_run_state()
		JUMP:
			_jump_state()
		ATTACK:
			_attack_state()
		FALL:
			_fall_state()				
	

#gravidade	
func _apply_gravity():
	motion.y += GRAVITY

#movimentacao na cena	
func _move_and_slide():
	motion = move_and_slide(motion, UP)	

	
# 4 ESTADOS:

#parado
func _idle_state():
	$Sprite.play("parado")
	motion.x = 0
	_apply_gravity()
	_move_and_slide()
	_set_state(_check_idle_state()) 

	
func _run_state():
	_move()
	_move_and_slide()	
	_apply_gravity()
	_set_state(_check_run_state()) 


func _move():
	if Input.is_action_pressed("ui_right"):
		$Sprite.play("correndo")
		$Sprite.flip_h = false
		motion.x = SPEED
		if sign($kunai_point.position.x) == -1:
			$kunai_point.position.x *= -1		
	elif Input.is_action_pressed("ui_left"):
		$Sprite.play("correndo")
		$Sprite.flip_h = true
		motion.x = -SPEED
		if sign($kunai_point.position.x) == 1:
			$kunai_point.position.x *= -1
	else:
		motion.x = 0

#atacar	
func _attack_state():
	$Sprite.play("atacando")
	motion.x = 0
	#_atirar_kunai()
	_apply_gravity()
	_move_and_slide()
	
#pular
func _jump_state():
	if enter_state:
		$Sprite.play("pulando")
		$jump.play()
		motion.y = JUMP_HEIGHT	
		enter_state = false	
	_apply_gravity()		
	#_move()
	_move_and_slide()
	_set_state(_check_jump_state()) 
	
#queda - estou usando o sprite de queda para simular a morte
func _fall_state():
	$Sprite.play("pulando")
	_apply_gravity()
	_move()
	_move_and_slide()
	_set_state(_check_fall_state()) 
	
	

#funcoes que verficam os estados
func _check_idle_state():
	var new_state = current_state
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		new_state = RUN
	elif Input.is_action_just_pressed("fireball"):
		new_state = ATTACK
	elif Input.is_action_just_pressed("ui_up"):
		new_state = JUMP
	elif not is_on_floor():
		new_state = FALL
	return new_state	

func _check_run_state():
	var new_state = current_state
	if (not Input.is_action_pressed("ui_right")) and (not Input.is_action_pressed("ui_left")):
		new_state = IDLE
	elif Input.is_action_just_pressed("fireball"):
		new_state = ATTACK
	elif Input.is_action_just_pressed("ui_up"):
		new_state = JUMP
	elif not is_on_floor():
		new_state = FALL
	return new_state	
	#motion = move_and_slide(motion, UP)	
	
func _check_jump_state():
	var new_state = current_state
	if motion.y >= 0:
		new_state = FALL	
	if Input.is_action_just_pressed("fireball"):
		new_state = ATTACK
	return new_state	

func _check_fall_state():
	var new_state = current_state
	if is_on_floor():
		new_state = IDLE
	elif Input.is_action_just_pressed("fireball"):
		new_state = ATTACK
	return new_state	

func _set_state(new_state):
	if new_state != current_state:
		enter_state = true	
	current_state = new_state


func _on_Sprite_animation_finished():
	var anim_name = $Sprite.animation
	if anim_name == "atacando":
		_set_state(IDLE)

func _atirar_kunai():
	var kunai_instance = ORB.instance()
	if sign($kunai_point.position.x) == 1:
		kunai_instance.set_direction(1)
	else:
		kunai_instance.set_direction(-1)	
	get_parent().add_child(kunai_instance)
	kunai_instance.position = $kunai_point.global_position	

func _on_dano_body_entered(body):
	if body.is_in_group("Inimigos"):
		player_health -= 1
	#get_node("anim").play("morrer")
		emit_signal("change_life", player_health)
	#if body.is_in_group("Passagem"):
		#$victory.play()	
	if player_health == 0:
		$".".queue_free()
		get_tree().change_scene("res://cenas/Control.tscn")
		
	#if body.is_in_group("Passagem"):
		#$victory.play()
		#print("tetse")
		
		
		
func _on_pes_body_entered(body):
	body.dano()
	motion.y = JUMP_HEIGHT			
