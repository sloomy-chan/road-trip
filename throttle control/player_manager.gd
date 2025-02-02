extends Node2D
@onready var stats = get_node("/root/main/EngStats")
@onready var mess = get_node("/root/main/Messages")
@export var playerName = ""
var speed = 0
@export var bikeGas = 2
@export var engRpm = 0
var isTravel = false
var currPos = 0
var mod: float #É o modificador de consumo de combustível
var smod: float
#timer se refere à distância de um lugar a outro
var timer = 0
var nextPos = 0
var temp = 0
var event_timer = 10
var eventNmbr = 10
var speed_limit: float

func _process(delta: float) -> void:
	#Configura o texto das caixas de texto.
	mess.set_text(str("\nYou are currently at ", currPos))
	stats.set_text(str(engRpm, "rpm x100", "\nEngine temp: ",snappedf(temp, 0.1), "\n Player:", playerName, "\n Time left to destination is: ", snappedf(timer, 0.1),"\n istravel?: ", isTravel, "\n Gas: ", snappedf(bikeGas, 0.1), "\nSpeed: ", snappedf(speed, 1)))
	
	#Funções que rodam em todo frame
	_rpm_multi(delta)
	_gas(delta)
	_speed_calc(delta)
	_eng_temp(delta)
	
	#Diz se o player tá viajando ou não, e se ele tem gasosa
	if bikeGas > 0:
		if timer <= 0.0:
			isTravel = false
		else: 
			isTravel = true
	else:
		isTravel = false
	
	#Desliga o motor fora de viagem
	if isTravel == false:
		engRpm = 0
		mod = 0
		smod = 0
		event_timer = 10
		
	
	#Gerencia a geração de eventos na caixa de texto
	if isTravel == true && speed > 0:
		event_timer -= 1 * delta
	if isTravel == true && event_timer < 0:
		event_timer += 10
		eventNmbr = randi_range(0,5)
		_event_generator()	

 
func _rpm_multi(delta):
	if timer > 0.0 && bikeGas > 0:
		timer -= (1 * (speed * 0.1)) * delta

func _gas(delta):
	if bikeGas > 0:
		bikeGas -= (0.08 * ((engRpm) * 0.1) + mod) * delta

func _speed_calc(delta):
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
		speed += (2 * (engRpm * 0.07) + smod) * delta
	else:
		speed -= (3 + (engRpm *.03)) * delta

func _eng_temp(delta):
	if engRpm > 0 && temp < 15:
		temp += (0.5 * (engRpm * 0.01)) * delta
	if engRpm == 0 && temp > 0:
		temp -= 0.05 * delta
	
	match temp:
		7:
			mess.add_text(str("\nYour engine is in its ideal temperature."))
			print("temp good")
		11:
			mess.add_text(str("\nYour engine is slightly hot"))
			print("temp hot")
		15.0:
			mess.add_text(str("\nYour engine is overheating! Careful with the throttle!"))
			print("OH SHITTT")

func _event_generator():
	match eventNmbr:	
		0:
			mess.add_text(str("\nThe view is beautiful."))
		1:
			mess.add_text(str("\nYou can feel the wind in your clothes"))
		2:
			mess.add_text(str("\nHey :)"))
		3:
			mess.add_text(str("\nYou're currently going up a hill."))
			mod = 0.3
			engRpm -= 10
		4:
			mess.add_text(str("\nYour bike seems happy."))
		5:
			mess.add_text(str("\nYou're currently downhill."))
			speed_limit += 30
			smod = 1
			engRpm += 10
	
	
