//if instance_exists(sword) && global.sworddir != 0 && inv = false {{repeat (round(1*global.damage/8)) instance_create(x, y, blood); {audio_play_sound(choose(slash, slash2, slash3), 10, false)}; hp -= global.damage; inv = true; alarm[0] = 8}}
//else
if instance_exists(player.weapon) && 
player.weapon.damaging = true && 
inv = false && 
ds_list_find_index(player.weapon.hitlist, id) = -1 
{
{
{repeat (round(1*global.damage/8)) instance_create(x, y, blood);}
{audio_play_sound(choose(slash, slash2, slash3), 10, false)}; 
hp -= global.damage; 
ds_list_add(player.weapon.hitlist, id);
}
}

if hp <= 0 {ds_list_add(player.defeated, id)}
