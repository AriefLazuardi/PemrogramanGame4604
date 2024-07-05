extends CharacterBody2D
@onready var animated = $AnimatedSprite2D
@onready var hit_animation_player = $HitAnimationPlayer


var player_death_effect = preload("res://assets/maincharacter/player_death_effect.tscn")
var player_shield_effect = preload("res://assets/maincharacter/player_shield.tscn")

@export var speed = 180
@export var jump = -300
@export var jump_horizontal = 100
@export var jump_count = 2

const GRAVITY = 980
enum State { idle, run, jump }

var current_state : State
var shield_activate : bool = false
var current_jump_count : int

func _ready():
	current_state = State.idle
	pass

func _physics_process(delta:float):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	move_and_slide()
	player_animation()

func player_falling(delta:float):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(delta:float):
	if is_on_floor():
		current_state = State.idle

func player_jump(delta:float):
	var jump_input : bool = Input.is_action_just_pressed("jump")
	
	if is_on_floor() and jump_input:
		current_jump_count = 0 
		current_state = State.jump
		current_jump_count += 1
		velocity.y = jump
		
	if !is_on_floor() and jump_input and current_jump_count < jump_count:
		velocity.y = jump
		current_jump_count += 1
		current_state = State.jump
		
	if not is_on_floor() and current_state == State.jump:
		var direction = input_movement()
		velocity.x += direction * jump_horizontal * delta 	
	
func player_run(delta:float):
	var direction = input_movement()
	
	if direction:
		velocity.x = direction * speed
	else :
		velocity.x = move_toward(velocity.x, 0 , speed)
	if direction != 0:
		current_state = State.run
		animated.flip_h = false if direction > 0 else true
	
func player_animation():
	if current_state == State.idle:
		animated.play("idle")
	elif current_state == State.run:
		animated.play("run")
	elif current_state == State.jump:
		animated.play("jump")

func player_death():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	get_parent().add_child(player_death_effect_instance)
	
	queue_free()

func _reload_scene():
	print("Reloading scene...")
	get_tree().reload_current_scene()
	

func activate_shield() -> void:
	if shield_activate:
		print("shield sudah berjalan aiaiai")
		return  
		
	shield_activate = true
	var player_shield_effect_instance = player_shield_effect.instantiate() as Node2D
	player_shield_effect_instance.name = "PlayerShield"
	add_child(player_shield_effect_instance)
	player_shield_effect_instance.position = Vector2.ZERO
	await get_tree().create_timer(5.0).timeout
	print("shield deactivate")
	player_shield_effect_instance.queue_free()
	shield_activate = false
	
func input_movement():
	var direction : float = Input.get_axis("move_left", "move_right")
	
	return direction


func _on_hurt_box_body_entered(body : Node2D):
	if body.is_in_group("Enemy"):
		print("Enemy Entered", body.damage_amount)
		if !shield_activate:
			hit_animation_player.play("hit")
			HealthManager.decrease_health(body.damage_amount)
	
	if HealthManager.current_health == 0 :
		player_death()
		
