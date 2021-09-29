
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures - coronas)
#exec TEXTURE IMPORT NAME=Corona FILE=Textures/Coronas/Corona.bmp GROUP=Coronas MIPS=OFF LODSET=0

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
const LENSFLARE_ENTRIES_COUNT = 8;


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

enum ELensflareKind
{
	LK_None,
	LK_Sun,
	LK_Preset2,
	LK_Preset3,
	LK_Preset4,
	LK_Custom
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


//Structures
struct NodeCoronaTexture
{
	var() bool bSmooth;
	var() ERenderTextureMode Mode;
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

struct NodeLensflareTexture
{
	var() bool bSmooth;
	var() ERenderTextureMode Mode;
	var() Texture Value;
};

struct NodeLensflareColor
{
	var() ELensflareColorMode Mode;
	var() color Min;
	var() color Max;
};

struct NodeLensflareSize
{
	var() float Min;
	var() float Max;
};

struct NodeLensflareScale
{
	var() RenderScale2D Min;
	var() RenderScale2D Max;
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
	var() float Glow;
	var() float Position;
	var() NodeLensflareTexture Texture;
	var() NodeLensflareColor Color;
	var() NodeLensflareSize Size;
	var() NodeLensflareScale Scale;
	var() NodeLensflareDegree Degree;
};

struct NodeLensflare
{
	var() ELensflareKind Kind;
	var() NodeLensflareEntry Custom[LENSFLARE_ENTRIES_COUNT];
};

struct NodeLensflareCorona
{
	var color Color;
	var float Opacity;
	var float Distance;
	var RenderPoint2D Point;
	var RenderScale2D Scale;
};


//Editable properties (controller)
var(Controller) NodeCorona Corona;
var(Controller) NodeLensflare Lensflare;


//Private properties
var private NodeLensflareEntry LensflareEntries[LENSFLARE_ENTRIES_COUNT];
var private NodeLensflareEntry LensflarePresetSunEntries[LENSFLARE_ENTRIES_COUNT];


replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		Corona, Lensflare;
}


//Implemented events
event initialize()
{
	Corona.Size = fmax(Corona.Size, 0.0);
	Corona.Glow = fclamp(Corona.Glow, 0.0, 1.0);
	Corona.Link.Density = fmax(Corona.Link.Density, 0.0);
	Corona.Link.Gradient.Size.Value1 = fmax(Corona.Link.Gradient.Size.Value1, 0.0);
	Corona.Link.Gradient.Size.Value2 = fmax(Corona.Link.Gradient.Size.Value2, 0.0);
	Corona.Link.Gradient.Glow.Value1 = fclamp(Corona.Link.Gradient.Glow.Value1, 0.0, 1.0);
	Corona.Link.Gradient.Glow.Value2 = fclamp(Corona.Link.Gradient.Glow.Value2, 0.0, 1.0);
}


//Implemented simulated events
simulated event C21FX_Node createNode(Actor actor)
{
	return new class'C21FX_CoronaNode';
}

simulated event initializeNodesRender(RenderFrame frame)
{
	//local
	local byte i;
	
	//canvas
	frame.Canvas.Style = ERenderStyle.STY_Translucent;
	
	//lensflares
	if (Lensflare.Kind > LK_None) {
		for (i = 0; i < LENSFLARE_ENTRIES_COUNT; i++) {
			//set
			switch (Lensflare.Kind) {
				case LK_Sun:
					LensflareEntries[i] = LensflarePresetSunEntries[i];
					break;
				default:
					LensflareEntries[i] = Lensflare.Custom[i];
					break;
			}
			
			//initialize
			LensflareEntries[i].Glow = fclamp(LensflareEntries[i].Glow, 0.0, 1.0);
			LensflareEntries[i].Position = fclamp(LensflareEntries[i].Position, -1.0, 1.0);
			LensflareEntries[i].Size.Min = fmax(LensflareEntries[i].Size.Min, 0.0);
			LensflareEntries[i].Size.Max = fmax(LensflareEntries[i].Size.Max, 0.0);
			LensflareEntries[i].Degree.Min = fclamp(LensflareEntries[i].Degree.Min, 0.0, 1.0);
			LensflareEntries[i].Degree.Max = fclamp(LensflareEntries[i].Degree.Max, 0.0, 1.0);
			LensflareEntries[i].Degree.FadeMin = fclamp(LensflareEntries[i].Degree.FadeMin, 0.0, 1.0);
			LensflareEntries[i].Degree.FadeMax = fclamp(LensflareEntries[i].Degree.FadeMax, 0.0, 1.0);
		}
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
	if (node.bLinked && Corona.Link.Gradient.Size.Mode > CLGM_None) {
		if (Corona.Link.Gradient.Size.Mode == CLGM_NonLinear) {
			gSize = smerp(node.Position, Corona.Link.Gradient.Size.Value1, Corona.Link.Gradient.Size.Value2);
		} else {
			gSize = lerp(node.Position, Corona.Link.Gradient.Size.Value1, Corona.Link.Gradient.Size.Value2);
		}
		scale.U *= gSize;
		scale.V *= gSize;
	}
	
	//gradient (scale)
	if (node.bLinked && Corona.Link.Gradient.Scale.Mode > CLGM_None) {
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
	if (node.bLinked && Corona.Link.Gradient.Glow.Mode > CLGM_None) {
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
		if (node.bLinked && Corona.Link.Gradient.Color.Mode > CLGM_None) {
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
			if (node.bLinked && Corona.Link.Gradient.Saturation.Mode > CLGM_None) {
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
	frame.Canvas.DrawColor = c;
	frame.Canvas.bNoSmooth = !Corona.Texture.bSmooth;
	setRenderFrameNearestZ(frame, node.Distance);
	drawSprite(frame, Corona.Texture.Value, point, scale, true, true, Corona.Texture.Mode);
	
	//lensflares
	if (Lensflare.Kind > LK_None) {
		lCorona.Color = color;
		lCorona.Opacity = opacity;
		lCorona.Distance = node.Distance;
		lCorona.Point = point;
		lCorona.Scale = scale;
		drawLensflares(lCorona, frame);
	}
}

final simulated function drawLensflares(NodeLensflareCorona corona, RenderFrame frame)
{
	//local
	local byte i;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local float degree, opacity, alpha, fscale, f;
	local color colorMin, colorMax, c;
	local vector vector, pointVector;
	local NodeLensflareEntry entry;
	
	//check
	if (Lensflare.Kind == LK_None) {
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
		
		//check
		if (
			entry.Glow <= 0.0 || entry.Texture.Value == none || degree < entry.Degree.Min || 
			degree > entry.Degree.Max
		) {
			continue;
		}
		
		//opacity
		opacity = corona.Opacity * entry.Glow;
		if (degree < entry.Degree.FadeMin && entry.Degree.FadeMin > entry.Degree.Min) {
			opacity *= (degree - entry.Degree.Min) / (entry.Degree.FadeMin - entry.Degree.Min);
		} else if (degree > entry.Degree.FadeMax && entry.Degree.FadeMax < entry.Degree.Max) {
			opacity *= 1.0 - (degree - entry.Degree.FadeMax) / (entry.Degree.Max - entry.Degree.FadeMax);
		}
		
		//opacity (check)
		if (opacity <= 0.0) {
			continue;
		}
		
		//alpha
		alpha = (degree - entry.Degree.Min) / (entry.Degree.Max - entry.Degree.Min);
		
		//scale
		fscale = smerp(alpha, entry.Size.Min, entry.Size.Max);
		scale.U = fscale * corona.Scale.U * smerp(alpha, entry.Scale.Min.U, entry.Scale.Max.U);
		scale.V = fscale * corona.Scale.V * smerp(alpha, entry.Scale.Min.V, entry.Scale.Max.V);
		
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
		c.R = byte(smerp(alpha, colorMin.R, colorMax.R) * opacity);
		c.G = byte(smerp(alpha, colorMin.G, colorMax.G) * opacity);
		c.B = byte(smerp(alpha, colorMin.B, colorMax.B) * opacity);
		
		//color (check)
		if (c.R == 0 && c.G == 0 && c.B == 0) {
			continue;
		}
		
		//point
		pointVector = vector * entry.Position;
		point.X = corona.Point.X + pointVector.X;
		point.Y = corona.Point.Y + pointVector.Y;
		
		//draw
		frame.Canvas.DrawColor = c;
		frame.Canvas.bNoSmooth = !entry.Texture.bSmooth;
		drawSprite(frame, entry.Texture.Value, point, scale, true, true, entry.Texture.Mode);
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
	
	//editables (controller - lensflare)
	//Lensflare=(Custom[0]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	//Lensflare=(Custom[1]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	//Lensflare=(Custom[2]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	//Lensflare=(Custom[3]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	//Lensflare=(Custom[4]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	//Lensflare=(Custom[5]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	//Lensflare=(Custom[6]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	//Lensflare=(Custom[7]=(Glow=1.0,Size=(Min=1.0,Max=1.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0))))
	
	//privates (lensflare preset - sun)
	LensflarePresetSunEntries(0)=(Glow=0.5,Position=0.0)
	LensflarePresetSunEntries(0)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare5Q'))
	LensflarePresetSunEntries(0)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=128)))
	LensflarePresetSunEntries(0)=(Size=(Min=3.0,Max=8.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(0)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=0.75,Max=1.0))
	
	LensflarePresetSunEntries(1)=(Glow=0.2,Position=0.2)
	LensflarePresetSunEntries(1)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare8Q'))
	LensflarePresetSunEntries(1)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSunEntries(1)=(Size=(Min=0.25,Max=2.0),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(1)=(Degree=(Min=0.0,FadeMin=0.1,FadeMax=0.7,Max=1.0))
	
	LensflarePresetSunEntries(2)=(Glow=0.05,Position=1.0)
	LensflarePresetSunEntries(2)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare0Q'))
	LensflarePresetSunEntries(2)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=64)))
	LensflarePresetSunEntries(2)=(Size=(Min=0.0,Max=0.075),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(2)=(Degree=(Min=0.0,FadeMin=0.35,FadeMax=0.8,Max=0.9))
	
	LensflarePresetSunEntries(3)=(Glow=0.07,Position=0.35)
	LensflarePresetSunEntries(3)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare2Q'))
	LensflarePresetSunEntries(3)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=64,G=255,B=255)))
	LensflarePresetSunEntries(3)=(Size=(Min=0.0,Max=0.3),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(3)=(Degree=(Min=0.05,FadeMin=0.35,FadeMax=0.7,Max=0.95))
	
	LensflarePresetSunEntries(4)=(Glow=0.09,Position=0.65)
	LensflarePresetSunEntries(4)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare1Q'))
	LensflarePresetSunEntries(4)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=64,G=255,B=64)))
	LensflarePresetSunEntries(4)=(Size=(Min=0.0,Max=0.05),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(4)=(Degree=(Min=0.1,FadeMin=0.6,FadeMax=0.8,Max=0.95))
	
	LensflarePresetSunEntries(5)=(Glow=0.08,Position=0.75)
	LensflarePresetSunEntries(5)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare0Q'))
	LensflarePresetSunEntries(5)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=64),Max=(R=255,G=128,B=255)))
	LensflarePresetSunEntries(5)=(Size=(Min=0.0,Max=0.135),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(5)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.85,Max=0.95))
	
	LensflarePresetSunEntries(6)=(Glow=0.075,Position=-0.35)
	LensflarePresetSunEntries(6)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare2Q'))
	LensflarePresetSunEntries(6)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=64,G=128,B=255)))
	LensflarePresetSunEntries(6)=(Size=(Min=0.0,Max=0.25),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(6)=(Degree=(Min=0.0,FadeMin=0.1,FadeMax=0.5,Max=0.95))
	
	LensflarePresetSunEntries(7)=(Glow=0.04,Position=0.45)
	LensflarePresetSunEntries(7)=(Texture=(Mode=RTM_MirrorQ,Value=Texture'Lensflare0Q'))
	LensflarePresetSunEntries(7)=(Color=(Mode=LCM_Multiply,Min=(R=128,G=255,B=255),Max=(R=64,G=255,B=255)))
	LensflarePresetSunEntries(7)=(Size=(Min=0.0,Max=0.15),Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSunEntries(7)=(Degree=(Min=0.1,FadeMin=0.2,FadeMax=0.9,Max=1.0))
}
