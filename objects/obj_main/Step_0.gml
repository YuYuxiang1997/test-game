/// @description Insert description here
// You can write your code in this editor
var _income = get_total_income()

total_gold += _income/60

population = node_ins[0].level * get_resource_multiplier("population")

log += node_ins[1].level * get_resource_multiplier("log") / 60

render_log_upgrades()