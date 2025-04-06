extends Node2D
@onready var player_state = get_node("/root/main/PlayerState")
#pega os nodes necessários
@onready var stats = get_node("/root/main/EngStats")
@onready var mess = get_node("/root/main/Messages")
@onready var ctyName = get_node("/root/main/CityName")
@onready var city = get_node("/root/main/city")
@onready var book = get_node("/root/main/book")

var A1: float
var B1: float
var startPos: Vector2

var speed_limit_modifier = 0
var heat_mod = 1
#variáveis básicas
var day_counter: int
var money: int
@export var playerName = ""
var speed = 0
@export var bikeGas = 2
var place
var engRpm = 0
var isTravel = false
var mod: float #É o modificador de consumo de combustível
var nextPos: Vector2
#timer se refere à distância de um lugar a outro
var temp = 0
var event_timer = 10
var eventNmbr = 10
var speed_limit: float
#variáveis da durabilidade do motor
var eng_state = 0
var temp_mod = 0

#Sprites do estado do player
var next_state: Texture2D
@export var riding_sunset: Texture2D
@export var riding_night: Texture2D
@export var riding_noon: Texture2D
@export var default_city: Texture2D


func _ready() -> void:
	day_counter += 1
	money += 100

func _process(delta: float) -> void:
	#Configura o texto das caixas de texto.
	if isTravel == false:
		ctyName.set_text(str("\nYou are currently at ", city.currCity_name))
	else:
		ctyName.set_text(str("\nThe distance left to your destination is: ", A1 - B1))
	stats.set_text(str("Day: ", day_counter,"\n$: ", money))
	#Funções que rodam em todo frame
	_eng_durability(delta)
	_dist_change(delta)
	_gas(delta)
	_speed_calc(delta)
	_eng_temp(delta)
	_lights()
	_tire_durability(delta)
	
	if isTravel == false && speed > 0 && next_state != default_city:
		transitioner.play("fade_in")
		next_state = default_city
	#Desliga o motor fora de viagem
	if isTravel == false:
		engRpm = 0
		mod = 0
		event_timer = 10
		
	
	#Gerencia a geração de eventos na caixa de texto
	if isTravel == true && speed > 0:
		event_timer -= 1 * delta
	if isTravel == true && event_timer < 0:
		event_timer += 25
		eventNmbr = randi_range(0,9)
		_event_generator()	

 
func _dist_change(delta):
	#(???)
	#mentira, isso aqui pega as posições e muda a representaçãozinha do player
	var t = 0
	if self.global_position != nextPos && bikeGas > 0 && isTravel == true:
		t = (speed * 0.017) * delta
		self.global_position += t * (nextPos - self.global_position).normalized()
	
	#variáveis que pegam a distância e transformam num número 
	var A = float(self.global_position.x + self.global_position.y)
	var B = float(nextPos.x + nextPos.y)
	
	#Muda a posição internamente :3
	if A != B:
		A -= (speed * 1) * delta
	
	
	#Arredonda as coordenadas pra moto poder de fato parar owo nya
	A1 = snappedf(A, 1)
	B1 = snappedf(B, 1)
	if A1 == B1:
		isTravel = false
		speed_limit_modifier = 0
		place._get_places()
		#book._add_card()


func _gas(delta):
	if bikeGas > 0:
		bikeGas -= (0.08 * ((engRpm) * 0.1) + mod) * delta

func _speed_calc(delta):
	match engRpm:
		0:
			if speed > 0:
				speed -= 70 * delta
			else:
				pass
				
	speed_limit = engRpm + ((engRpm * 0.30)) + speed_limit_modifier

	if speed < speed_limit && engRpm > 0:
		speed += (2 * (engRpm * 0.07)) * delta
	else: if speed > 0:
		speed -= (3 + (engRpm *.03)) * delta

func _eng_temp(delta):
		if engRpm > 0 && temp <= 15:
			temp += (0.87 * (engRpm * 0.013) - speed * 0.007) * heat_mod * delta
		if engRpm == 0 && temp > 0 :
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
		1:
			mess.add_text(str("\nYou can feel the wind in your clothes"))
		2:
			mess.add_text(str("\nThe roar of your engine calms your mind. You're excited to arrive at your destination."))
		3:
			mess.add_text(str("\nYou're currently going up a hill. Your bike might struggle."))
		4:
			mess.add_text(str("\nThe road seems to be pretty good."))
		5:
			mess.add_text(str("\nYou're currently going downhill. You can ease off the throttle."))
		6:
			mess.add_text(str("\nThe roads seem pretty bad. Your tires will lose durability faster, and you'll go slower."))
		7:
			mess.add_text(str("\nThe sun seems pretty hot. You engine might overheat faster."))
		8:
			mess.add_text(str("\nIt's raining. You engine will take longer to overheat."))
		9:
			mess.add_text(str("\nYou think about where you are in your life. You should be proud of yourself, even if you're tired."))
	#match para mudar apenas o limite de velocidade
	match eventNmbr:
		5:	speed_limit_modifier += 19
		6:	speed_limit_modifier -= 10
		3:	speed_limit_modifier -= 15
		_:	speed_limit_modifier = 0
	#match para temperatura
	match eventNmbr:
		7:	heat_mod = 2
		8:	heat_mod = 0.5
		_:	heat_mod = 1

@onready var engLight = get_node("/root/main/EngLight")
@onready var heatLight = get_node("/root/main/HeatLight")
@onready var fuelLight = get_node("/root/main/FuelLight")
func _lights():
	if temp > 9:
		heatLight.visible = true
	else:
		heatLight.visible = false
	
	if eng_state > 60:
		engLight.visible = true
	else:
		engLight.visible = false
	
	if bikeGas <= 25:
		fuelLight.visible = true
	else:
		fuelLight.visible = false

var tire_front_durability = 100
var tire_rear_durability = 100
var tire_front_popped = false
var tire_rear_popped = false

var pop_chance: int
var pop_timer = 6

func _tire_durability(delta):
	#Diz se os pneus estão furados de acordo com a durabilidades
	if tire_front_durability < 0:
		tire_front_popped = true
		speed_limit_modifier = -30
		pass
	else:
		tire_front_popped = false
		
	if tire_rear_durability <= 0:
		tire_rear_popped = true
		speed_limit_modifier = -35
		pass
	else:
		tire_rear_popped = false
		
	#dita se o pneu vai desgastar mais rápido ou não
	if isTravel == true && speed != 0:
		match eventNmbr:
			_:
				if tire_front_popped == false:
					tire_front_durability -= (0.1 * speed * 0.1)  * delta
				if tire_rear_popped == false:
					tire_rear_durability -= (0.1 * speed * 0.1)  * delta
			6:
				if tire_front_popped == false:
					tire_front_durability -= (0.2 * speed * 0.2)  * delta
				if tire_rear_popped == false:
					tire_rear_durability -= (0.2 * speed * 0.2)  * delta
				
				#chance aleatória do pneu furar
				pop_timer -= 1 * delta
				if pop_timer <= 0:
					pop_chance = randi_range(1,14)
					pop_timer += 6
				
				match pop_chance:
					3:
						var pick_tire = randi_range(1,2)
						match pick_tire:
							1:
								tire_rear_durability = 0
								
							2:
								tire_front_durability = 0
					_:
						return
	print(tire_front_durability)
	print(tire_rear_durability)

@onready var transitioner = get_node("/root/main/transitioner")

func _on_transitioner_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		player_state.texture = next_state
		transitioner.play("fade_out")
