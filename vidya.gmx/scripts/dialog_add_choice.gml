///dialog_add_choice(dialog,portrait,name,question,choice1,script1,choice2,scr...)
var dialog = argument[0]
if argument_count < 6 || argument_count % 2 = 1 || !ds_exists(dialog,ds_type_map)
    return false
if !ds_exists(dialog,ds_type_map)
    return false
var list = dialog[? "list"]
if !ds_exists(list,ds_type_list)
    return false
ds_list_add(list,1/*1 for choices*/,argument[1],argument[2],argument[3], argument_count - 4)
for(var i = 4; i < argument_count; ++i)
    ds_list_add(list,argument[i])
return true
