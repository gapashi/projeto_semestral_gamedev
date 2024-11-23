extends KinematicBody2D
class_name Player

const PROJECTTILE: PackedScene = preload("res://scenes/player/arrow.tscn")

onready var sprite: Sprite = get_node("Texture")
onready var spawn_point: Position2D = get_node("SpawnPoint")
onready var animation: AnimationPlayer = get_node("AnimationP")

var velocity: Vector2
var can_attack: bool = true

export(int) var move_speed
export(int) var jump_speed
export(int) var gravity_speed
export(int) var health

func _physics_process(delta):
	Move()
	Jump(delta)
	Attack()
	velocity = move_and_slide(velocity, Vector2.UP)
	sprite.animate(velocity)
	verify_height()
	pass
	
func Move():
	velocity.x = move_speed * get_direction()
	pass
	
func Attack():
	if Input.is_action_just_pressed("ui_attack") and is_on_floor() and can_attack:
		sprite.action_behavior("attack")
		can_attack = false
		pass

func get_direction():
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

func Jump(delta):
	velocity.y += delta * gravity_speed
	
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = -jump_speed

func spawn_projectile():
	var projectile: Arrow = PROJECTTILE.instance()
	projectile.direction = sign(spawn_point.position.x)
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = spawn_point.global_position

func freeze(state: bool):
	animation.play("Idle")
	set_physics_process(state)
	
func update_health(value: int):
	health -= value
	if health <= 0:
		Global.reset()
		var _reload: bool = get_tree().change_scene("res://scenes/management/game_level.tscn")
		return
	sprite.action_behavior("hit")


func verify_height():
	if position.y > 350:
		var _reload: bool = get_tree().change_scene("res://scenes/management/menu.tscn")
	pass
