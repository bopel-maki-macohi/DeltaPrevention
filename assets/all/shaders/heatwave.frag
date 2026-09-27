#pragma header

uniform float amp;
uniform float time;
uniform float scale;

void main()
{
    vec2 uv = openfl_TextureCoordv;
    
    // Time varying pixel color
    float jacked_time = 5.5*time;

    uv += amp*sin(scale*jacked_time + length( uv )*10.0);

    vec4 color = flixel_texture2D(bitmap, uv);
    gl_FragColor = color;
}