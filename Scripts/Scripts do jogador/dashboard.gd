extends Node2D

@onready var veloc = $veloc
@onready var rpm = $rpm
@onready var gas = $gas
@onready var temp = $temp
@onready var player = get_node("/root/main/PlayerManager")
@onready var engine = get_node("/root/main/PlayerManager/engine_sound")
var rpmN:float

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
				engine.set_pitch_scale(1)
			20:
				rpmN = 18
				engine.set_pitch_scale(1.2)
			30:
				rpmN = 24
				engine.set_pitch_scale(1.4)
			40:
				rpmN = 28
				engine.set_pitch_scale(1.6)
			50:
				rpmN = 32
				engine.set_pitch_scale(1.8)
			60:
				rpmN = 36
				engine.set_pitch_scale(2.0)
			70:
				rpmN = 40
				engine.set_pitch_scale(2.2)
			80:
				rpmN = 44
				engine.set_pitch_scale(2.4)
			90:
				rpmN = 48
				engine.set_pitch_scale(2.6)
			100:
				rpmN = 52
				engine.set_pitch_scale(2.65)
	else:
		rpm.rotation = lerp_angle(rpm.rotation, 849.3, delta * 5)
		veloc.rotation = lerp_angle(veloc.rotation, 604.3, delta * 1)
		engine.stop()
	
