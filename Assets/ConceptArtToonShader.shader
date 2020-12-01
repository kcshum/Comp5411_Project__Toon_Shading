Shader "MyToon/ConceptArtToonShader" {
    Properties{
        //rgb map
        _MainTex("RGB Map", 2D) = "white" {}
        //normal map
        _BumpMap("Normal Map", 2D) = "bump" {}
        //ramp map
        _RampTexture("Ramp Texture", 2D) = "white" {}
        //toon level
        _ToonLevel("ToonLevel", Range(0.1,20)) = 1
        //shadow level
        _ShadowLevel("ShadowLevel", Range(0,1)) = 0.2

    }
    SubShader{
        //reder nontransparent objects
        Tags { "RenderType" = "Opaque" }
        //allow usages of below programming style, use Unity embeded optimizer
        LOD 200
        CGPROGRAM
        #pragma surface surf Toon
        //initialize variables, adding _ is the usual programming style for global variables in Unity
        float _ToonLevel;
        float _ShadowLevel;

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _RampTexture;
        //uv Map & View Direction
        struct Input {
            float3 viewDir;
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        //add shadow/thick outline
        void surf(Input input, inout SurfaceOutput output) {
            //get rgb
            half4 tex = tex2D(_MainTex, input.uv_MainTex);
            //get normal
            output.Normal = UnpackNormal(tex2D(_BumpMap, input.uv_BumpMap));
            //determine whether add shadow or not, normalize the value to 0-1 for convenience
            half shadowDecider = saturate(dot(output.Normal, normalize(input.viewDir)));
            if (shadowDecider < _ShadowLevel) {
                shadowDecider /= 4;
            }
            else {
                shadowDecider = 1;
            }
            //update to output
            //'floor(tex.rgb * _ToonLevel) / _ToonLevel' is to simplify the color distribution since tex.rgb is in range 0-1
            output.Alpha = tex.a;
            output.Albedo = shadowDecider * (floor(tex.rgb * _ToonLevel) / _ToonLevel);
        }

        //lighting
        half4 LightingToon(SurfaceOutput surOutput, fixed3 lightDirection, half3 viewDirection, fixed atten)
        {
            //light up for ToonShading using both diffuse light and rim light
            float diffuse = dot(surOutput.Normal, lightDirection);
            diffuse = 0.5 * (diffuse + 1);
            float rim = dot(surOutput.Normal, viewDirection);
            rim = 0.5 * (rim + 1);
            //get ramp
            float3 ramp = tex2D(_RampTexture, float2(rim, diffuse)).rgb;
            //update to output
            float4 output;
            output.a = surOutput.Alpha;
            //base rgb & directional light & ramp map & constant coefficient for light up also(atten * 1.1)
            output.rgb = surOutput.Albedo * _LightColor0.rgb * ramp * atten * 1.1;
            return output;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
