///dialog_add_label(dialog,label)
if !ds_exists(argument0,ds_type_map)
    return false
var list = argument0[? "list"]
if !ds_exists(list,ds_type_list)
    return false
ds_list_add(list,-1,argument1)
return true
