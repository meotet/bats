extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	$AnimatedSprite.animation = "bat"

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
