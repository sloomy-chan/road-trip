extends Node2D
#pega os nodes necessários
@onready var stats = get_node("/root/main/EngStats")
@onready var mess = get_node("/root/main/Messages")
@onready var ctyName = get_node("/root/main/CityName")
@onready var city = get_node("/root/main/city")

#variáveis básicas
@export var playerName = ""
var speed = 0
@export var bikeGas = 2
var engRpm = 0
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
#variáveis da durabilidade do motor
var eng_state = 0
var temp_mod = 0

func _process(delta: float) -> void:
	#Configura o texto das caixas de texto.
	ctyName.set_text(str("\nYou are currently at ", city.currCity_name))
	stats.set_text(str(engRpm, "rpm x100", "\nEngine temp: ",snappedf(temp, 0.1), "\n Player:", playerName, "\n Time left to destination is: ", snappedf(timer, 0.1),"\n Travelling: ", isTravel, "\n Gas: ", snappedf(bikeGas, 0.1), "\nSpeed: ", snappedf(speed, 1), "\nEngine State: ", snappedf(eng_state, 1)))
	
	#Funções que rodam em todo frame
	_eng_durability(delta)
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
				speed -= (20-(engRpm * 0.1)) * delta
			else:
				pass
				
	speed_limit = engRpm + ((engRpm * 0.30) + smod) - temp_mod

	if speed < speed_limit && engRpm > 0:
		speed += (2 * (engRpm * 0.07) + smod) * delta
	else: if speed > 0:
		speed -= (3 + (engRpm *.03)) * delta

func _eng_temp(delta):
		if engRpm > 0 && temp < 15:
			temp += (0.87 * (engRpm * 0.013) - speed * 0.007) * delta
		if engRpm == 0 && temp > 0:
			temp -= 0.1 * delta


func _eng_durability(delta):
	if engRpm > 0 && temp >6 && eng_state < 100:
		eng_state += (temp * 0.1) * delta
	if eng_state > 60 && speed > 0:
		temp_mod = (eng_state * 0.35)
	else:
		temp_mod = 0

func _event_generator():
	match eventNmbr:	
		0:
			mess.add_text(str("\nThe view is beautiful."))
			smod = 0
		1:
			mess.add_text(str("\nYou can feel the wind in your clothes"))
			smod = 0
		2:
			mess.add_text(str("\nHey :)"))
			smod = 0
		3:
			mess.add_text(str("\nYou're currently going up a hill."))
			if engRpm > 0 && speed_limit > 5:
				temp_mod += 8
		4:
			mess.add_text(str("\nYour bike seems happy."))
			smod = 0
		5:
			mess.add_text(str("\nYou're currently downhill."))
			smod = 10
