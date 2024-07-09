extends Node

var max_health : int = 3
var current_health : int
var shield_active: bool = false
var shield_duration: float = 5.0
var shield_timer: Timer

signal on_health_change
signal on_shield_activate
signal on_shield_deactivate
# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	 # Inisialisasi timer untuk shield
	shield_timer = Timer.new()
	add_child(shield_timer)
	shield_timer.wait_time = shield_duration
	shield_timer.one_shot = true
	shield_timer.connect("timeout", Callable(self, "_on_shield_timer_timeout"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func decrease_health(health_amount : int):
	if shield_active:
		print("shield is activate")
		return
	
	current_health -= health_amount
	
	if current_health < 0:
		current_health = 0 
	print("decrease health")
	on_health_change.emit(current_health)
	
func increase_health(health_amount : int):
	current_health += health_amount
	
	if current_health > max_health:
		current_health = max_health
	print("increase health")
	on_health_change.emit(current_health)
		
func activate_shield():
	if shield_active:
		return
	shield_active = true
	shield_timer.start()
	print("Shield activated for", shield_duration, "seconds")
	on_shield_activate.emit()
	
func _on_shield_timer_timeout():
	shield_active = false
	print("Shield deactivated")
	on_shield_deactivate.emit()

# Method ini dipanggil ketika player mendapatkan shield
func player_got_shield():
	activate_shield()	
