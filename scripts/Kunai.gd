extends KinematicBody2D

export(int) var speed = 200
export(int, "left", "right") var direction = 0


var bullet_dir =-1

func set_direction( dir ):
	self.direction = dir
	
func _physics_process(delta):
	if(direction == 0):
		$Sprite.flip_h = false
		bullet_dir = -1
	else:
		$Sprite.flip_h = true
		bullet_dir = 1
		
#var info = move_and_collide(Vector2(bullet_dir,0) * speed * delta)
	
#if info && info.collider.is_in_group("Camada 3"):
	#info.collider.queue_free()
	#self.queue_free()
#elif info && !info.collider.is_in_group("Camada 3"):
	#self.queue_free()
	
		



