extends CharacterBody2D

@export var damage_amount : int = 1
@onready var animated = $AnimatedSprite2D

enum State {idle, walk}
var current_state : State
var mushroom_walk : bool

func _ready():
	current_state = State.idle

func _physics_process(delta : float):
	move_and_slide()
	
	enemy_animation()
	

func enemy_animation():
	if current_state == State.idle && !mushroom_walk:
		animated.play("idle")

