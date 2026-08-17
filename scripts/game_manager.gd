extends Node

signal mail_updated(carried: int, needed: int)
signal day_completed

var mail_carried: int = 0       # Mail currently in satchel
var mail_delivered: int = 0     # Total delivered
var total_mail_needed: int = 7  # Daily goal

func pickup_mail(amount: int) -> void:
	mail_carried = amount
	print("Picked up ", mail_carried, " letters from Mail HQ! Time for deliveries!")
	mail_updated.emit(mail_carried, total_mail_needed)

func deliver_mail() -> bool:
	if mail_carried > 0:
		mail_carried -= 1
		mail_delivered += 1
		print("Letter delivered! Remaining: ", mail_carried, " | Total delivered: ", mail_delivered)
		mail_updated.emit(mail_carried, total_mail_needed)
		if mail_delivered >= total_mail_needed:
			print("DAY COMPLETED!")
			day_completed.emit()
		return true
	else:
		print("Your mailbag is empty! Go to Mail HQ to pick up letters first.")
		return false
