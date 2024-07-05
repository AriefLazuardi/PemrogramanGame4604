extends Node2D

@onready var animated = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("player sield jalan")
	animated.play("player_shield")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	queue_free()
