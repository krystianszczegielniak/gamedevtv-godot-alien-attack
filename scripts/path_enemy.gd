extends Path2D

@onready var pathfollow: PathFollow2D = $PathFollow2D
@onready var enemy = $PathFollow2D/Enemy

func _ready():
	pathfollow.progress_ratio = 1
	
func _process(delta):
	pathfollow.progress_ratio -= 0.25 * delta
	if pathfollow.progress_ratio <= 0:
		queue_free()
