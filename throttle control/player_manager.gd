extends Node2D
@onready var stats = get_node("/root/main/EngStats")
@onready var mess = get_node("/root/main/Messages")
@export var playerName = ""
var speed = 0
@export var bikeGas = 2
@export var engRpm = 0
var isTravel = false
var currPos = 0
#timer se refere à distância de um lugar a outro
var timer = 0
var nextPos = 0
var temp: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Configura o texto das caixas de texto.
	mess.set_text(str("\nYou are currently at ", currPos))
	stats.set_text(str(engRpm, "rpm x100", "\nEngine temp: ",snappedf(temp, 0.1), "\n Player:", playerName, "\n Time left to destination is: ", snappedf(timer, 0.1),"\n istravel?: ", isTravel, "\n Gas: ", snappedf(bikeGas, 0.1), "\nSpeed: ", snappedf(speed, 1)))
	
	#Funções que rodam em todo frame
	_rpm_multi(delta)
	_gas(delta)
	_speed_calc(delta)
	_eng_temp(delta)
	
	#Diz se o player tá viajando ou não
	if timer <= 0.0:
		isTravel = false
	else: 
		isTravel = true
	
	#Desliga o motor fora de viagem
	if isTravel == false:
		engRpm = 0
 
func _rpm_multi(delta):
	if timer > 0.0 && bikeGas > 0:
		timer -= (1 * (speed * 0.1)) * delta

func _gas(delta):
	if bikeGas > 0:
		bikeGas -= (0.08 * ((engRpm) * 0.1)) * delta

func _speed_calc(delta):
	var speed_limit: float
	match engRpm:
		0:
			if speed > 0:
				speed -= 30 * delta
		10:
			speed_limit = 10
		20:
			speed_limit = 17
		30:
			speed_limit = 24
		40:
			speed_limit = 36
		50: 
			speed_limit = 48
		60:
			speed_limit = 58
		70:
			speed_limit = 70
		80:
			speed_limit = 85
		90:
			speed_limit = 98
		100:
			speed_limit = 130
	if speed < speed_limit:
		speed += (2 * (engRpm * 0.07)) * delta
	else:
		speed -= (3 + (engRpm *.03)) * delta

func _eng_temp(delta):
	if engRpm > 0:
		temp += (0.5 * (engRpm * 0.01)) * delta
	if engRpm == 0 && temp > 0:
		temp -= 0.05 * delta
