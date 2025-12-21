shader_type canvas_item;

uniform float wind_strength : hint_range(0,1.5) = 0.2;
uniform float wind_speed : hint_range(0.2,5) = 1.0;
uniform float wind_power : hint_range(0,5) = 2.0;

// Bottom portion of sprite to affect
uniform float affected_height : hint_range(0,1) = 0.6;

void fragment() {
    vec2 uv = UV;

    // 1️⃣ Flip UV.y
    float flipped_y = 1.0 - uv.y;

    // 2️⃣ Only affect bottom portion (now top visually because of flip)
    float wind_mask = step(flipped_y, affected_height);

    // 3️⃣ Remap flipped bottom portion to 0..1
    float local_height = clamp(flipped_y / affected_height, 0.0, 1.0);

    // 4️⃣ Stronger sway near top of affected region (original bottom)
    float sway_strength = pow(local_height, wind_power);

    // 5️⃣ Apply wind
    float wind = sin(TIME * wind_speed) * wind_strength * sway_strength * wind_mask;

    uv.x += wind;

    COLOR = texture(TEXTURE, uv);
}
