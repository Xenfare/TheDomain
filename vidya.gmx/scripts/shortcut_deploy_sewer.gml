if argument_count > 0
var b = B
else
var b = 0

var plank_buffer = 32

//move death walls
var inst;
inst[0] = collision_point(320+b,1984+b,deathinvis,false,false);
with(instance_create(384+b,2024+b,board)){image_yscale = 1.2;}
inst[1] = collision_point(320+b,832+b,deathinvis,false,false);
inst[2] = collision_point(320+b,768+b,deathinvis,false,false);
with(instance_create(384+b,780+b,board)){image_yscale = 1.2;}
inst[3] = collision_point(1472+b,320+b,deathinvis,false,false);
with(instance_create(1500+b,320+b,board)){image_yscale = .8;image_angle = 90;}
var buf = plank_buffer / 64;
for(var i = 0; i < 3; ++i)
{
    if !inst[i] exit; 
    inst[i].image_xscale = inst[i].image_xscale * .5 - buf
    with(inst[i])
        instance_copy(false)
    inst[i].x = inst[i].bbox_right + plank_buffer * 2
}
inst[i].image_yscale = inst[i].image_yscale * .5 - buf
with(inst[i])
    instance_copy(false)
inst[i].y = inst[i].bbox_bottom + plank_buffer * 2
