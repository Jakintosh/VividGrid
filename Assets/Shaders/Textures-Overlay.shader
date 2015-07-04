﻿ //Somehow achieves an effect similar to this:
 //#define BlendOverlayf(base, blend)     (base < 0.5 ? (2.0 * base * blend) : (1.0 - 2.0 * (1.0 - base) * (1.0 - blend)))
 
 Shader "Unlit/Overlay"
 {
     Properties
     {
         _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
         _Alpha ("Alpha", Range(0,1)) = 1.0
     }
     
     SubShader
     {
         Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
         ZWrite Off Lighting Off Cull Off Fog { Mode Off } Blend DstColor SrcColor
         LOD 110
         
         Pass
         {
             CGPROGRAM
             #pragma vertex vert_vct
             #pragma fragment frag_mult
             #pragma fragmentoption ARB_precision_hint_fastest
             #include "UnityCG.cginc"
 
             sampler2D _MainTex;
             float4 _MainTex_ST;
             float _Alpha;
 
             struct vin_vct
             {
                 float4 vertex : POSITION;
                 float4 color : COLOR;
                 float2 texcoord : TEXCOORD0;
             };
 
             struct v2f_vct
             {
                 float4 vertex : POSITION;
                 fixed4 color : COLOR;
                 half2 texcoord : TEXCOORD0;
             };
 
             v2f_vct vert_vct(vin_vct v)
             {
                 v2f_vct o;
                 o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                 o.color = v.color;
                 o.texcoord = v.texcoord;
                 return o;
             }
 
             float4 frag_mult(v2f_vct i) : COLOR
             {
                 float4 tex = tex2D(_MainTex, float4(i.texcoord.xy * _MainTex_ST,0 ,0));
                 
                 float4 final;
                 final.rgb = i.color.rgb * tex.rgb * 2;
                 final.a = i.color.a * tex.a * _Alpha;
                 return lerp(float4(0.5f,0.5f,0.5f,0.5f), final, final.a);
             }
             ENDCG
         }
     }
 }