UI_main = openfig("UI_main.fig")
audio = audioread("genres/genres/blues/blues.00000.au")
audio = abs(audio)
UI_main(audio)