extends Button


func on_back_button_pressed():
	var _change_scene: bool = get_tree().change_scene("res://scenes/management/menu.tscn")


func on_mouse_exited():
	modulate.a = 1.0


func on_mouse_entered():
	modulate.a = 0.8
