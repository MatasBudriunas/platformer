extends Area2D

@export_file("*.tscn") var next_scene

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player = body
		var score = player.score
		var time_elapsed = player.time_passed
		save_level_data(score, time_elapsed)
		get_tree().change_scene_to_file(next_scene)

func save_level_data(score, time_elapsed):
	var config = ConfigFile.new()
	var save_data = []
	if config.load("user://config.cfg") == OK:
		save_data = config.get_value("game", "levels_data", [])
	save_data.append({
		"score": score,
		"time_elapsed": time_elapsed
	})
	config.set_value("game", "levels_data", save_data)
	config.save("user://config.cfg")
