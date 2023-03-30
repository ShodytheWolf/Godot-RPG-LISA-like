extends Label
#señal que se usara para llamar a lo que sea que se eligio con el cursor en un futuro
signal cursor_selected()

func cursor_select() -> void:
	print(name)
	emit_signal("cursor_selected")
