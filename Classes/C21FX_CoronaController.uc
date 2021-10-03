
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures - coronas SD)
#exec TEXTURE IMPORT NAME=Corona FILE=Textures/Coronas/SD/Corona.bmp GROUP=Coronas MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=CoronaSunQ FILE=Textures/Coronas/SD/CoronaSunQ.bmp GROUP=Coronas MIPS=OFF LODSET=0

//Import directives (textures - coronas HD)
#exec TEXTURE MERGECOMPRESSED NAME=CoronaSunQ FILE=Textures/Coronas/HD/CoronaSunQ.png GROUP=Coronas MIPS=OFF LODSET=0 FORMAT=BC7

//Import directives (textures - lensflares SD)
#exec TEXTURE IMPORT NAME=Lensflare0Q FILE=Textures/Lensflares/SD/Lensflare0Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare1Q FILE=Textures/Lensflares/SD/Lensflare1Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare2Q FILE=Textures/Lensflares/SD/Lensflare2Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare3Q FILE=Textures/Lensflares/SD/Lensflare3Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare4Q FILE=Textures/Lensflares/SD/Lensflare4Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare5Q FILE=Textures/Lensflares/SD/Lensflare5Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare6D FILE=Textures/Lensflares/SD/Lensflare6D.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare7D FILE=Textures/Lensflares/SD/Lensflare7D.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare8Q FILE=Textures/Lensflares/SD/Lensflare8Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0

//Import directives (textures - lensflares HD)
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare0Q FILE=Textures/Lensflares/HD/Lensflare0Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare1Q FILE=Textures/Lensflares/HD/Lensflare1Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare2Q FILE=Textures/Lensflares/HD/Lensflare2Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare3Q FILE=Textures/Lensflares/HD/Lensflare3Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare4Q FILE=Textures/Lensflares/HD/Lensflare4Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare5Q FILE=Textures/Lensflares/HD/Lensflare5Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare6D FILE=Textures/Lensflares/HD/Lensflare6D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare7D FILE=Textures/Lensflares/HD/Lensflare7D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare8Q FILE=Textures/Lensflares/HD/Lensflare8Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7


//Constants
const CORONA_VISIBILITY_FADE_TIME = 0.1;
const CORONA_SCALE_FIXED = 0.125;
const LENSFLARE_SIZE_FIXED = 0.125;
const LENSFLARE_ENTRIES_COUNT = 16;


//Enumerations
enum ECoronaColorMode
{
	CCM_Auto,
	CCM_Value,
	CCM_Light,
	CCM_LightHS,
	CCM_LightHue
};

enum ECoronaScaleMode
{
	CSM_Auto,
	CSM_Fixed,
	CSM_World,
	CSM_Distance
};

enum ECoronaLinkAlignment
{
	CLA_Start,
	CLA_Center,
	CLA_Middle,
	CLA_End
};

enum ECoronaLinkGradientMode
{
	CLGM_None,
	CLGM_Linear,
	CLGM_NonLinear
};

enum ELensflarePreset
{
	LP_None,
	LP_Sun,
	LP_Preset2,
	LP_Preset3,
	LP_Preset4,
	LP_Custom
};

enum ELensflareMultiplierMode
{
	LMM_None,
	LMM_Linear,
	LMM_NonLinear
};

enum ELensflarePositionMode
{
	LPM_Value,
	LPM_Distributed
};

enum ELensflarePositionDistributionMode
{
	LPDM_Front,
	LPDM_Back,
	LPDM_Both
};

enum ELensflareTextureMode
{
	LTM_Value,
	LTM_Same
};

enum ELensflareColorMode
{
	LCM_Same,
	LCM_Value,
	LCM_Add,
	LCM_Subtract,
	LCM_Multiply,
	LCM_Intersect,
	LCM_Merge,
	LCM_Exclude
};

enum ELensflareSizeMode
{
	LSM_Fixed,
	LSM_Relative,
	LSM_Absolute
};


//Structures
struct NodeCoronaTexture
{
	var() bool bSmooth;
	var() ERenderTextureMode Render;
	var() Texture Value;
};

struct NodeCoronaScale
{
	var() ECoronaScaleMode Mode;
	var() RenderScale2D Value;
};

struct NodeCoronaColor
{
	var() ECoronaColorMode Mode;
	var() color Value;
};

struct NodeCoronaLinkGradientSize
{
	var() ECoronaLinkGradientMode Mode;
	var() float Value1;
	var() float Value2;
};

struct NodeCoronaLinkGradientGlow
{
	var() ECoronaLinkGradientMode Mode;
	var() float Value1;
	var() float Value2;
};

struct NodeCoronaLinkGradientScale
{
	var() ECoronaLinkGradientMode Mode;
	var() RenderScale2D Value1;
	var() RenderScale2D Value2;
};

struct NodeCoronaLinkGradientColor
{
	var() ECoronaLinkGradientMode Mode;
	var() color Value1;
	var() color Value2;
};

struct NodeCoronaLinkGradientSaturation
{
	var() ECoronaLinkGradientMode Mode;
	var() byte Value1;
	var() byte Value2;
};

struct NodeCoronaLinkGradient
{
	var() NodeCoronaLinkGradientSize Size;
	var() NodeCoronaLinkGradientGlow Glow;
	var() NodeCoronaLinkGradientScale Scale;
	var() NodeCoronaLinkGradientColor Color;
	var() NodeCoronaLinkGradientSaturation Saturation;
};

struct NodeCoronaLink
{
	var() float Density;
	var() ECoronaLinkAlignment Alignment;
	var() NodeCoronaLinkGradient Gradient;
};

struct NodeCorona
{
	var() NodeCoronaTexture Texture;
	var() float Size;
	var() float Glow;
	var() NodeCoronaScale Scale;
	var() NodeCoronaColor Color;
	var() byte Saturation;
	var() NodeCoronaLink Link;
};

