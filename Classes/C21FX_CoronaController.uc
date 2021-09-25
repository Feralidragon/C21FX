
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures - coronas)
#exec TEXTURE IMPORT NAME=Corona FILE=Textures/Coronas/Corona.bmp GROUP=Coronas MIPS=OFF LODSET=0

//Import directives (textures - lensflares SD)
#exec TEXTURE IMPORT NAME=Lensflare0 FILE=Textures/Lensflares/SD/Lensflare0.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare1 FILE=Textures/Lensflares/SD/Lensflare1.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare2 FILE=Textures/Lensflares/SD/Lensflare2.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare3 FILE=Textures/Lensflares/SD/Lensflare3.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=LensflareQ3 FILE=Textures/Lensflares/SD/LensflareQ3.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare4 FILE=Textures/Lensflares/SD/Lensflare4.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare5 FILE=Textures/Lensflares/SD/Lensflare5.bmp GROUP=Lensflares MIPS=OFF LODSET=0

//Import directives (textures - lensflares HD)
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare3 FILE=Textures/Lensflares/HD/Lensflare3.png GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE MERGECOMPRESSED NAME=LensflareQ3 FILE=Textures/Lensflares/HD/LensflareQ3.png GROUP=Lensflares MIPS=OFF LODSET=0


//Constants
const CORONA_VISIBILITY_FADE_TIME = 0.1;
const CORONA_SCALE_FIXED = 0.125;
const LENSFLARE_ENTRIES_COUNT = 8;
const LENSFLARE_PRESETS_COUNT = 4;


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
	LK_Preset1,
	LK_Preset2,
	LK_Preset3,
	LK_Preset4,
	LK_Custom
};

enum ELensflareColorMode
{
	LCM_Auto,
	LCM_Value,
	LCM_Add,
	LCM_Subtract,
	LCM_Intersect,
	LCM_Merge,
	LCM_Exclude
};


