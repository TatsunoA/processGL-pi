#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_TEXTURE_SHADER
#define PI 3.14159265359

varying vec4 vertTexCoord;
uniform sampler2D u_texture1;
uniform sampler2D u_texture2;
uniform float temp;
uniform float time;

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

void main() {
    vec2 p = vertTexCoord.st;
    
    float period = 15.;
    float angle = PI * time/period;
    vec4 disp = texture2D(u_texture1, p);
    
    //~ Need BME280 (Environmental Sensor)
    //~ vec2 calcPosition = p + rotate2d(angle) * vec2(disp.r,disp.b) * (1.0 - temp) * 0.05;
    
    //~ No Need BME280 (Environmental Sensor)
    vec2 calcPosition = p + rotate2d(angle) * vec2(disp.r,disp.b) * (1.0 - 0.5) * 0.05;

    vec4 _texture = texture2D(u_texture2, calcPosition);
    gl_FragColor = _texture;
}