struct NodeLensflareMultiplier
{
	var() bool bInvert;
	var() ELensflareMultiplierMode Mode;
};

struct NodeLensflarePositionDistribution
{
	var() byte Seed;
	var() byte Count;
	var() ELensflarePositionDistributionMode Mode;
};

struct NodeLensflarePosition
{
	var() float Value;
	var() ELensflarePositionMode Mode;
	var() NodeLensflarePositionDistribution Distribution;
};

struct NodeLensflareGlowMultiplier
{
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareGlow
{
	var() float Value;
	var() NodeLensflareGlowMultiplier Multiplier;
};

struct NodeLensflareTexture
{
	var() bool bSmooth;
	var() ELensflareTextureMode Mode;
	var() ERenderTextureMode Render;
	var() Texture Value;
};

struct NodeLensflareColorMultiplier
{
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareColor
{
	var() ELensflareColorMode Mode;
	var() color Min;
	var() color Max;
	var() NodeLensflareColorMultiplier Multiplier;
};

struct NodeLensflareSizeMultiplier
{
	var() NodeLensflareMultiplier Opacity;
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareSize
{
	var() ELensflareSizeMode Mode;
	var() float Min;
	var() float Max;
	var() NodeLensflareSizeMultiplier Multiplier;
};

struct NodeLensflareScaleMultiplier
{
	var() NodeLensflareMultiplier Opacity;
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareScale
{
	var() RenderScale2D Min;
	var() RenderScale2D Max;
	var() NodeLensflareScaleMultiplier Multiplier;
};

struct NodeLensflareDegree
{
	var() float Min;
	var() float Max;
	var() float FadeMin;
	var() float FadeMax;
};

struct NodeLensflareEntry
{
	var() NodeLensflareGlow Glow;
	var() NodeLensflarePosition Position;
	var() NodeLensflareTexture Texture;
	var() NodeLensflareColor Color;
	var() NodeLensflareSize Size;
	var() NodeLensflareScale Scale;
	var() NodeLensflareDegree Degree;
};

struct NodeLensflare
{
	var() ELensflarePreset Preset;
};

struct NodeLensflareCorona
{
	var color Color;
	var float Opacity;
	var float Distance;
	var RenderPoint2D Point;
	var RenderScale2D Scale;
	var Texture Texture;
	var ERenderTextureMode Render;
};


//Editable properties (controller)
var(Controller) NodeCorona Corona;
var(Controller) NodeLensflare Lensflare;


//Editable properties (presets)
var(Presets) NodeLensflareEntry LensflarePresetSun[LENSFLARE_ENTRIES_COUNT];
var(Presets) NodeLensflareEntry LensflarePresetCustom[LENSFLARE_ENTRIES_COUNT];


//Private properties
var private ELensflarePreset LensflarePreset;
var private NodeLensflareEntry LensflareEntry00;
var private NodeLensflareEntry LensflareEntry01;
var private NodeLensflareEntry LensflareEntry02;
var private NodeLensflareEntry LensflareEntry03;
var private NodeLensflareEntry LensflareEntry04;
var private NodeLensflareEntry LensflareEntry05;
var private NodeLensflareEntry LensflareEntry06;
var private NodeLensflareEntry LensflareEntry07;
var private NodeLensflareEntry LensflareEntry08;
var private NodeLensflareEntry LensflareEntry09;
var private NodeLensflareEntry LensflareEntry10;
var private NodeLensflareEntry LensflareEntry11;
var private NodeLensflareEntry LensflareEntry12;
var private NodeLensflareEntry LensflareEntry13;
var private NodeLensflareEntry LensflareEntry14;
var private NodeLensflareEntry LensflareEntry15;
var private NodeLensflareEntry LensflareEntries[LENSFLARE_ENTRIES_COUNT];


replication
{
	reliable if (Role == ROLE_Authority)
		Corona, LensflarePreset, LensflareEntry00, LensflareEntry01, LensflareEntry02, LensflareEntry03, LensflareEntry04,
		LensflareEntry05, LensflareEntry06, LensflareEntry07, LensflareEntry08, LensflareEntry09, LensflareEntry10,
		LensflareEntry11, LensflareEntry12, LensflareEntry13, LensflareEntry14, LensflareEntry15;
}


//Implemented events
event initialize()
{
	//local
	local byte i;
	
	//corona
	Corona.Size = fmax(Corona.Size, 0.0);
	Corona.Glow = fclamp(Corona.Glow, 0.0, 1.0);
	Corona.Link.Density = fmax(Corona.Link.Density, 0.0);
	Corona.Link.Gradient.Size.Value1 = fmax(Corona.Link.Gradient.Size.Value1, 0.0);
	Corona.Link.Gradient.Size.Value2 = fmax(Corona.Link.Gradient.Size.Value2, 0.0);
	Corona.Link.Gradient.Glow.Value1 = fclamp(Corona.Link.Gradient.Glow.Value1, 0.0, 1.0);
	Corona.Link.Gradient.Glow.Value2 = fclamp(Corona.Link.Gradient.Glow.Value2, 0.0, 1.0);
	
	//lensflares
	LensflarePreset = Lensflare.Preset;
	if (LensflarePreset != LP_None) {
		//prepare
		for (i = 0; i < LENSFLARE_ENTRIES_COUNT; i++) {
			//set
			switch (LensflarePreset) {
				case LP_Sun:
					LensflareEntries[i] = LensflarePresetSun[i];
					break;
				default:
					LensflareEntries[i] = LensflarePresetCustom[i];
					break;
			}
			
			//initialize
			LensflareEntries[i].Glow.Value = fclamp(LensflareEntries[i].Glow.Value, 0.0, 1.0);
			LensflareEntries[i].Position.Value = fclamp(LensflareEntries[i].Position.Value, -1.0, 1.0);
			LensflareEntries[i].Size.Min = fmax(LensflareEntries[i].Size.Min, 0.0);
			LensflareEntries[i].Size.Max = fmax(LensflareEntries[i].Size.Max, 0.0);
			LensflareEntries[i].Degree.Min = fclamp(LensflareEntries[i].Degree.Min, 0.0, 1.0);
			LensflareEntries[i].Degree.Max = fclamp(LensflareEntries[i].Degree.Max, 0.0, 1.0);
			LensflareEntries[i].Degree.FadeMin = fclamp(LensflareEntries[i].Degree.FadeMin, 0.0, 1.0);
			LensflareEntries[i].Degree.FadeMax = fclamp(LensflareEntries[i].Degree.FadeMax, 0.0, 1.0);
		}
		
		//replicate
		LensflareEntry00 = LensflareEntries[0];
		LensflareEntry01 = LensflareEntries[1];
		LensflareEntry02 = LensflareEntries[2];
		LensflareEntry03 = LensflareEntries[3];
		LensflareEntry04 = LensflareEntries[4];
		LensflareEntry05 = LensflareEntries[5];
		LensflareEntry06 = LensflareEntries[6];
		LensflareEntry07 = LensflareEntries[7];
		LensflareEntry08 = LensflareEntries[8];
		LensflareEntry09 = LensflareEntries[9];
		LensflareEntry10 = LensflareEntries[10];
		LensflareEntry11 = LensflareEntries[11];
		LensflareEntry12 = LensflareEntries[12];
		LensflareEntry13 = LensflareEntries[13];
		LensflareEntry14 = LensflareEntries[14];
		LensflareEntry15 = LensflareEntries[15];
	}
}


//Implemented simulated events
simulated event C21FX_Node createNode(Actor actor)
{
	return new class'C21FX_CoronaNode';
}

simulated event initializeNodesRender(RenderFrame frame)
{
	//canvas
	frame.Canvas.Style = ERenderStyle.STY_Translucent;
	
	//lensflares
	if (LensflarePreset != LP_None) {
		LensflareEntries[0] = LensflareEntry00;
		LensflareEntries[1] = LensflareEntry01;
		LensflareEntries[2] = LensflareEntry02;
		LensflareEntries[3] = LensflareEntry03;
		LensflareEntries[4] = LensflareEntry04;
		LensflareEntries[5] = LensflareEntry05;
		LensflareEntries[6] = LensflareEntry06;
		LensflareEntries[7] = LensflareEntry07;
		LensflareEntries[8] = LensflareEntry08;
		LensflareEntries[9] = LensflareEntry09;
		LensflareEntries[10] = LensflareEntry10;
		LensflareEntries[11] = LensflareEntry11;
		LensflareEntries[12] = LensflareEntry12;
		LensflareEntries[13] = LensflareEntry13;
		LensflareEntries[14] = LensflareEntry14;
		LensflareEntries[15] = LensflareEntry15;
	}
}

simulated event renderNode(C21FX_Node node, RenderFrame frame)
{
	renderCoronaNode(C21FX_CoronaNode(node), frame);
}

simulated event C21FX_Link createLink(C21FX_Point point1, C21FX_Point point2)
{
	return new class'C21FX_CoronaLink';
}

simulated event renderLink(C21FX_Link link, RenderFrame frame)
{
	renderCoronaLink(C21FX_CoronaLink(link), frame);
}


//Final simulated functions
final simulated function renderCoronaNode(C21FX_CoronaNode node, RenderFrame frame)
{
	//local
	local bool visible;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local ERenderPoint2DVisibility pointVisibility;
	local ECoronaScaleMode scaleMode;
	local ECoronaColorMode colorMode;
	local float fscale, opacity, gSize;
	local byte saturation;
	local color c, color;
	local NodeLensflareCorona lCorona;
	
	//check
	if (
		node == none || Corona.Texture.Value == none || Corona.Size <= 0.0 || Corona.Scale.Value.U <= 0.0 || 
		Corona.Scale.Value.V <= 0.0 || Corona.Glow <= 0.0
	) {
		return;
	}
	
	//visibility
	visible = isNodeVisible(node, frame, point);
	if (!visible) {
		point = locationToRenderPoint2D(node.Location, frame, pointVisibility);
		if (pointVisibility != RP2DV_Visible) {
			return;
		}
	}
	
	//opacity
	if (visible && node.Opacity < 1.0) {
		node.Opacity = fmin(node.Opacity + frame.Delta / CORONA_VISIBILITY_FADE_TIME, 1.0);
	} else if (!visible) {
		//reduce
		if (node.Opacity > 0.0) {
			node.Opacity = fmax(node.Opacity - frame.Delta / CORONA_VISIBILITY_FADE_TIME, 0.0);
		}
		
		//check
		if (node.Opacity == 0.0) {
			return;
		}
	}
	
	//scale mode
	scaleMode = Corona.Scale.Mode;
	if (scaleMode == CSM_Auto) {
		if (node.bLinked) {
			scaleMode = CSM_World;
		} else {
			scaleMode = CSM_Fixed;
		}
	}
	
	//scale
	if (scaleMode == CSM_Fixed || scaleMode == CSM_Distance) {
		//scale
		fscale = fmin(frame.Canvas.ClipX - frame.Canvas.OrgX, frame.Canvas.ClipY - frame.Canvas.OrgY) * 
			CORONA_SCALE_FIXED / float(max(Corona.Texture.Value.USize, Corona.Texture.Value.VSize));
		
		//distance
		if (scaleMode == CSM_Distance && Visibility.ViewDistance > 0.0) {
			fscale *= 1.0 - (node.Distance / Visibility.ViewDistance);
		}
		
		//finalize
		scale.U = fscale;
		scale.V = fscale;
		
	} else if (scaleMode == CSM_World) {
		scale = locationToRenderScale2D(node.Location, frame);
	}
	scale.U *= Corona.Scale.Value.U * Corona.Size;
	scale.V *= Corona.Scale.Value.V * Corona.Size;
	
	//gradient (size)
	if (node.bLinked && Corona.Link.Gradient.Size.Mode != CLGM_None) {
		if (Corona.Link.Gradient.Size.Mode == CLGM_NonLinear) {
			gSize = smerp(node.Position, Corona.Link.Gradient.Size.Value1, Corona.Link.Gradient.Size.Value2);
		} else {
			gSize = lerp(node.Position, Corona.Link.Gradient.Size.Value1, Corona.Link.Gradient.Size.Value2);
		}
		scale.U *= gSize;
		scale.V *= gSize;
	}
	
	//gradient (scale)
	if (node.bLinked && Corona.Link.Gradient.Scale.Mode != CLGM_None) {
		if (Corona.Link.Gradient.Scale.Mode == CLGM_NonLinear) {
			scale.U *= smerp(node.Position, Corona.Link.Gradient.Scale.Value1.U, Corona.Link.Gradient.Scale.Value2.U);
			scale.V *= smerp(node.Position, Corona.Link.Gradient.Scale.Value1.V, Corona.Link.Gradient.Scale.Value2.V);
		} else {
			scale.U *= lerp(node.Position, Corona.Link.Gradient.Scale.Value1.U, Corona.Link.Gradient.Scale.Value2.U);
			scale.V *= lerp(node.Position, Corona.Link.Gradient.Scale.Value1.V, Corona.Link.Gradient.Scale.Value2.V);
		}
	}
	
	//scale (check)
	if (scale.U <= 0.0 || scale.V <= 0.0) {
		return;
	}
	
	//opacity
	opacity = frame.Opacity * node.Opacity * Corona.Glow;
	
	//gradient (glow)
	if (node.bLinked && Corona.Link.Gradient.Glow.Mode != CLGM_None) {
		if (Corona.Link.Gradient.Glow.Mode == CLGM_NonLinear) {
			opacity *= smerp(node.Position, Corona.Link.Gradient.Glow.Value1, Corona.Link.Gradient.Glow.Value2);
		} else {
			opacity *= lerp(node.Position, Corona.Link.Gradient.Glow.Value1, Corona.Link.Gradient.Glow.Value2);
		}
	}
	
	//opacity (check)
	if (opacity <= 0.0) {
		return;
	}
	
	//color mode
	colorMode = Corona.Color.Mode;
	if (colorMode == CCM_Auto) {
		if (Light(node.Actor) != none) {
			colorMode = CCM_Light;
		} else {
			colorMode = CCM_Value;
		}
	}
	
	//color
	if (colorMode == CCM_Value) {
		if (node.bLinked && Corona.Link.Gradient.Color.Mode != CLGM_None) {
			if (Corona.Link.Gradient.Color.Mode == CLGM_NonLinear) {
				color.R = byte(
					smerp(node.Position, Corona.Link.Gradient.Color.Value1.R, Corona.Link.Gradient.Color.Value2.R)
				);
				color.G = byte(
					smerp(node.Position, Corona.Link.Gradient.Color.Value1.G, Corona.Link.Gradient.Color.Value2.G)
				);
				color.B = byte(
					smerp(node.Position, Corona.Link.Gradient.Color.Value1.B, Corona.Link.Gradient.Color.Value2.B)
				);
			} else {
				color.R = byte(
					lerp(node.Position, Corona.Link.Gradient.Color.Value1.R, Corona.Link.Gradient.Color.Value2.R)
				);
				color.G = byte(
					lerp(node.Position, Corona.Link.Gradient.Color.Value1.G, Corona.Link.Gradient.Color.Value2.G)
				);
				color.B = byte(
					lerp(node.Position, Corona.Link.Gradient.Color.Value1.B, Corona.Link.Gradient.Color.Value2.B)
				);
			}
		} else {
			color = Corona.Color.Value;
		}
	} else if (node.Actor != none) {
		if (colorMode == CCM_Light) {
			color = hsbToColor(node.Actor.LightHue, node.Actor.LightSaturation, node.Actor.LightBrightness);
		} else if (colorMode == CCM_LightHS) {
			color = hsbToColor(node.Actor.LightHue, node.Actor.LightSaturation, 255);
		} else if (colorMode == CCM_LightHue) {
			if (node.bLinked && Corona.Link.Gradient.Saturation.Mode != CLGM_None) {
				if (Corona.Link.Gradient.Saturation.Mode == CLGM_NonLinear) {
					saturation = byte(smerp(
						node.Position, Corona.Link.Gradient.Saturation.Value1, Corona.Link.Gradient.Saturation.Value2
					));
				} else {
					saturation = byte(lerp(
						node.Position, Corona.Link.Gradient.Saturation.Value1, Corona.Link.Gradient.Saturation.Value2
					));
				}
			} else {
				saturation = Corona.Saturation;
			}
			color = hsbToColor(node.Actor.LightHue, saturation, 255);
		}
	}
	c.R = byte(float(color.R) * opacity);
	c.G = byte(float(color.G) * opacity);
	c.B = byte(float(color.B) * opacity);
	
	//color (check)
	if (c.R == 0 && c.G == 0 && c.B == 0) {
		return;
	}
	
	//draw
	setRenderFrameNearestZ(frame, node.Distance);
	drawSprite(frame, Corona.Texture.Value, c, point, scale, true, true, Corona.Texture.Render, Corona.Texture.bSmooth);
	
	//lensflares
	if (LensflarePreset != LP_None) {
		lCorona.Color = color;
		lCorona.Opacity = opacity;
		lCorona.Distance = node.Distance;
		lCorona.Point = point;
		lCorona.Scale = scale;
		lCorona.Texture = Corona.Texture.Value;
		lCorona.Render = Corona.Texture.Render;
		drawLensflares(lCorona, frame);
	}
}

final simulated function drawLensflares(NodeLensflareCorona corona, RenderFrame frame)
{
	//local
	local int seed;
	local byte i, j, count;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local float degree, position, absPosition, opacity, alpha, size, sAlpha, cAlpha, f;
	local color colorMin, colorMax, c;
	local vector vector, pointVector;
	local NodeLensflareEntry entry;
	local Texture texture;
	local ERenderTextureMode renderMode;
	
	//check
	if (LensflarePreset == LP_None) {
		return;
	}
	
	//vector
	vector.X = lerp(0.5, frame.Canvas.OrgX, frame.Canvas.ClipX) - corona.Point.X;
	vector.Y = lerp(0.5, frame.Canvas.OrgY, frame.Canvas.ClipY) - corona.Point.Y;
	vector *= 2.0;
	
	//degree
	degree = fmax(
		abs(vector.X / (frame.Canvas.ClipX - frame.Canvas.OrgX)),
		abs(vector.Y / (frame.Canvas.ClipY - frame.Canvas.OrgY))
	);
	
	//z
	setRenderFrameNearestZ(frame, corona.Distance);
	
	//entries
	for (i = 0; i < LENSFLARE_ENTRIES_COUNT; i++) {
		//entry
		entry = LensflareEntries[i];
		
		//texture
		if (entry.Texture.Mode == LTM_Same) {
			texture = corona.Texture;
			renderMode = corona.Render;
		} else {
			texture = entry.Texture.Value;
			renderMode = entry.Texture.Render;
		}
		
		//check
		if (texture == none || entry.Glow.Value <= 0.0 || degree < entry.Degree.Min || degree > entry.Degree.Max) {
			continue;
		}
		
		//seed and count
		if (entry.Position.Mode == LPM_Distributed) {
			seed = int(entry.Position.Distribution.Seed) * 256 + 1;
			count = entry.Position.Distribution.Count;
		} else {
			count = 1;
		}
		
		//iterate
		for (j = 0; j < count; j++) {
			//position
			if (entry.Position.Mode == LPM_Distributed) {
				position = fxrand(seed);
				switch (entry.Position.Distribution.Mode) {
					case LPDM_Back:
						position = -position;
						break;
					case LPDM_Both:
						position = position * 2.0 - 1.0;
						break;
				}
			} else {
				position = entry.Position.Value;
			}
			absPosition = abs(position);
			
			//opacity
			opacity = corona.Opacity * entry.Glow.Value;
			if (degree < entry.Degree.FadeMin && entry.Degree.FadeMin > entry.Degree.Min) {
				opacity *= (degree - entry.Degree.Min) / (entry.Degree.FadeMin - entry.Degree.Min);
			} else if (degree > entry.Degree.FadeMax && entry.Degree.FadeMax < entry.Degree.Max) {
				opacity *= 1.0 - (degree - entry.Degree.FadeMax) / (entry.Degree.Max - entry.Degree.FadeMax);
			}
			
			//opacity (multiplier)
			if (entry.Glow.Multiplier.Position.Mode != LMM_None) {
				opacity *= lensflareMultiplierAlpha(absPosition, entry.Glow.Multiplier.Position);
			}
			
			//opacity (check)
			if (opacity <= 0.0) {
				continue;
			}
			
			//alpha
			alpha = (degree - entry.Degree.Min) / (entry.Degree.Max - entry.Degree.Min);
			
			//size (alpha)
			sAlpha = alpha;
			if (entry.Size.Multiplier.Opacity.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(opacity, entry.Size.Multiplier.Opacity);
			}
			if (entry.Size.Multiplier.Position.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(absPosition, entry.Size.Multiplier.Position);
			}
			
			//size
			size = lerp(sAlpha, entry.Size.Min, entry.Size.Max);
			
			//size (check)
			if (size <= 0.0) {
				continue;
			}
			
			//scale (alpha)
			sAlpha = alpha;
			if (entry.Scale.Multiplier.Opacity.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(opacity, entry.Scale.Multiplier.Opacity);
			}
			if (entry.Scale.Multiplier.Position.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(absPosition, entry.Scale.Multiplier.Position);
			}
			
			//scale (set)
			scale.U = size * lerp(sAlpha, entry.Scale.Min.U, entry.Scale.Max.U);
			scale.V = size * lerp(sAlpha, entry.Scale.Min.V, entry.Scale.Max.V);
			switch (entry.Size.Mode) {
				case LSM_Fixed:
					size = fmin(frame.Canvas.ClipX - frame.Canvas.OrgX, frame.Canvas.ClipY - frame.Canvas.OrgY) * 
						LENSFLARE_SIZE_FIXED / float(max(entry.Texture.Value.USize, entry.Texture.Value.VSize));
					scale.U *= size;
					scale.V *= size;
					break;
				case LSM_Relative:
					scale.U *= corona.Scale.U;
					scale.V *= corona.Scale.V;
					break;
			}
			
			//scale (check)
			if (scale.U <= 0.0 || scale.V <= 0.0) {
				continue;
			}
			
			//color
			switch (entry.Color.Mode) {
				case LCM_Same:
					colorMin = corona.Color;
					colorMax = corona.Color;
					break;
				case LCM_Value:
					colorMin = entry.Color.Min;
					colorMax = entry.Color.Max;
					break;
				case LCM_Add:
					colorMin.R = byte(min(int(corona.Color.R) + int(entry.Color.Min.R), 255));
					colorMin.G = byte(min(int(corona.Color.G) + int(entry.Color.Min.G), 255));
					colorMin.B = byte(min(int(corona.Color.B) + int(entry.Color.Min.B), 255));
					colorMax.R = byte(min(int(corona.Color.R) + int(entry.Color.Max.R), 255));
					colorMax.G = byte(min(int(corona.Color.G) + int(entry.Color.Max.G), 255));
					colorMax.B = byte(min(int(corona.Color.B) + int(entry.Color.Max.B), 255));
					break;
				case LCM_Subtract:
					colorMin.R = byte(max(int(corona.Color.R) - int(entry.Color.Min.R), 0));
					colorMin.G = byte(max(int(corona.Color.G) - int(entry.Color.Min.G), 0));
					colorMin.B = byte(max(int(corona.Color.B) - int(entry.Color.Min.B), 0));
					colorMax.R = byte(max(int(corona.Color.R) - int(entry.Color.Max.R), 0));
					colorMax.G = byte(max(int(corona.Color.G) - int(entry.Color.Max.G), 0));
					colorMax.B = byte(max(int(corona.Color.B) - int(entry.Color.Max.B), 0));
					break;
				case LCM_Multiply:
					f = 1.0 / 255.0;
					colorMin.R = byte(fmin(float(corona.Color.R) * float(entry.Color.Min.R) * f, 255.0));
					colorMin.G = byte(fmin(float(corona.Color.G) * float(entry.Color.Min.G) * f, 255.0));
					colorMin.B = byte(fmin(float(corona.Color.B) * float(entry.Color.Min.B) * f, 255.0));
					colorMax.R = byte(fmin(float(corona.Color.R) * float(entry.Color.Max.R) * f, 255.0));
					colorMax.G = byte(fmin(float(corona.Color.G) * float(entry.Color.Max.G) * f, 255.0));
					colorMax.B = byte(fmin(float(corona.Color.B) * float(entry.Color.Max.B) * f, 255.0));
					break;
				case LCM_Intersect:
					colorMin.R = byte(int(corona.Color.R) & int(entry.Color.Min.R));
					colorMin.G = byte(int(corona.Color.G) & int(entry.Color.Min.G));
					colorMin.B = byte(int(corona.Color.B) & int(entry.Color.Min.B));
					colorMax.R = byte(int(corona.Color.R) & int(entry.Color.Max.R));
					colorMax.G = byte(int(corona.Color.G) & int(entry.Color.Max.G));
					colorMax.B = byte(int(corona.Color.B) & int(entry.Color.Max.B));
					break;
				case LCM_Merge:
					colorMin.R = byte(int(corona.Color.R) | int(entry.Color.Min.R));
					colorMin.G = byte(int(corona.Color.G) | int(entry.Color.Min.G));
					colorMin.B = byte(int(corona.Color.B) | int(entry.Color.Min.B));
					colorMax.R = byte(int(corona.Color.R) | int(entry.Color.Max.R));
					colorMax.G = byte(int(corona.Color.G) | int(entry.Color.Max.G));
					colorMax.B = byte(int(corona.Color.B) | int(entry.Color.Max.B));
					break;
				case LCM_Exclude:
					colorMin.R = byte(int(corona.Color.R) ^ int(entry.Color.Min.R));
					colorMin.G = byte(int(corona.Color.G) ^ int(entry.Color.Min.G));
					colorMin.B = byte(int(corona.Color.B) ^ int(entry.Color.Min.B));
					colorMax.R = byte(int(corona.Color.R) ^ int(entry.Color.Max.R));
					colorMax.G = byte(int(corona.Color.G) ^ int(entry.Color.Max.G));
					colorMax.B = byte(int(corona.Color.B) ^ int(entry.Color.Max.B));
					break;
			}
			
			//color (alpha)
			cAlpha = alpha;
			if (entry.Color.Multiplier.Position.Mode != LMM_None) {
				cAlpha *= lensflareMultiplierAlpha(absPosition, entry.Color.Multiplier.Position);
			}
			
			//color (set)
			c.R = byte(lerp(cAlpha, colorMin.R, colorMax.R) * opacity);
			c.G = byte(lerp(cAlpha, colorMin.G, colorMax.G) * opacity);
			c.B = byte(lerp(cAlpha, colorMin.B, colorMax.B) * opacity);
			
			//color (check)
			if (c.R == 0 && c.G == 0 && c.B == 0) {
				continue;
			}
			
			//point
			pointVector = vector * position;
			point.X = corona.Point.X + pointVector.X;
			point.Y = corona.Point.Y + pointVector.Y;
			
			//draw
			drawSprite(frame, texture, c, point, scale, true, true, renderMode, entry.Texture.bSmooth);
		}
	}
}

final simulated function renderCoronaLink(C21FX_CoronaLink link, RenderFrame frame)
{
	//local
	local vector vector;
	local float distance, fcount, position, unit;
	local int count, i, imax;
	local C21FX_CoronaNode node;
	
	//check
	if (
		link == none || link.Point1 == none || link.Point2 == none || Corona.Texture.Value == none || 
		Corona.Link.Density <= 0.0
	) {
		return;
	}
	
	//initialize
	vector = link.Point2.Location - link.Point1.Location;
	distance = vsize(vector);
	fcount = distance / fmax(Corona.Texture.Value.USize, Corona.Texture.Value.VSize) * Corona.Link.Density;
	count = int(fcount);
	
	//check (count)
	if (count == 0) {
		return;
	}
	
	//nodes
	if (
		link.RootNode == none || link.Point1.Location != link.Point1.OldLocation || 
		link.Point2.Location != link.Point2.OldLocation
	) {
		//imax
		imax = count - 1;
		if (Corona.Link.Alignment == CLA_Middle && (imax % 2) == 0) {
			if (imax == 0) {
				return;
			}
			imax--;
		}
		
		//setup
		node = link.RootNode;
		for (i = 0; i <= imax; i++) {
			if (node == none) {
				link.RootNode = C21FX_CoronaNode(generateNode(link.RootNode, link.Point1));
				link.RootNode.bLinked = true;
			} else {
				node.bEnd = i == imax || node.NextNode == none;
				node = C21FX_CoronaNode(node.NextNode);
			}
		}
		
		//position
		unit = 1.0 / (fcount - 1.0);
		if (Corona.Link.Alignment > CLA_Start) {
			position = 1.0 - unit * float(imax);
			if (Corona.Link.Alignment == CLA_Center || Corona.Link.Alignment == CLA_Middle) {
				position *= 0.5;
			}
		}
		
		//locations
		for (node = link.RootNode; node != none; node = C21FX_CoronaNode(node.NextNode)) {
			//set
			node.Position = position;
			node.Location = link.Point1.Location + position * vector;
			position = fmin(position + unit, 1.0);
			
			//finalize
			if (node.bEnd) {
				break;
			}
		}
	}
	
	//draw
	drawNodes(link.RootNode, frame);
}


//Final static functions
final static function float lensflareMultiplierAlpha(float alpha, NodeLensflareMultiplier multiplier)
{
	if (multiplier.Mode == LMM_NonLinear) {
		if (multiplier.bInvert) {
			alpha = smerp(alpha, 1.0, 0.0);
		} else {
			alpha = smerp(alpha, 0.0, 1.0);
		}
	} else if (multiplier.bInvert) {
		alpha = 1.0 - alpha;
	}
	return alpha;
}



defaultproperties
{
	//editables (controller - corona)
	Corona=(Texture=(bSmooth=true,Value=Texture'Corona'),Size=1.0,Glow=1.0)
	Corona=(Scale=(Value=(U=1.0,V=1.0)))
	Corona=(Color=(Value=(R=255,G=255,B=255)))
	Corona=(Link=(Density=1.0,Alignment=CLA_Center))
	Corona=(Link=(Gradient=(Size=(Value1=1.0,Value2=1.0))))
	Corona=(Link=(Gradient=(Glow=(Value1=1.0,Value2=1.0))))
	Corona=(Link=(Gradient=(Scale=(Value1=(U=1.0,V=1.0),Value2=(U=1.0,V=1.0)))))
	Corona=(Link=(Gradient=(Color=(Value1=(R=255,G=255,B=255),Value2=(R=255,G=255,B=255)))))
	
	//editables (presets - sun lensflares)
	LensflarePresetSun(0)=(Glow=(Value=1.0))
	LensflarePresetSun(0)=(Position=(Value=0.0))
	LensflarePresetSun(0)=(Texture=(bSmooth=true,Mode=LTM_Same))
	LensflarePresetSun(0)=(Color=(Mode=LCM_Value,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(0)=(Size=(Mode=LSM_Relative,Min=0.5,Max=0.25),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(0)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetSun(1)=(Glow=(Value=0.4))
	LensflarePresetSun(1)=(Position=(Value=0.0))
	LensflarePresetSun(1)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare4Q'))
	LensflarePresetSun(1)=(Color=(Mode=LCM_Same))
	LensflarePresetSun(1)=(Size=(Mode=LSM_Fixed,Min=5.0,Max=10.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(1)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=0.75,Max=1.0))
	
	LensflarePresetSun(2)=(Glow=(Value=0.15))
	LensflarePresetSun(2)=(Position=(Value=0.0))
	LensflarePresetSun(2)=(Texture=(bSmooth=true,Render=RTM_MirrorU,Value=Texture'Lensflare6D'))
	LensflarePresetSun(2)=(Color=(Mode=LCM_Same))
	LensflarePresetSun(2)=(Size=(Mode=LSM_Fixed,Min=5.0,Max=5.0),Scale=(Min=(U=2.0,V=1.0),Max=(U=4.0,V=1.0)))
	LensflarePresetSun(2)=(Degree=(Min=0.0,FadeMin=0.1,FadeMax=0.85,Max=1.0))
	
	LensflarePresetSun(3)=(Glow=(Value=0.15))
	LensflarePresetSun(3)=(Position=(Value=0.0))
	LensflarePresetSun(3)=(Texture=(bSmooth=true,Render=RTM_MirrorV,Value=Texture'Lensflare7D'))
	LensflarePresetSun(3)=(Color=(Mode=LCM_Same))
	LensflarePresetSun(3)=(Size=(Mode=LSM_Fixed,Min=5.0,Max=5.0),Scale=(Min=(U=1.0,V=2.0),Max=(U=1.0,V=4.0)))
	LensflarePresetSun(3)=(Degree=(Min=0.0,FadeMin=0.1,FadeMax=0.85,Max=1.0))
	
	LensflarePresetSun(4)=(Glow=(Value=0.25))
	LensflarePresetSun(4)=(Position=(Value=0.2))
	LensflarePresetSun(4)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare8Q'))
	LensflarePresetSun(4)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(4)=(Size=(Mode=LSM_Fixed,Min=1.0,Max=10.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(4)=(Degree=(Min=0.2,FadeMin=0.4,FadeMax=0.7,Max=1.0))
	
	LensflarePresetSun(5)=(Glow=(Value=0.2))
	LensflarePresetSun(5)=(Position=(Value=1.0))
	LensflarePresetSun(5)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare0Q'))
	LensflarePresetSun(5)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=192)))
	LensflarePresetSun(5)=(Size=(Mode=LSM_Fixed,Min=0.1,Max=0.375),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(5)=(Degree=(Min=0.0,FadeMin=0.35,FadeMax=0.8,Max=0.9))
	
	LensflarePresetSun(6)=(Glow=(Value=0.2))
	LensflarePresetSun(6)=(Position=(Value=0.35))
	LensflarePresetSun(6)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare2Q'))
	LensflarePresetSun(6)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=128,G=255,B=192)))
	LensflarePresetSun(6)=(Size=(Mode=LSM_Fixed,Min=0.3,Max=1.5),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(6)=(Degree=(Min=0.05,FadeMin=0.35,FadeMax=0.7,Max=0.95))
	
	LensflarePresetSun(7)=(Glow=(Value=0.75))
	LensflarePresetSun(7)=(Position=(Value=0.65))
	LensflarePresetSun(7)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare3Q'))
	LensflarePresetSun(7)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=192,G=255,B=192)))
	LensflarePresetSun(7)=(Size=(Mode=LSM_Fixed,Min=0.05,Max=0.25),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(7)=(Degree=(Min=0.1,FadeMin=0.6,FadeMax=0.8,Max=0.95))
	
	LensflarePresetSun(8)=(Glow=(Value=0.15))
	LensflarePresetSun(8)=(Position=(Value=0.75))
	LensflarePresetSun(8)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare0Q'))
	LensflarePresetSun(8)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=192),Max=(R=192,G=255,B=255)))
	LensflarePresetSun(8)=(Size=(Mode=LSM_Fixed,Min=0.4,Max=0.95),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(8)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.85,Max=0.95))
	
	LensflarePresetSun(9)=(Glow=(Value=0.65))
	LensflarePresetSun(9)=(Position=(Value=0.8))
	LensflarePresetSun(9)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare3Q'))
	LensflarePresetSun(9)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=128,G=192,B=255)))
	LensflarePresetSun(9)=(Size=(Mode=LSM_Fixed,Min=0.1,Max=0.4),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(9)=(Degree=(Min=0.0,FadeMin=0.1,FadeMax=0.5,Max=0.95))
	
	LensflarePresetSun(10)=(Glow=(Value=0.17))
	LensflarePresetSun(10)=(Position=(Value=0.45))
	LensflarePresetSun(10)=(Texture=(bSmooth=true,Render=RTM_MirrorQ,Value=Texture'Lensflare0Q'))
	LensflarePresetSun(10)=(Color=(Mode=LCM_Multiply,Min=(R=192,G=255,B=255),Max=(R=128,G=255,B=192)))
	LensflarePresetSun(10)=(Size=(Mode=LSM_Fixed,Min=0.2,Max=0.75),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(10)=(Degree=(Min=0.1,FadeMin=0.2,FadeMax=0.9,Max=1.0))
	
	//editables (presets - custom lensflares)
	LensflarePresetCustom(0)=(Glow=(Value=1.0))
	LensflarePresetCustom(0)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(0)=(Texture=(bSmooth=true))
	LensflarePresetCustom(0)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(0)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(0)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(1)=(Glow=(Value=1.0))
	LensflarePresetCustom(1)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(1)=(Texture=(bSmooth=true))
	LensflarePresetCustom(1)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(1)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(1)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(2)=(Glow=(Value=1.0))
	LensflarePresetCustom(2)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(2)=(Texture=(bSmooth=true))
	LensflarePresetCustom(2)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(2)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(2)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(3)=(Glow=(Value=1.0))
	LensflarePresetCustom(3)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(3)=(Texture=(bSmooth=true))
	LensflarePresetCustom(3)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(3)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(3)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(4)=(Glow=(Value=1.0))
	LensflarePresetCustom(4)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(4)=(Texture=(bSmooth=true))
	LensflarePresetCustom(4)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(4)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(4)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(5)=(Glow=(Value=1.0))
	LensflarePresetCustom(5)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(5)=(Texture=(bSmooth=true))
	LensflarePresetCustom(5)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(5)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(5)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(6)=(Glow=(Value=1.0))
	LensflarePresetCustom(6)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(6)=(Texture=(bSmooth=true))
	LensflarePresetCustom(6)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(6)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(6)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(7)=(Glow=(Value=1.0))
	LensflarePresetCustom(7)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(7)=(Texture=(bSmooth=true))
	LensflarePresetCustom(7)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(7)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(7)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(8)=(Glow=(Value=1.0))
	LensflarePresetCustom(8)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(8)=(Texture=(bSmooth=true))
	LensflarePresetCustom(8)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(8)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(8)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(9)=(Glow=(Value=1.0))
	LensflarePresetCustom(9)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(9)=(Texture=(bSmooth=true))
	LensflarePresetCustom(9)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(9)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(9)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(10)=(Glow=(Value=1.0))
	LensflarePresetCustom(10)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(10)=(Texture=(bSmooth=true))
	LensflarePresetCustom(10)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(10)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(10)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(11)=(Glow=(Value=1.0))
	LensflarePresetCustom(11)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(11)=(Texture=(bSmooth=true))
	LensflarePresetCustom(11)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(11)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(11)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(12)=(Glow=(Value=1.0))
	LensflarePresetCustom(12)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(12)=(Texture=(bSmooth=true))
	LensflarePresetCustom(12)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(12)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(12)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(13)=(Glow=(Value=1.0))
	LensflarePresetCustom(13)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(13)=(Texture=(bSmooth=true))
	LensflarePresetCustom(13)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(13)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(13)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(14)=(Glow=(Value=1.0))
	LensflarePresetCustom(14)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(14)=(Texture=(bSmooth=true))
	LensflarePresetCustom(14)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(14)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(14)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(15)=(Glow=(Value=1.0))
	LensflarePresetCustom(15)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(15)=(Texture=(bSmooth=true))
	LensflarePresetCustom(15)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(15)=(Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(15)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
}
