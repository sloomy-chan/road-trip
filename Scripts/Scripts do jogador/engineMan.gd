extends Button
@onready var player = get_node("/root/main/PlayerManager")
@onready var engine = get_node("/root/main/PlayerManager/engine_sound")
var button = self
var rpm = 0
@export var type = 1

func _ready() -> void:
		button.pressed.connect(self._rpm_manager)

func _rpm_manager() -> void:
	if player.bikeGas > 0:
		if player.engRpm == 0 && type == 1:
			engine.play()
	if player.bikeGas > 0:
		if player.engRpm != 100 && type == 1:
			player.engRpm += 10
		else: if player.engRpm != 0 && type == 2:
			player.engRpm += -10
