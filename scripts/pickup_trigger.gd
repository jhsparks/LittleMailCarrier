extends Area2D

var player_in_range: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		GameManager.pickup_mail(7) # Gives player 7 letters for 7 houses

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		player_in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		player_in_range = false
