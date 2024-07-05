extends CharacterBody2D

@export var patrol_marks : Node
@export var speed : int  = 1500
@export var wait_time : int = 3
@export var health_amount : int = 3
@export var damage_amount : int = 1
@onready var animated = $AnimatedSprite2D
@onready var animated_timer =$Timer

enum State {idle, walk}
var current_state : State
var direction : Vector2 = Vector2.LEFT
var number_of_marks : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int 
var grimripper_walk : bool

func _ready():
	if patrol_marks != null:
		number_of_marks = patrol_marks.get_children().size()
		for marks in patrol_marks.get_children():
			point_positions.append(marks.global_position)
		current_point = point_positions[current_point_position]	
	else :
		print("No Mark Points")
		 
	animated_timer.wait_time = wait_time
	
	current_state = State.idle

	
	
func _physics_process(delta : float):
	enemy_idle(delta)
	enemy_walk(delta)
	
	move_and_slide()
	
	enemy_animation()
	

func enemy_idle(delta : float):
	if !grimripper_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state= State.idle

func enemy_walk(delta : float):
	if !grimripper_walk:
		return
	
	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.walk
	else :
		current_point_position += 1 
	
		if current_point_position >= number_of_marks:
			current_point_position = 0
	
		current_point = point_positions[current_point_position]	
		
	
		if current_point.x > position.x :
			direction = Vector2.RIGHT
		else :
			direction = Vector2.LEFT
		
		grimripper_walk = false 
		animated_timer.start()
	
	animated.flip_h = direction.x < 0

func enemy_animation():
	if current_state == State.idle && !grimripper_walk:
		animated.play("idle")
	elif current_state == State.walk && grimripper_walk:
		animated.play("walk")

func _on_timer_timeout():
	grimripper_walk = true
