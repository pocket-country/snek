class_name GameOver extends CanvasLayer

@onready var score: Label = %ScoreLabel
@onready var high_score: Label = %HighScoreLabel
@onready var restart: Button = %RestartButton
@onready var quit: Button = %QuitButton

func set_score(n:int):
	score.text = "Final Score: " + str(n)
	
func _on_restart_button_pressed() -> void:
	# works only 'cause we have a simple single scene game
	# This also seems a bit clumsy. See notes in black book
	# TODO check what this does to the score
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	# might want to roll credits or something.

func _notification(what: int) -> void:
# there are _enter_tree() and _exit_tree() that wrap these specific notifications
# so could maybe use those functions here.   Also this is to pause the game behind
# the "UI"
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false
