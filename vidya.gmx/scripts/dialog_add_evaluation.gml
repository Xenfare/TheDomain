///dialog_add_evaluation(dialog,script,label)
if !ds_exists(argument0,ds_type_map)
    return false
var list = argument0[? "list"]
if !ds_exists(list,ds_type_list)
    return false
ds_list_add(list,-4,argument1,argument2)
return true
