extends Control

func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
		
func on_button_pressed(button: Button):
	match button.name:
		"StartGame":
			var _game: bool = get_tree().change_scene("res://scenes/management/game_level.tscn")
		
		"Controllers":
			var _control: bool = get_tree().change_scene("res://scenes/management/controllers_menu.tscn")
		
		"Exit":
			var _open_channel: bool = OS.shell_open("https://gapashi.itch.io/")

func mouse_interaction(button: Button, state: String):
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.8
