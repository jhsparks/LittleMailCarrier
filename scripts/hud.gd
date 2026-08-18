extends Control

@onready var mail_label: Label = $CanvasLayer/MailPanel/HBoxContainer/MailLabel
@onready var prompt_label: Label = $CanvasLayer/InteractionPrompt
@onready var win_panel: PanelContainer = $CanvasLayer/WinPanel
@onready var popup_label: Label = $CanvasLayer/DeliveryPopup

@onready var pickup_sfx: AudioStreamPlayer = $CanvasLayer/PickupSFX
@onready var deliver_sfx: AudioStreamPlayer = $CanvasLayer/DeliverSFX
@onready var fanfare_sfx: AudioStreamPlayer = $CanvasLayer/FanfareSFX

var previous_mail: int = 0

func _ready() -> void:
	GameManager.mail_updated.connect(_on_mail_updated)
	GameManager.day_completed.connect(_on_day_completed)
	prompt_label.hide()
	win_panel.hide()
	popup_label.hide()


func _on_mail_updated(carried: int, _needed: int) -> void:
	mail_label.text = "Satchel: " + str(carried) + " / 7"
	# Play Pickup sound if mail goes up
	if carried > previous_mail:
		pickup_sfx.play()
	# Play Deliver sound + popup if mail goes down
	elif carried < previous_mail:
		deliver_sfx.play()
		show_delivery_popup()
	previous_mail = carried

func _on_day_completed() -> void:
	print("showing win panel now")
	win_panel.show()
	fanfare_sfx.play()

func show_delivery_popup() -> void:
	popup_label.show()
	var tween = create_tween()
	tween.tween_property(popup_label, "modulate:a", 1.0, 0.1)
	tween.tween_interval(0.8)
	tween.tween_property(popup_label, "modulate:a", 0.0, 0.3)
	tween.tween_callback(popup_label.hide)

func show_prompt(text_message: String) -> void:
	prompt_label.text = text_message
	prompt_label.show()

func hide_prompt() -> void:
	prompt_label.hide()
