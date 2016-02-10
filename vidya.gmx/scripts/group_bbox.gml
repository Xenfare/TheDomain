///group_bbox(0 = right 1 = top 2 = left 3 = bottom,list)
var precal = argument1
switch(argument0)
{
case 0:
    var true_bbox_right = bbox_right
    var inst = collision_point(true_bbox_right + 1,y,wall,false,true)
    while(inst!=noone and true_bbox_right < other.x + view_range)
    {
        true_bbox_right = inst.bbox_right
        ds_list_add(precal,inst)
        inst = collision_point(true_bbox_right + 1,y,wall,false,true)
    }
    return true_bbox_right
break;
case 1:
    var true_bbox_top = bbox_top
    var inst = collision_point(x,true_bbox_top - 1,wall,false,true)
    while(inst!=noone and true_bbox_top > other.y - view_range)
    {
        true_bbox_top = inst.bbox_top
        ds_list_add(precal,inst)
        inst = collision_point(x,true_bbox_top - 1,wall,false,true)
    }
    return true_bbox_top
break;
case 2:
    var true_bbox_left = bbox_left
    var inst = collision_point(true_bbox_left - 1,y,wall,false,true)
    while(inst!=noone and true_bbox_left > other.x - view_range)
    {
        true_bbox_left = inst.bbox_left
        ds_list_add(precal,inst)
        inst = collision_point(true_bbox_left - 1,y,wall,false,true)
    }
    return true_bbox_left
break;
case 3:
    var true_bbox_bottom = bbox_bottom
    var inst = collision_point(x,true_bbox_bottom + 1,wall,false,true)
    while(inst!=noone and true_bbox_bottom < other.y + view_range)
    {
        true_bbox_bottom = inst.bbox_bottom
        ds_list_add(precal,inst)
        inst = collision_point(x,true_bbox_bottom + 1,wall,false,true)
    }
    return true_bbox_bottom
break;
}
