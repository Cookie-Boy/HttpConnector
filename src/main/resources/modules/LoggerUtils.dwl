%dw 2.0

fun calculateDuration(startTime: DateTime, endTime: DateTime): Number =
	((endTime - startTime).seconds * 1000) + (endTime.milliseconds - startTime.milliseconds)