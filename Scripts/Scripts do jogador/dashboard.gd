extends Node2D

@onready var veloc = $veloc
@onready var rpm = $rpm
@onready var gas = $gas
@onready var temp = $temp
@onready var player = get_node("/root/main/PlayerManager")
@onready var engine = get_node("/root/main/PlayerManager/engine_sound")
var rpmN:float

@export var LOWRPM: AudioStream
@export var LOWMIDRPM: AudioStream
@export var MIDRPM: AudioStream
@export var HIGHRPM: AudioStream
@export var HIGHESTRPM: AudioStream

func _ready() -> void:
	engine.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_dashMove(delta)
	

func _dashMove(delta):
	var Bgas = player.bikeGas
	var Btemp = player.temp
	gas.rotation = lerp_angle(gas.rotation,9.1+Bgas*-0.02, delta * 7)
	temp.rotation = lerp_angle(temp.rotation, 32.2+Btemp*0.09, delta * 3)
	
	var speed = player.speed
	if player.engRpm > 0:
		rpm.rotation = lerp_angle(rpm.rotation, rpmN * 0.1, delta * 5)
		if veloc.rotation < speed:
			veloc.rotation = lerp_angle(veloc.rotation, 83+(speed * 0.024), delta * 7)
		match player.engRpm:
			10:
				rpmN = 14
				engine.set_stream(LOWRPM)
				engine.set_pitch_scale(1)
			20:
				rpmN = 18
				engine.set_pitch_scale(1.2)
			30:
				rpmN = 24
				engine.set_pitch_scale(1.4)
			40:
				engine.set_stream(LOWMIDRPM)
				rpmN = 28
				engine.set_pitch_scale(1.0)
			50:
				rpmN = 32
				engine.set_pitch_scale(1.2)
			60:
				rpmN = 36
				engine.set_pitch_scale(1.4)
			70:
				engine.set_stream(MIDRPM)
				rpmN = 40
				engine.set_pitch_scale(1)
			80:
				rpmN = 44
				engine.set_pitch_scale(1.2)
			90:
				rpmN = 48
				engine.set_pitch_scale(1)
				engine.set_stream(HIGHRPM)
			100:
				rpmN = 52
				engine.set_stream(HIGHESTRPM)
				engine.set_pitch_scale(1.3)
	else:
		rpm.rotation = lerp_angle(rpm.rotation, 849.3, delta * 5)
		veloc.rotation = lerp_angle(veloc.rotation, 604.3, delta * 1)
		engine.stop()
	
