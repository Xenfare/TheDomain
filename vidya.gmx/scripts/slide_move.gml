var s = abs(spd)

if s > 0
{
var dir = direction;
if spd > 0
dir += 180
        var i = 0;
        var xmov = lengthdir_x(1,dir)
        var ymov = lengthdir_y(1,dir) 
        while(i < s)
        {
            if !place_meeting(x + xmov, y, worldwall) && !place_meeting(x + xmov, y, enemyparent)
                x += xmov;
            else
                x -= 1;
            if !place_meeting(x - xmov, y + ymov, worldwall) && !place_meeting(x - xmov, y + ymov, enemyparent)
                y += ymov;
            else
                y -= 1;
            i++;
            xprevious = x
            yprevious = y
        }
}
