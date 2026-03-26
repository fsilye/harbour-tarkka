import QtQuick 2.0

ShaderEffect {
    id: root

    property variant source
    property int filterType: 0
    property real brightness: 1
    property real contrast: 1

    fragmentShader: "

                    varying highp vec2 qt_TexCoord0;
                    uniform sampler2D source;
                    uniform lowp float qt_Opacity;
                    uniform int filterType;
                    uniform lowp float brightness;
                    uniform lowp float contrast;
                    void main() {
                        highp vec4 color = texture2D(source, qt_TexCoord0);

                        // Calc pixel brightness (from 0.0 to 1.0)
                        highp float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

                        // 0 is dark (text), 1 is light (background)
                        highp float stepVal = smoothstep(0.4, 0.6, gray);

                        if (filterType == 1) { highp float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114)); color.rgb = vec3(gray); } // Grayscale
                        else if (filterType == 2) { color.rgb = 1.0 - color.rgb; } // Negative
                        else if (filterType == 3) { if (color.r > 0.5) color.r = 1.0 - color.r; if (color.g > 0.5) color.g = 1.0 - color.g; if (color.b > 0.5) color.b = 1.0 - color.b; } // Solarize
                        else if (filterType == 4) { highp float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114)); color.rgb = vec3(smoothstep(0.3, 0.6, gray)); } // Whiteboard
                        else if (filterType == 5) { highp float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114)); color.rgb = vec3(1.0 - smoothstep(0.3, 0.6, gray)); } // Blackboard
                        else if (filterType == 6) { color.rgb = mix(vec3(1.0, 1.0, 0.0), vec3(0.0, 0.0, 0.0), stepVal); } // Yellow on black
                        else if (filterType == 7) { color.rgb = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 0.0), stepVal); } // Black on yellow
                        else if (filterType == 8) { color.rgb = mix(vec3(1.0, 1.0, 0.0), vec3(0.0, 0.0, 0.8), stepVal); } // Yellow on blue (blu 0.8)
                        else if (filterType == 9) { color.rgb = mix(vec3(0.0, 0.0, 0.8), vec3(1.0, 1.0, 0.0), stepVal); } // Blue on yellow
                        else if (filterType == 10) { color.rgb = mix(vec3(1.0, 1.0, 1.0), vec3(0.0, 0.0, 0.8), stepVal); } // White on blue
                        else if (filterType == 11) { color.rgb = mix(vec3(0.0, 0.0, 0.8), vec3(1.0, 1.0, 1.0), stepVal); } // Blue on white
                        else if (filterType == 12) { color.rgb = mix(vec3(1.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), stepVal); } // Red on black
                        else if (filterType == 13) { color.rgb = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 0.0, 0.0), stepVal); } // Black on red


                        color.rgb *= brightness; // Brightness
                        color.rgb = (color.rgb - 0.5) * contrast + 0.5; // Contrast
                        gl_FragColor = color * qt_Opacity;
                    }
                "

    source: ShaderEffectSource {
        sourceItem: viewfinder
        hideSource: true
    }

}
