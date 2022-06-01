extends Node

export (PackedScene) var mob_scene
var score
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$LevelTimer.stop()
	$HUD.show_game_over()
	$AudioBackground.stop()
	$AudioGameOver.play()
		
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$MobTimer.wait_time = 0.6
	$StartTimer.start()
	$LevelTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Готовься")
	get_tree().call_group("mobs", "queue_free")
	$AudioBackground.play()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_LevelTimer_timeout():
	if $MobTimer.wait_time > 0.1:
		$MobTimer.wait_time -= 0.05
		$AudioBackground.stop()
		$AudioBackground.pitch_scale += 0.05
		$AudioBackground.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_MobTimer_timeout():
	 
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	#mob.rotation = direction 
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	