//Structures
struct NodeCoronaTexture
{
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

struct NodeLensflarePreset
{
	var NodeLensflareEntry Entries[LENSFLARE_ENTRIES_COUNT];
};


//Editable properties (controller)
var(Controller) NodeCorona Corona;
var(Controller) NodeLensflare Lensflare;


//Private properties
var private NodeLensflarePreset LensflarePresets[LENSFLARE_PRESETS_COUNT];
var private NodeLensflareEntry LensflareEntries[LENSFLARE_ENTRIES_COUNT];


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
			if (Lensflare.Kind == LK_Custom) {
				LensflareEntries[i] = Lensflare.Custom[i];
			} else {
				LensflareEntries[i] = LensflarePresets[Lensflare.Kind - 1].Entries[i];
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
	local RenderPoint2D point, lPoint;
	local RenderScale2D scale, lScale;
	local ERenderPoint2DVisibility pointVisibility;
	local ECoronaScaleMode scaleMode;
	local ECoronaColorMode colorMode;
	local float fscale, opacity, gSize, lDegree, lOpacity, lAlpha;
	local byte saturation, i;
	local color c, color, lColorMin, lColorMax;
	local vector lVector, lVectorPoint;
	local NodeLensflareEntry lEntry;
	
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
	setRenderFrameNearestZ(frame, node.Distance);
	drawSprite(frame, Corona.Texture.Value, point, scale, true, true, Corona.Texture.Mode);
	
	//lensflares
	if (Lensflare.Kind > LK_None) {
		//vector
		lVector.X = lerp(0.5, frame.Canvas.OrgX, frame.Canvas.ClipX) - point.X;
		lVector.Y = lerp(0.5, frame.Canvas.OrgY, frame.Canvas.ClipY) - point.Y;
		lVector *= 2.0;
		
		//degree
		lDegree = fmax(
			abs(lVector.X / (frame.Canvas.ClipX - frame.Canvas.OrgX)),
			abs(lVector.Y / (frame.Canvas.ClipY - frame.Canvas.OrgY))
		);
		
		//entries
		for (i = 0; i < LENSFLARE_ENTRIES_COUNT; i++) {
			//entry
			lEntry = LensflareEntries[i];
			
			//check
			if (
				lEntry.Glow <= 0.0 || lEntry.Texture.Value == none || lDegree < lEntry.Degree.Min || 
				lDegree > lEntry.Degree.Max
			) {
				continue;
			}
			
			//opacity
			lOpacity = opacity * lEntry.Glow;
			if (lDegree < lEntry.Degree.FadeMin && lEntry.Degree.FadeMin > lEntry.Degree.Min) {
				lOpacity *= (lDegree - lEntry.Degree.Min) / (lEntry.Degree.FadeMin - lEntry.Degree.Min);
			} else if (lDegree > lEntry.Degree.FadeMax && lEntry.Degree.FadeMax < lEntry.Degree.Max) {
				lOpacity *= 1.0 - (lDegree - lEntry.Degree.FadeMax) / (lEntry.Degree.Max - lEntry.Degree.FadeMax);
			}
			
			//opacity (check)
			if (lOpacity <= 0.0) {
				continue;
			}
			
			//alpha
			lAlpha = (lDegree - lEntry.Degree.Min) / (lEntry.Degree.Max - lEntry.Degree.Min);
			
			//scale
			fscale = lerp(lAlpha, lEntry.Size.Min, lEntry.Size.Max);
			lScale.U = fscale * scale.U * lerp(lAlpha, lEntry.Scale.Min.U, lEntry.Scale.Max.U);
			lScale.V = fscale * scale.U * lerp(lAlpha, lEntry.Scale.Min.V, lEntry.Scale.Max.V);
			
			//scale (check)
			if (lScale.U <= 0.0 || lScale.V <= 0.0) {
				continue;
			}
			
			//color mode
			if (lEntry.Color.Mode == LCM_Auto) {
				
				//TODO
				
			}
			
			//color
			switch (lEntry.Color.Mode) {
				case LCM_Value:
					lColorMin = lEntry.Color.Min;
					lColorMax = lEntry.Color.Max;
					break;
				case LCM_Add:
					lColorMin.R = byte(min(int(color.R) + int(lEntry.Color.Min.R), 255));
					lColorMin.G = byte(min(int(color.G) + int(lEntry.Color.Min.G), 255));
					lColorMin.B = byte(min(int(color.B) + int(lEntry.Color.Min.B), 255));
					lColorMax.R = byte(min(int(color.R) + int(lEntry.Color.Max.R), 255));
					lColorMax.G = byte(min(int(color.G) + int(lEntry.Color.Max.G), 255));
					lColorMax.B = byte(min(int(color.B) + int(lEntry.Color.Max.B), 255));
					break;
				case LCM_Subtract:
					lColorMin.R = byte(max(int(color.R) - int(lEntry.Color.Min.R), 0));
					lColorMin.G = byte(max(int(color.G) - int(lEntry.Color.Min.G), 0));
					lColorMin.B = byte(max(int(color.B) - int(lEntry.Color.Min.B), 0));
					lColorMax.R = byte(max(int(color.R) - int(lEntry.Color.Max.R), 0));
					lColorMax.G = byte(max(int(color.G) - int(lEntry.Color.Max.G), 0));
					lColorMax.B = byte(max(int(color.B) - int(lEntry.Color.Max.B), 0));
					break;
				case LCM_Intersect:
					lColorMin.R = byte(int(color.R) & int(lEntry.Color.Min.R));
					lColorMin.G = byte(int(color.G) & int(lEntry.Color.Min.G));
					lColorMin.B = byte(int(color.B) & int(lEntry.Color.Min.B));
					lColorMax.R = byte(int(color.R) & int(lEntry.Color.Max.R));
					lColorMax.G = byte(int(color.G) & int(lEntry.Color.Max.G));
					lColorMax.B = byte(int(color.B) & int(lEntry.Color.Max.B));
					break;
				case LCM_Merge:
					lColorMin.R = byte(int(color.R) | int(lEntry.Color.Min.R));
					lColorMin.G = byte(int(color.G) | int(lEntry.Color.Min.G));
					lColorMin.B = byte(int(color.B) | int(lEntry.Color.Min.B));
					lColorMax.R = byte(int(color.R) | int(lEntry.Color.Max.R));
					lColorMax.G = byte(int(color.G) | int(lEntry.Color.Max.G));
					lColorMax.B = byte(int(color.B) | int(lEntry.Color.Max.B));
					break;
				case LCM_Exclude:
					lColorMin.R = byte(int(color.R) ^ int(lEntry.Color.Min.R));
					lColorMin.G = byte(int(color.G) ^ int(lEntry.Color.Min.G));
					lColorMin.B = byte(int(color.B) ^ int(lEntry.Color.Min.B));
					lColorMax.R = byte(int(color.R) ^ int(lEntry.Color.Max.R));
					lColorMax.G = byte(int(color.G) ^ int(lEntry.Color.Max.G));
					lColorMax.B = byte(int(color.B) ^ int(lEntry.Color.Max.B));
					break;
			}
			c.R = byte(lerp(lAlpha, lColorMin.R, lColorMax.R) * lOpacity);
			c.G = byte(lerp(lAlpha, lColorMin.G, lColorMax.G) * lOpacity);
			c.B = byte(lerp(lAlpha, lColorMin.B, lColorMax.B) * lOpacity);
			
			//color (check)
			if (c.R == 0 && c.G == 0 && c.B == 0) {
				return;
			}
			
			//point
			lVectorPoint = lVector * lEntry.Position;
			lPoint.X = point.X + lVectorPoint.X;
			lPoint.Y = point.Y + lVectorPoint.Y;
			
			//draw
			frame.Canvas.DrawColor = c;
			drawSprite(frame, lEntry.Texture.Value, lPoint, lScale, true, true, lEntry.Texture.Mode);
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



defaultproperties
{
	//editables (controller)
	Corona=(Texture=(Value=Texture'Corona'),Size=1.0,Glow=1.0)
	Corona=(Scale=(Value=(U=1.0,V=1.0)))
	Corona=(Color=(Value=(R=255,G=255,B=255)))
	Corona=(Link=(Density=1.0,Alignment=CLA_Center))
	Corona=(Link=(Gradient=(Size=(Value1=1.0,Value2=1.0))))
	Corona=(Link=(Gradient=(Glow=(Value1=1.0,Value2=1.0))))
	Corona=(Link=(Gradient=(Scale=(Value1=(U=1.0,V=1.0),Value2=(U=1.0,V=1.0)))))
	Corona=(Link=(Gradient=(Color=(Value1=(R=255,G=255,B=255),Value2=(R=255,G=255,B=255)))))
}
