extends Node


signal signal_updated_lives
signal signal_updated_mugs


var lives: int
var mugs: int


func gained_life():
	lives += 1
	signal_updated_lives.emit()


func mugs_broken():
	mugs += 1
	signal_updated_mugs.emit()


func reset_game():
	mugs = 0
	lives = 0
