
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures)
#exec TEXTURE IMPORT NAME=DefaultCorona FILE=Textures/Coronas/DefaultCorona.bmp GROUP=Coronas MIPS=OFF LODSET=0


//Constants
const CORONA_VISIBILITY_FADE_TIME = 0.1;
const CORONA_FIXED_SCALE = 0.125;


//Enumerations
enum ECoronaColorMode
{
	CCM_Auto,
	CCM_Value,
	CCM_Light,
	CCM_LightHS,
	CCM_LightHue
};

enum ECoronaScaleType
{
	CST_Fixed,
	CST_Perspective
};


//Structures
struct NodeCoronaScale
{
	var() ECoronaScaleType Type;
	var() RenderScale2D Value;
};

struct NodeCoronaColor
{
	var() ECoronaColorMode Mode;
	var() color Value;
};

struct NodeCorona
{
	var() Texture Texture;
	var() float Size;
	var() float Glow;
	var() NodeCoronaScale Scale;
	var() NodeCoronaColor Color;
	var() byte Saturation;
};


//Editable properties (controller)
var(Controller) NodeCorona Corona;


replication
{
	reliable if (Role == ROLE_Authority)
		Corona;
}


//Implemented events
event initialize()
{
	Corona.Size = fmax(Corona.Size, 0.0);
	Corona.Glow = fclamp(Corona.Glow, 0.0, 1.0);
}


//Implemented simulated events
simulated event C21FX_Node createNode(Actor actor)
{
	return new class'C21FX_CoronaNode';
}

simulated event initializeNodesRender(RenderFrame frame)
{
	frame.Canvas.Style = ERenderStyle.STY_Translucent;
}

simulated event renderNode(C21FX_Node node, RenderFrame frame)
{
	renderCoronaNode(C21FX_CoronaNode(node), frame);
}


//Final simulated functions
final simulated function renderCoronaNode(C21FX_CoronaNode node, RenderFrame frame)
{
	//local
	local bool visible;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local ERenderPoint2DVisibility pointVisibility;
	local ECoronaColorMode colorMode;
	local float fscale, opacity;
	local color color;
	
	//check
	if (
		Corona.Texture == none || Corona.Size == 0.0 || Corona.Scale.Value.U == 0.0 || Corona.Scale.Value.V == 0.0 || 
		Corona.Glow == 0.0
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
	
	//scale
	if (Corona.Scale.Type == CST_Fixed) {
		fscale = fmin(frame.Canvas.ClipX - frame.Canvas.OrgX, frame.Canvas.ClipY - frame.Canvas.OrgY) * 
			CORONA_FIXED_SCALE / float(max(Corona.Texture.USize, Corona.Texture.VSize));
		scale.U = fscale;
		scale.V = fscale;
	} else if (Corona.Scale.Type == CST_Perspective) {
		scale = locationToRenderScale2D(node.Location, frame);
	}
	scale.U *= Corona.Scale.Value.U * Corona.Size;
	scale.V *= Corona.Scale.Value.V * Corona.Size;
	
	//opacity
	opacity = frame.Opacity * node.Opacity * Corona.Glow;
	
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
		color = Corona.Color.Value;
	} else if (node.Actor != none) {
		if (colorMode == CCM_Light) {
			color = hsbToColor(node.Actor.LightHue, node.Actor.LightSaturation, node.Actor.LightBrightness);
		} else if (colorMode == CCM_LightHS) {
			color = hsbToColor(node.Actor.LightHue, node.Actor.LightSaturation, 255);
		} else if (colorMode == CCM_LightHue) {
			color = hsbToColor(node.Actor.LightHue, Corona.Saturation, 255);
		}
	}
	color.R = byte(float(color.R) * opacity);
	color.G = byte(float(color.G) * opacity);
	color.B = byte(float(color.B) * opacity);
	
	//draw
	frame.Canvas.DrawColor = color;
	setRenderFrameNearestZ(frame, node.Distance);
	drawSprite(frame, Corona.Texture, point, scale, true, true);
}



defaultproperties
{
	//editables (controller)
	Corona=(Texture=Texture'DefaultCorona',Glow=1.0,Size=1.0,Scale=(Value=(U=1.0,V=1.0)),Color=(Value=(R=255,G=255,B=255)))
}
