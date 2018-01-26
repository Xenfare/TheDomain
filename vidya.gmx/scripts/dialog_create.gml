///dialog_create()
var dialog = ds_map_create();

/*
  Default Settings
  Edit these to change how a normal dialog box should work.
  This is a map so it can be changed manually whenever needed
*/
dialog[? "follow character"] = false
dialog[? "halign"] = fa_center
dialog[? "valign"] = fa_bottom
//dialog[? "x"] = string_width("aaaaaaaaaa") 
//dialog[? "y"] = window_get_height() - 100
//moved to dialog_update_size
//dialog[? "height"] = 100
//dialog[? "width"] = window_get_width() - string_width("aaaaaaaaaa") * 2
dialog[? "background alpha"] = 1
dialog[? "background color"] = c_dkgray
dialog[? "portrait background color"] = c_gray
dialog[? "next key"] = ord("F")
// 0 = never 1 = when finished animating 2 = always
dialog[? "display next key"] = false
dialog[? "next key color"] = c_black
dialog[? "next key alpha"] = .6
dialog[? "typing speed"] = 20
dialog[? "font"] = Arial //fnt_gui /* IMPORATANT CHANGE THIS TO A FONT IN YOUR GAME */
dialog[? "text color"] = c_white
dialog[? "text scale"] = 1
//call this after you change font or "text scale" if you want it to scale with text
dialog_update_size(dialog)
dialog[? "height"] = 100
dialog[? "padding"] = 5



//storage and drawing handling
dialog[? "list position"] = 0
dialog[? "list"] = ds_list_create()
dialog[? "typing start time"] = 0

return dialog