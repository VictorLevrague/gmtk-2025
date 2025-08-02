//shader_type canvas_item;
//render_mode blend_add;
//
//uniform sampler2D noise : repeat_enable; 
//uniform sampler2D noise2 : repeat_enable;  
//uniform float brightness = 2.5;
//uniform float time_scale = 1.0;
//
//void fragment() {
    //// Time with global speed control.
    //float animated_time = TIME * time_scale;
    //vec4 input_color = COLOR;
    //
    //COLOR = vec4(0.0);
    //
    //for (int layer = 1; layer <= 5; layer++) {
        //// Controls how strong the displacement is for this layer.
        //float displacement_strength = 0.1 + 0.07 * float(layer);
        //
        //// Seeded dynamic coordinate for the first noise sampler to generate a layer-specific offset.
        //float seed_for_offset = sin(float(layer) * 55.0);
        //float time_offset_factor = 0.35 * (0.5 + fract(seed_for_offset));
        //vec2 noise_sample_coord = vec2(animated_time * time_offset_factor, normalized_angle);
        //
        //// Sample noise texture and remap from [0,1] to [-0.5,0.5], then scale.
        //vec2 raw_noise = texture(noise, noise_sample_coord).rg;
        //vec2 displacement = (raw_noise - vec2(0.5)) * displacement_strength;
        //
        //// Apply displacement to effect UV.
        //vec2 displaced_effect_uv = effect_uv + displacement;
        //
        //// Horizontal distance from a reference line (used as denominator); clamp to avoid divide-by-zero.
        //float horizontal_dist = abs(displaced_effect_uv.x - 0.5);
        //horizontal_dist = max(horizontal_dist, 0.001); // epsilon safety to prevent blow-up.
        //
        //// Layer-specific random speed for modulation.
        //float random_speed_seed = fract(cos(float(layer) * 1144.0));
        //float visibility_speed = 0.2 + 0.05 * random_speed_seed;
        //
        //// Sample secondary noise to drive visibility ("gone") with a smooth transition per layer.
        //float visibility_threshold_low = 0.1 + 0.05 * (float(layer) - 0.5);
        //float visibility_value = texture(noise2, effect_uv + vec2(animated_time * visibility_speed)).s;
        ////float layer_visibility = smoothstep(visibility_threshold_low, 1.0, visibility_value);
        //float layer_visibility = 1.0;
        //
        //// Additional modulation from secondary noise at displaced position (animated).
        //float flicker = texture(noise2, displaced_effect_uv + vec2(animated_time)).s;
        //
        //// Accumulate contribution: visibility * base color * flicker / distance * scaling
        //COLOR += layer_visibility * input_color * flicker * (0.01 / horizontal_dist);
    //}
    //
    //// Core light: central contribution with falloff and alpha mask from secondary noise.
    //// The falloff uses reversed smoothstep to create a specific attenuation shape.
    //float falloff_input = abs(effect_uv.x - 0.5) * 2.0;
    //float inverted_falloff = smoothstep(1.0, -2.0, falloff_input);
    //float alpha_mask = texture(noise2, effect_uv).a;
    //vec4 core_light = input_color * inverted_falloff * alpha_mask;
    //
    //// Add core light scaled by brightness.
    //COLOR += core_light * brightness;
//}
