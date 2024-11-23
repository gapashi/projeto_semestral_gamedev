extends StaticBody2D

onready var quest_mark: Sprite = get_node("QuestMark")

var can_interact: bool = false
var player_ref: KinematicBody2D = null
var is_quest_finished: bool = false

export(Array, String) var dialog_text

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_interact") and can_interact:
		can_interact = false
		player_ref.freeze(false)
		
		get_tree().call_group("Interface", "spawn_dialog", self, dialog_text)

func on_body_entered(body):
	if body is Player:
		player_ref = body
		can_interact = true
		quest_mark.visible = true

func on_body_exited(body):
	if body is Player:
		player_ref = null
		can_interact = false
		quest_mark.visible = false

func on_dialog_finished():
	player_ref.freeze(true)
	can_interact = true
