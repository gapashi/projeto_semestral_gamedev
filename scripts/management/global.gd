extends Node


var enemies_dict: Dictionary = {
	3: "",
	7: ""
}

var enemies_killed: int = 0

func kill_count():
	enemies_killed += 1
	if enemies_dict.has(enemies_killed):
		var dict_value = enemies_dict[enemies_killed]
		dict_value.is_quest_finished = true


func reset():
	enemies_killed = 0
