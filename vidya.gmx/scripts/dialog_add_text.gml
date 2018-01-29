///dialog_add_text(dialog,name,text)
if !ds_exists(argument0,ds_type_map)
    return false
var list = argument0[? "list"]
if !ds_exists(list,ds_type_list)
    return false
//ds_list_add(list,0/*0 for text*/,argument1,argument2,argument3)
var max_height = (string_height("A") + dialog[? "padding"]) * 3
var line_width = dialog[? "width"] - 90 - dialog[? "padding"] * 5
var str = argument3
while(string_height_ext(str,string_height("A") + dialog[? "padding"],line_width) / max_height > 1)
{
    var temp = str;
    var last_char = string_pos(" ",temp)
    var old_last_char = last_char
    if last_char != 0
    do
    {
        old_last_char = last_char
        temp = string_replace(temp," ","_")
        last_char = string_pos(" ",temp)
    }
    until(string_height_ext(string_copy(str,1,last_char),string_height("A") + dialog[? "padding"],line_width) > max_height || last_char = 0)
    if old_last_char = 0
        old_last_char = string_length(str)
    ds_list_add(list,0/*0 for text*/,argument1,argument2,string_copy(str,1,old_last_char))
    str = string_delete(str,1,old_last_char)
}
ds_list_add(list,0,argument1,argument2,str)
return true
