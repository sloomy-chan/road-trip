extends Node2D
@onready var stats = get_node("/root/main/EngStats")
@onready var mess = get_node("/root/main/Messages")
@export var playerName = ""
@export var bikeGas = 2
@export var engRpm = 0
var isTravel = false
var currPos = 0
var timer = 0
var nextPos = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mess.set_text(str("\nYou are currently at ", currPos))
	stats.set_text(str(engRpm, " rpm x100", "\n Player:", playerName, "\n Time left to destination is: ", snappedf(timer, 0.1),"\n istravel?: ", isTravel, "\n Gas: ", snappedf(bikeGas, 0.1)))
	_rpm_multi(delta)
	_gas(delta)
	if timer <= 0.0:
		isTravel = false
	else: 
		isTravel = true
	
	if isTravel == false:
		engRpm = 0
 
func _rpm_multi(delta):
	if timer > 0.0 && bikeGas > 0:
		timer -= (1 * (engRpm * 0.1)) * delta

func _gas(delta):
	if bikeGas > 0:
		bikeGas -= (0.1 * (engRpm * 0.1)) * delta
