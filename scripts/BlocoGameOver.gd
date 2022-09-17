extends Area2D

export(String, FILE, "*.tscn") var cenas

	
func _on_BlocoGameOver_body_entered(body):
	$".".queue_free()
	get_tree().change_scene("res://cenas/Control.tscn")
