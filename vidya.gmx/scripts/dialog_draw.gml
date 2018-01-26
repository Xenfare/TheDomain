///dialog_draw(dialog)
var dialog = argument0
if !ds_exists(dialog,ds_type_map)
    return false
//Setup
var list = dialog[? "list"]
if !ds_exists(list,ds_type_list)
    return false
var pos = dialog[? "list position"]
if ds_list_size(list) <= pos
    return false
var header = list[| pos]
//non-draw checks
if header = -4
{
    if script_execute(list[|pos + 1])
        dialog_goto_label(dialog,list[| pos + 2])
    else
        dialog[? "list position"] = pos + 3
    return dialog_draw(dialog)
}
if header = -3
{
    dialog[? "list position"] = pos + 2
    script_execute(list[|pos + 1])
    return dialog_draw(dialog)
}
if header = -2
{
    if !dialog_goto_label(dialog,list[|pos + 1])
        dialog[? "list position"] = pos + 2
    return dialog_draw(dialog)
}
if header = -1
{
    dialog[? "list position"] = pos + 2
    return dialog_draw(dialog)
}   

//setup positioning
var x_left, y_top
var height = max(dialog[? "height"],(string_height("A") + string_height(string(list[| pos + 2]))*dialog[? "text scale"]+dialog[? "padding"] * 2));
if dialog[? "follow character"]
{
    var xscale = view_wview / view_wport
    var yscale = view_hview / view_hport
    if dialog[? "halign"] = fa_left
        x_left = window_get_width() * ((bbox_left - view_xview) / view_wview) - dialog[? "width"]
    else if dialog[? "halign"] = fa_center
        x_left = window_get_width() * ((x - view_xview) / view_wview) - dialog[? "width"] * .5
    else //right aligned
        x_left = window_get_width() * ((bbox_right - view_xview) / view_wview) 
    if dialog[? "valign"] = fa_top
        y_top = window_get_height() * ((bbox_top - view_yview) / view_hview) - height
    else if dialog[? "valign"] = fa_center
        y_top = window_get_height() * ((y - view_yview) / view_hview) - height * .5
    else //bottom aligned
        y_top = window_get_height() * ((bbox_bottom - view_yview) / view_hview)
}
else
{
    if dialog[? "halign"] = fa_left
        x_left = 0
    else if dialog[? "halign"] = fa_center
        x_left = (window_get_width() - dialog[? "width"]) * .5
    else //right aligned
        x_left = window_get_width() - dialog[? "width"]
    if dialog[? "valign"] = fa_top
        y_top = 0
    else if dialog[? "valign"] = fa_top
        y_top = (window_get_height() - height) * .5 
    else //bottom aligned
        y_top = window_get_height() - height
}


var padding = dialog[? "padding"]
var y_bottom = y_top + height

//draw background
draw_set_color(dialog[? "background color"])
draw_set_alpha(dialog[? "background alpha"])
draw_rectangle(x_left,y_bottom,x_left + dialog[? "width"],y_top,false)
draw_set_alpha(1)

//draw portrait
draw_set_color(dialog[? "portrait background color"])
draw_rectangle(x_left + padding,y_top + padding,x_left + padding + sprite_get_width(list[| pos + 1]),y_bottom - padding,false)
draw_sprite(list[| pos + 1],0,x_left + padding,y_top + padding)
var x_text = sprite_get_width(list[| pos + 1]) + padding + x_left;
draw_set_color(dialog[? "text color"])

draw_set_font(dialog[? "font"])
draw_set_halign(fa_left)
draw_set_valign(fa_top)
var scale = dialog[? "text scale"]
if header
{
    //draw name and question
    var name = list[| pos + 2]
    draw_text_transformed(x_text + padding, y_top + padding, name + "   " + list[| pos + 3], scale, scale, 0)
    //draw text and handle input
    var y_text = y_top + padding + string_height(name) * scale
    var choices = list[| pos + 4]
    var my = window_mouse_get_y();
    x_text += padding * 3;
    for(var i = pos + 5; i < pos + 5 + choices; i += 2)
    {
        var text = list[| i]
        var h_text = string_height(name) * scale;
        if my >= y_text && my <= y_text + h_text
        {
            if mouse_check_button_pressed(mb_left)
            {
                dialog[? "list position"] = pos + 5 + choices
                return dialog_goto_label(dialog,list[| i + 1])
            }
            draw_set_alpha(dialog[? "background alpha"])
            var inv_bcol = dialog[? "background color"];
            inv_bcol = make_color_rgb(255 - color_get_red(inv_bcol),255 - color_get_green(inv_bcol),255 - color_get_blue(inv_bcol))
            draw_rectangle_color(x_text + 1,y_text,x_left + dialog[? "width"],y_text + h_text,inv_bcol,inv_bcol,inv_bcol,inv_bcol,false)
            draw_set_alpha(1)
            var inv_bcol = dialog[? "text color"];
            inv_bcol = make_color_rgb(255 - color_get_red(inv_bcol),255 - color_get_green(inv_bcol),255 - color_get_blue(inv_bcol))
            draw_text_transformed_color(x_text + padding * 2, y_text, text, scale, scale, 0, inv_bcol,inv_bcol,inv_bcol,inv_bcol,1)
        }
        else
            draw_text_transformed(x_text + padding * 2, y_text, text, scale, scale, 0)
        y_text += h_text + padding
    }
}
//just dialog text
else
{
    //Setup
    var stime = dialog[? "typing start time"]
    if stime = 0
    {
        stime = current_time
        dialog[? "typing start time"] = stime
    }
    var text = list[| pos + 3]
    var chars = (current_time - stime) / dialog[? "typing speed"]
    if chars >= string_length(text)
        var display_text = text
    else
        var display_text = string_copy(text,0,chars)
    
    //draw name
    var name = list[| pos + 2]
    draw_text_transformed(x_text + padding, y_top + padding, name, scale, scale, 0)
    //draw text
    draw_text_ext_transformed(x_text + padding * 4, y_top + padding + string_height(name) * scale, display_text,string_height("A") + padding,dialog[? "width"] - sprite_get_width(list[| pos + 1]) - padding * 5,  scale, scale, 0)

    //handle input
    if keyboard_check_pressed(dialog[? "next key"])
    {
        if string_length(display_text) = string_length(text)
        {
            dialog[? "list position"] = pos + 4
            dialog[? "typing start time"] = 0
        }
        else
            dialog[? "typing start time"] = -1000000
    }
    
    if dialog[? "display next key"] = 2 || (string_length(display_text) = string_length(text) && dialog[? "display next key"] = 1)
    {
        var c = dialog[? "next key color"]
        draw_text_color(x_text, y_bottom, "Press '" + chr(dialog[? "next key"]) + "' to continue.",c,c,c,c,dialog[? "next key alpha"])
    }
}
draw_set_color(c_white)

return true