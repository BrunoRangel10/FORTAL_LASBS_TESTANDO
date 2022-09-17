extends Control


func _on_start_pressed():
		get_tree().change_scene("res://cenas/Mundo.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_tela_inicial_pressed():
	get_tree().change_scene("res://cenas/Menu.tscn")


func _on_reiniciar_pressed():
	get_tree().change_scene("res://cenas/Mundo.tscn")
