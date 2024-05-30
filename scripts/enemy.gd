extends Area2D

@export var speed = 1200
signal died 

func _physics_process(delta):
	global_position.x -= delta * speed

func die():
	emit_signal("died")
	queue_free()


func _on_body_entered(body:Node2D):
	body.take_damage()
	die()
