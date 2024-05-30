extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var ui = $UI
@onready var hud = $UI/HUD

@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_take_damage_sound = $PlayerTakeDamageSound

var game_over_scene = preload("res://scenes/game_over_scene.tscn")

var lives: int = 3
var score: int = 0

func _ready():
	hud.set_score_label(score)

func _on_deathzone_area_entered(area: Area2D):
	area.queue_free()

func _on_player_took_damage():
	player_take_damage_sound.play()
	lives -= 1
	hud.set_lives_left_label(lives)
	if lives == 0: 
		player.die()
		
		await get_tree().create_timer(1.5).timeout
		
		var game_over_scene_instance = game_over_scene.instantiate()
		ui.add_child(game_over_scene_instance)
		game_over_scene_instance.set_score(score)


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	add_child(enemy_instance)
	enemy_instance.connect("died", _on_enemy_died)
	
func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()

func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
	
