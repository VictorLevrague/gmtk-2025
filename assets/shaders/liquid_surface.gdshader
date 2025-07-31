shader_type canvas_item;
render_mode unshaded;

uniform float HealthAmount : hint_range(0,1) = 0.8;
uniform vec4 HealthColor : source_color = vec4(0.64,0.08,0.08,1.0);
uniform float WaveSpeed : hint_range(0.01,10.0) = 5.0;
uniform float WavePeriod : hint_range(0.1,10) = 3.0;
uniform float WaveAmplitude : hint_range(0,0.35) = 0.25;

void fragment()
{
    // vertical sine wave (varies with UV.y)
    float sin_wave = sin( ( TIME + ( UV.y / WavePeriod ) ) * WaveSpeed );
    float scaled_sin_wave = (sin_wave * 0.5) + 0.5;

    // reduce amplitude near full/empty health
    float wave_amp_scale = min(
        smoothstep(1.0, 1.0 - WaveAmplitude, HealthAmount),
        smoothstep(0.0, WaveAmplitude * 2.0, HealthAmount)
    );

    // wave-modified threshold
    float wave_test_val = (1. - HealthAmount) - scaled_sin_wave * WaveAmplitude * wave_amp_scale;

    // fill anchored on right; as HealthAmount decreases the filled region retreats leftward
    float wave = UV.x < (1.0 - wave_test_val) ? 1.0 : 0.0;

    COLOR.rgb = HealthColor.rgb;
    COLOR.a = wave * HealthColor.a;
}
