extends CharacterBody2D

var speed = 1200

var rocket_scene = preload("res://scenes/rocket.tscn")

@onready var rocket_container = $RocketContainer 

@onready var rocket_shot_sound = $RocketShotSound

signal took_damage


func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	elif Input.is_action_pressed("move_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("move_right"):	
		velocity.x = speed
		
	move_and_slide()

	var screen_size = get_viewport_rect().size

	global_position = global_position.clamp(Vector2(0, 0), Vector2(screen_size.x, screen_size.y))

func shoot():
	rocket_shot_sound.play()
	var rocket_instance: Area2D = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 130

func take_damage():
	emit_signal("took_damage")

func die():
	queue_free()
