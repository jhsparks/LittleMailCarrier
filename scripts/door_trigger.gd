extends Area2D

var player_in_range: bool = false
var is_delivered: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_in_range and not is_delivered and Input.is_action_just_pressed("interact"):
		if GameManager.deliver_mail():
			is_delivered = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		HUD.show_prompt("[SPACE] Deliver Mail")
		player_in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		HUD.hide_prompt()
		player_in_range = false
