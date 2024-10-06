age += delta_time/1000000

if (age > CASCADE_NUMBER_LIFETIME) {
	instance_destroy()
}