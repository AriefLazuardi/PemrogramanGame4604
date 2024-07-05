extends Node2D


func _on_shield_pickup_body_entered(body):
	if body.is_in_group("Player"):
		#HealthManager.player_got_shield()
		body.activate_shield()
		print("dapat shield cuy")
		queue_free()
