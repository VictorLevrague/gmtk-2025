shader_type canvas_item;

uniform vec2 wave_speed = vec2(0.05, 0.03);
uniform float wave_scale : hint_range(0.1, 10.0) = 3.0;
uniform float noise_strength : hint_range(0.0, 1.0) = 0.2;
uniform float caustic_strength : hint_range(0.0, 1.0) = 0.3;
uniform vec3 deep_color : source_color = vec3(0.02, 0.08, 0.25);
uniform vec3 shallow_color : source_color = vec3(0.1, 0.3, 0.6);

#define PI 3.141592653589793

// 2D pseudo-random
float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 78.233);
    return fract(p.x * p.y);
}

// Simple value noise
float noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    // four corners
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    // smoothstep interpolation
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

// Fractal noise
float fbm(vec2 uv) {
    float v = 0.0;
    float amp = 0.5;
    float freq = 1.0;
    for (int i = 0; i < 5; i++) {
        v += amp * noise(uv * freq);
        freq *= 2.0;
        amp *= 0.5;
    }
    return v;
}

void fragment() {
    // normalized UV (0..1)
    vec2 uv = UV;

    // base wave layers (slow sinusoidal)
    float waves = sin((uv.x * wave_scale + TIME * wave_speed.x) * PI * 2.0)
                * sin((uv.y * wave_scale + TIME * wave_speed.y) * PI * 2.0);
    // soften and remap
    waves = smoothstep(-0.6, 0.6, waves) * 0.5;

    // add fractal noise for organic movement
    float n = fbm(uv * wave_scale * 0.5 + TIME * 0.02);
    n = (n - 0.5) * 2.0; // center
    float wave_combo = waves + n * noise_strength;

    // subtle UV distortion to simulate refraction
    vec2 distort = vec2(
        sin((uv.y + TIME * 0.1) * 10.0),
        cos((uv.x + TIME * 0.09) * 10.0)
    ) * 0.002 * wave_combo; // small
    vec2 uv_distorted = uv + distort;

    // depth-based gradient
    vec3 base_color = mix(deep_color, shallow_color, uv_distorted.y * 1.2);
    
    // caustic-like light shimmer: low-frequency traveling pattern
    float caustic = sin((uv.x * 6.0 + TIME * 0.8)) * sin((uv.y * 6.0 + TIME * 0.7));
    caustic = pow(smoothstep(0.2, 1.0, caustic * 0.5 + 0.5), 2.0); // sharpen
    caustic *= caustic_strength;

    // final color combining waves and shimmer
    vec3 color = base_color + vec3(caustic) * 0.2 + wave_combo * 0.05;

    // optional vignette / darken edges (comment out if undesired)
    float dist = distance(uv, vec2(0.5));
    float vignette = smoothstep(0.8, 0.5, dist);
    color *= vignette;

    COLOR = vec4(color, 1.0);
}
