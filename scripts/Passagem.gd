extends Area2D

export(String, FILE, "*.tscn") var cenas


func _on_Passagem_body_entered(body):
	#$victory.play()
	if body.is_in_group("PLAYER"):
		$victory.play()
		#print("teste")
		#get_tree().change_scene(cenas)
	#print("teste")
	if body.is_in_group("ProximaFase"):
		get_tree().change_scene(cenas)
		



