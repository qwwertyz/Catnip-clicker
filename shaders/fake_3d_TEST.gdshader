shader_type canvas_item;

// Camera FOV
uniform float fov : hint_range(1, 179) = 90;
uniform bool cull_back = true;
uniform float y_rot : hint_range(-180, 180) = 0.0;
uniform float x_rot : hint_range(-180, 180) = 0.0;
uniform float inset : hint_range(0, 1) = 1.0; // keeps entire texture inside rect

varying vec2 uv_centered;
varying float depth;


void vertex() {
    // Rotation
    float sin_y = sin(y_rot / 180.0 * PI);
    float cos_y = cos(y_rot / 180.0 * PI);
    float sin_x = sin(x_rot / 180.0 * PI);
    float cos_x = cos(x_rot / 180.0 * PI);

    mat3 rot;
    rot[0] = vec3(cos_y, 0.0, -sin_y);
    rot[1] = vec3(sin_y * sin_x, cos_x, cos_y * sin_x);
    rot[2] = vec3(sin_y * cos_x, -sin_x, cos_y * cos_x);

    // Center UV
    vec3 p_local = vec3(UV - 0.5, 0.5 / tan(fov / 360.0 * PI));
    vec3 p_rot = rot * p_local;

    uv_centered = p_rot.xy / p_rot.z; // for fragment
    depth = p_rot.z;

    // Move vertices for perspective
    float scale = (0.5 / tan(fov / 360.0 * PI)) + 0.5;
    VERTEX += (UV - 0.5) * scale * (1.0 - inset) / TEXTURE_PIXEL_SIZE;
}

void fragment() {
    if (cull_back && depth <= 0.0) discard;

    // Map UVs back to 0..1 to sample texture
    vec2 final_uv = uv_centered * 0.5 + 0.5;

    // Clamp to stay inside texture
    final_uv = clamp(final_uv, 0.0, 1.0);

    COLOR = texture(TEXTURE, final_uv);

    // Optional: keep alpha inside rect
    vec2 centered = final_uv - 0.5;
    COLOR.a *= step(max(abs(centered.x), abs(centered.y)), 0.5);
}
