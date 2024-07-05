extends Node2D

@onready var animated = $AnimatedSprite2D
@export var pickup_amount : int = 1

func _ready():
	animated.play("default")
	
func _on_bottle_health_pickup_body_entered(body):
	if body.is_in_group("Player"):
		HealthManager.increase_health(pickup_amount)
		animated.play("collected")
		await get_tree().create_timer(2.0).timeout
		queue_free()
	
