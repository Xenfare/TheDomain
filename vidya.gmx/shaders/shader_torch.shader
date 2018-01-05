attribute vec3 in_Position;  
attribute vec4 in_Colour; 
attribute vec2 in_TextureCoord;  
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 frag_position;
uniform vec2 center;  //position of center of circle

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    frag_position = in_Position.xy - center;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~


varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 frag_position;
uniform float radius;  //radius of circle
void main()
{
    float _fade = pow(length(frag_position) / radius, 1.0);
    gl_FragColor = vec4((v_vColour * texture2D( gm_BaseTexture, v_vTexcoord)).xyz, _fade);
}
