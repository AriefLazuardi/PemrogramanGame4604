extends Node
var main_menu_screen = preload("res://ui/main_menu_screen.tscn")
var level_1 = preload("res://level/test_level/test_level.tscn")
var pause_menu_screen = preload("res://ui/pause_menu_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(Color(0.14,0.01,0.18,1.00))
	
	SettingsManager.load_settings()

func start_game():
	if get_tree().paused:
		continue_game()
		return
	
	transition_to_scene()
	
	
func exit_game():
	get_tree().quit()
	
func transition_to_scene():
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(level_1.resource_path)

func pause_game():
	get_tree().paused = true
	var pause_menu_screen_instance = pause_menu_screen.instantiate()
	get_tree().get_root().add_child(pause_menu_screen_instance)
	

	
func continue_game():
	get_tree().paused = false
	
func main_menu():
	var main_menu_screen_instance = main_menu_screen.instantiate()
	get_tree().get_root().add_child(main_menu_screen_instance)
