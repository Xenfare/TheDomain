///dialog_update_size()
var dialog = argument0;
draw_set_font(dialog[? "font"])
dialog[? "height"] = string_height('A') * 3.5 * dialog[? "text scale"]
dialog[? "width"] = window_get_width() - string_width("aaaaaaaaaa") * 2
