extends Node


signal signal_updated_lives
signal signal_updated_mugs
signal signal_game_over
signal signal_win_game

var lives: int
var mugs: int


func gained_life():
	lives += 1
	signal_updated_lives.emit()
	if lives >= 9:
		signal_updated_lives.emit()
		signal_win_game.emit()


func lost_life():
	lives -= 1
	signal_updated_lives.emit()
	if lives < 0:
		signal_game_over.emit()



func mugs_broken():
	mugs += 1
	signal_updated_mugs.emit()


func reset_game():
	mugs = 0
	lives = 0
	signal_updated_mugs.emit()
	signal_updated_lives.emit()
