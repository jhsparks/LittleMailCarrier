extends Control

@onready var mail_label: Label = $CanvasLayer/MailPanel/HBoxContainer/MailLabel
@onready var prompt_label: Label = $CanvasLayer/InteractionPrompt
@onready var win_panel: PanelContainer = $CanvasLayer/WinPanel

func _ready() -> void:
	GameManager.mail_updated.connect(_on_mail_updated)
	GameManager.day_completed.connect(_on_day_completed)
	prompt_label.hide()
	win_panel.hide()

func _on_mail_updated(carried: int, _needed: int) -> void:
	mail_label.text = "Satchel: " + str(carried) + " / 7"

func _on_day_completed() -> void:
	print("showing win panel now")
	win_panel.show()

func show_prompt(text_message: String) -> void:
	prompt_label.text = text_message
	prompt_label.show()

func hide_prompt() -> void:
	prompt_label.hide()
