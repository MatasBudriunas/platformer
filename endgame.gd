extends Control

@onready var results_label: RichTextLabel = $VBoxContainer/ResultsLabel
@onready var restart_button: Button = $RestartButton

func _ready():
	load_level_data()
	restart_button.connect("pressed", Callable(self, "_on_restart_button_pressed"))

func load_level_data():
	var config = ConfigFile.new()
	if config.load("user://config.cfg") == OK:
		var levels_data = config.get_value("game", "levels_data", [])
		var results_text = "Results:\n"
		for i in range(levels_data.size()):
			var level_data = levels_data[i]
			results_text += "Level %d\nScore: %d\nTime: %.3f\n\n" % [i + 1, level_data["score"], level_data["time_elapsed"]]
		results_label.text = results_text
		print(results_text)  # Debug print to ensure text is being set

func _on_restart_button_pressed():
	# Clear saved data on restart
	var config = ConfigFile.new()
	config.set_value("game", "levels_data", [])
	config.save("user://config.cfg")
	get_tree().change_scene_to_file("res://Level1.tscn")
