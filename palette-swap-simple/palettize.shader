shader_type canvas_item;

uniform sampler2D palette;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float avg_color = dot(color.rgb, vec3(0.3, 0.59, 0.11)); // fancy desaturate
	
	vec4 stepped_color = texture(palette, vec2(avg_color, 1));
	COLOR = stepped_color;
}