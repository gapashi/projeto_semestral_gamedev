extends KinematicBody2D
class_name Enemy

onready var sprite: Sprite = get_node("Texture")
onready var attack_timer: Timer = get_node("AttackCooldown")
onready var animation: AnimationPlayer = get_node("Animation")

var player_ref: KinematicBody2D = null
var velocity: Vector2

var can_deal_damage: bool = true

export(int) var move_speed
export(int) var distance_treshold
export(int) var enemy_damage
export(int) var health

export(float) var attack_cooldown

func _physics_process(_delta):
	if player_ref == null:
		return
		
	move()
	velocity = move_and_slide(velocity)
	verify_orientation()
	
func move():
	var x_distance: float = player_ref.global_position.x - global_position.x
	var x_direction: float = sign(x_distance)
	
	if abs(x_distance) < distance_treshold and can_deal_damage:
		player_ref.update_health(enemy_damage)
		attack_timer.start(attack_cooldown)
		can_deal_damage = false
		velocity.x = 0
	
	if abs(x_distance) > distance_treshold:
		velocity.x = x_direction * move_speed

func on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func on_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null

func on_timer_timeout():
	can_deal_damage = true
	pass

func update_health(value: int):
	health -= value
	if health <= 0:
		Global.kill_count()
		queue_free()
		return
	animation.play("hit")

func verify_orientation():
	if velocity.x > 0:
		sprite.flip_h = true
		
	if velocity.x < 0:
		sprite.flip_h = false
	pass


func on_animation_finished(_anim_name: String):
	set_physics_process(true)
	animation.play("Idle")
