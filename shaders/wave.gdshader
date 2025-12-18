shader_type canvas_item;

uniform float wind_start_threshold : hint_range(0,1) = 0.1;
uniform float wind_end_threshold : hint_range(0,10) = 2.0;
uniform float wind_end_threshold_2 : hint_range(0,2) = 0.1;
uniform float wind_strength : hint_range(0,1.5) = 0.2;
uniform float wind_speed : hint_range(0.2,5) = 1.0;
uniform float scale = 2.0;

void vertex() {
    VERTEX *= scale;
}

void fragment() {
    vec2 uv = UV * scale;
    uv -= (scale - 1.0) / scale;

    float dist_amount = smoothstep(
        wind_start_threshold * pow((1.0 - uv.y), wind_end_threshold),
        wind_end_threshold_2,
        1.0 - uv.y
    );

    uv.x += sin(TIME * wind_speed)
        * pow((1.0 - uv.y), wind_end_threshold)
        * dist_amount
        * wind_strength;

    COLOR = texture(TEXTURE, uv);

    // clip outside UVs
    vec2 border = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    COLOR.a *= border.x * border.y;
}
