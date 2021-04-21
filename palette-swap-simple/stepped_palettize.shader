shader_type canvas_item;

uniform sampler2D palette;
uniform int num_colors : hint_range(2, 20, 1);

float stepped(float value) {
	float interval = 1.0 / float(num_colors - 1);
	return floor(value / interval + 0.5) * interval;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float avg_color = (color.r + color.g + color.b) / 3.0;
	float stepped_value = stepped(avg_color);
	
	vec4 stepped_color = texture(palette, vec2(stepped_value, 0));
	COLOR = stepped_color;
}