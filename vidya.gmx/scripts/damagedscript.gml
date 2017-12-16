if instance_exists(player.weapon) && 
player.weapon.damaging = true && 
inv = false && 
ds_list_find_index(player.weapon.hitlist, id) = -1 

{
{
{repeat (round(1*global.damage/8)) instance_create(x, y, blood);}
{audio_play_sound(choose(slash, slash2, slash3), 10, false)}; 
hp -= global.damage;

kb = player.weapon.kbvalue;
kbdir = point_direction(other.kbx, other.kby, x, y)
ds_list_add(player.weapon.hitlist, id);
if player.weapon.object_index = flail {ds_list_add(player.weapon.hitlist, player.weapon.swing); player.weapon.charge -= 15}
}
}

if hp <= 0 {ds_list_add(player.defeated, id)}
