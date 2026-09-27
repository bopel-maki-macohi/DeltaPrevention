#pragma header

uniform float offset;

uniform float width;
uniform float height;

uniform float x;
uniform float y;

void main()
{
    vec2 uv = openfl_TextureCoordv;

    if (uv.x > x / width)
        uv.x += offset / width;
    if (uv.y > y / height)
        uv.y += offset / height;

    vec4 color = texture2D(bitmap, uv);
    gl_FragColor = color;
}