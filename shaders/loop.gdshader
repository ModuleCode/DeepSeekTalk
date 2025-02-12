shader_type canvas_item;

// 横向滚动速度，默认值为 0.1
uniform float horizontal_scroll_speed = 0.1;
// 纵向滚动速度，默认值为 0.1
uniform float vertical_scroll_speed = 0.1;

void fragment() {
    // 获取从场景启动以来经过的时间
    float elapsed_time = TIME;

    // 计算水平方向的偏移量
    float offset_x = horizontal_scroll_speed * elapsed_time;
    // 计算垂直方向的偏移量
    float offset_y = vertical_scroll_speed * elapsed_time;

    // 获取当前片段的原始纹理坐标
    vec2 uv = UV;

    // 应用水平偏移到纹理坐标上
    uv.x += offset_x;
    // 应用垂直偏移到纹理坐标上
    uv.y += offset_y;

    // 使用 fract 函数确保纹理坐标的 x 和 y 分量在 [0, 1] 范围内，实现纹理的重复
    uv.x = fract(uv.x);
    uv.y = fract(uv.y);

    // 对 TextureRect 自带的纹理进行采样
    vec4 sampled_color = texture(TEXTURE, uv);
    // 将采样得到的颜色赋值给最终的片段颜色
    COLOR = sampled_color;
}