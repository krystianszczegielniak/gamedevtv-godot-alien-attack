extends Control

@onready var score_label: Label = $Score
@onready var lives_left_label: Label = $LivesLeft

func set_score_label(new_score: int):
	score_label.text = "SCORE: " + str(new_score)

func set_lives_left_label(lives_left: int):
	lives_left_label.text = str(lives_left)
