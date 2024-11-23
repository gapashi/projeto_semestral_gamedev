extends Area2D
class_name Arrow

onready var sprite: Sprite = get_node("Texture")
onready var animation:  AnimationPlayer = get_node("Animation")

var direction: float = 1.0
export(int) var speed = 60
export(int) var damage = 15

func _ready():
	if direction == -1.0:
		sprite.flip_h = true

func _physics_process(delta):
	translate(Vector2(delta * direction * speed, 0))


func on_body_entered(body):
	if body.is_in_group("enemy"):
		body.update_health(damage)
		queue_free()
		
	if body is TileMap:
		animation.play("stuck")
		set_physics_process(false)
	pass


func on_animation_finished(_anim_name: String):
	queue_free()
	pass 
	

func on_screen_exited():
	queue_free()
	pass 
