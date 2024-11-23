extends Sprite
class_name PlayerAnimation

onready var spawn_point: Position2D = get_node("%SpawnPoint")
onready var animation: AnimationPlayer = get_node("%AnimationP")
onready var parent: KinematicBody2D = get_parent()
var on_action: bool = false

func animate(velocity: Vector2):
	verify_orientation(velocity.x)
	
	if on_action:
		return
	
	if velocity.y != 0:
		vertical_behavior(velocity.y)
		return
		
	horizontal_behavior(velocity.x)

func verify_orientation(speed: float):
	if speed > 0:
		flip_h = false
		spawn_point.position = Vector2(9, 6)
		
	if speed < 0:
		flip_h = true
		spawn_point.position = Vector2(-9, 6)
		
		
func action_behavior(action: String):
	on_action = true
	animation.play(action)
	pass
	
func vertical_behavior(speed: float):
	if speed > 0:
		animation.play("fall")
		
	if speed < 0:
		animation.play("jump")
		
func horizontal_behavior(speed: float):
	if speed != 0:
		animation.play("run")
		return
	
	animation.play("Idle")


func on_animation_finished(anim_name: String):
	if anim_name == "attack":
		on_action = false
		parent.can_attack = true
		parent.set_physics_process(true)
		pass
	
	if anim_name == "hit":
		on_action = false
		parent.can_attack = true
		parent.set_physics_process(true)
