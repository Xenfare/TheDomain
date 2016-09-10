//if instance_exists(sword) && global.sworddir != 0 && inv = false {{repeat (round(1*global.damage/8)) instance_create(x, y, blood); {audio_play_sound(choose(slash, slash2, slash3), 10, false)}; hp -= global.damage; inv = true; alarm[0] = 8}}
//else
if instance_exists(sword2) && 
sword2.damaging = true && 
inv = false && 
ds_list_find_index(sword2.hitlist, id) = -1 
{{
repeat (round(1*global.damage/8)) instance_create(x, y, blood); 
{audio_play_sound(choose(slash, slash2, slash3), 10, false)}; 
hp -= global.damage; 
ds_list_add(sword2.hitlist, id);
}}
