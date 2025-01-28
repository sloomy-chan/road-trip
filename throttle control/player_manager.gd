extends Node2D
@onready var stats = get_node("/root/main/EngStats")
@export var playerName = ""
@export var playerHunger = 0
@export var engRpm = 0
var isTravel = false
var currPos = 0
var timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stats.set_text(str(engRpm, " rpm x100", "\n current position is ",currPos, "\n Player:", playerName, "\n Time left to destination is: ", timer,"\n istravel?: ", isTravel))
	_rpm_multi(delta)
	if timer <= 0.0:
		isTravel = false
	else: 
		isTravel = true
 
func _rpm_multi(delta):
	if timer > 0.0:
		timer -= (1 * (engRpm * 0.3)) * delta
