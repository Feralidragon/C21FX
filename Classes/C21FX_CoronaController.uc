
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_CoronaController extends C21FX_ViewController;

//Import directives (textures)
#exec TEXTURE IMPORT NAME=DefaultCorona FILE=Textures/Coronas/DefaultCorona.bmp GROUP=Coronas MIPS=OFF LODSET=0


//Constants
const CORONA_VISIBILITY_FADE_TIME = 0.1;
const CORONA_FIXED_SCALE = 0.125;


//Enumerations
enum ECoronaColorMode
{
	CCM_Auto,
	CCM_Color,
	CCM_Light,
	CCM_LightHS,
	CCM_LightHue
};

enum ECoronaScaleType
{
	CST_Fixed,
	CST_Perspective
};


//Editable properties (corona)
var(Corona) ECoronaColorMode CoronaColorMode;
var(Corona) color CoronaColor;
var(Corona) Texture CoronaTexture;
var(Corona) float CoronaSize;
var(Corona) RenderScale2D CoronaScale;
var(Corona) ECoronaScaleType CoronaScaleType;
var(Corona) float CoronaGlow;
var(Corona) byte CoronaSaturation;


replication
{
	reliable if (Role == ROLE_Authority)
		CoronaColorMode, CoronaColor, CoronaTexture, CoronaSize, CoronaScale, CoronaScaleType, CoronaGlow,
		CoronaSaturation;
}


//Implemented events
event initializeView()
{
	CoronaSize = fmax(CoronaSize, 0.0);
	CoronaGlow = fclamp(CoronaGlow, 0.0, 1.0);
}


//Implemented simulated events
simulated event C21FX_ViewNode createNode(Actor actor)
{
	return new class'C21FX_Corona';
}

simulated event initializeViewRender(RenderFrame frame)
{
	frame.Canvas.Style = ERenderStyle.STY_Translucent;
}

simulated event renderNode(C21FX_ViewNode node, RenderFrame frame)
{
	renderCorona(C21FX_Corona(node), frame);
}


//Final simulated functions
final simulated function renderCorona(C21FX_Corona corona, RenderFrame frame)
{
	//local
	local bool visible;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local ERenderPoint2DVisibility pointVisibility;
	local ECoronaColorMode colorMode;
	local float fscale, opacity;
	local Color color;
	
	//check
	if (
		CoronaTexture == none || CoronaSize == 0.0 || CoronaScale.U == 0.0 || CoronaScale.V == 0.0 || 
		CoronaGlow == 0.0
	) {
		return;
	}
	
	//visibility
	visible = isNodeVisible(corona, frame, point);
	if (!visible) {
		point = locationToRenderPoint2D(corona.Location, frame, pointVisibility);
		if (pointVisibility != RP2DV_Visible) {
			return;
		}
	}
	
	//opacity
	if (visible && corona.Opacity < 1.0) {
		corona.Opacity = fmin(corona.Opacity + frame.Delta / CORONA_VISIBILITY_FADE_TIME, 1.0);
	} else if (!visible) {
		//reduce
		if (corona.Opacity > 0.0) {
			corona.Opacity = fmax(corona.Opacity - frame.Delta / CORONA_VISIBILITY_FADE_TIME, 0.0);
		}
		
		//check
		if (corona.Opacity == 0.0) {
			return;
		}
	}
	
	//scale
	if (CoronaScaleType == CST_Fixed) {
		fscale = fmin(frame.Canvas.ClipX - frame.Canvas.OrgX, frame.Canvas.ClipY - frame.Canvas.OrgY) * 
			CORONA_FIXED_SCALE / float(max(CoronaTexture.USize, CoronaTexture.VSize));
		scale.U = fscale;
		scale.V = fscale;
	} else if (CoronaScaleType == CST_Perspective) {
		scale = locationToRenderScale2D(corona.Location, frame);
	}
	scale.U *= CoronaScale.U * CoronaSize;
	scale.V *= CoronaScale.V * CoronaSize;
	
	//opacity
	opacity = frame.Opacity * corona.Opacity * CoronaGlow;
	
	//color mode
	colorMode = CoronaColorMode;
	if (colorMode == CCM_Auto) {
		if (Light(corona.Actor) != none) {
			colorMode = CCM_Light;
		} else {
			colorMode = CCM_Color;
		}
	}
	
	//color
	if (colorMode == CCM_Color) {
		color = CoronaColor;
	} else if (corona.Actor != none) {
		if (colorMode == CCM_Light) {
			color = hsbToColor(corona.Actor.LightHue, corona.Actor.LightSaturation, corona.Actor.LightBrightness);
		} else if (colorMode == CCM_LightHS) {
			color = hsbToColor(corona.Actor.LightHue, corona.Actor.LightSaturation, byte(CoronaGlow * 255.0));
		} else if (colorMode == CCM_LightHue) {
			color = hsbToColor(corona.Actor.LightHue, CoronaSaturation, byte(CoronaGlow * 255.0));
		}
	}
	color.R = byte(float(color.R) * opacity);
	color.G = byte(float(color.G) * opacity);
	color.B = byte(float(color.B) * opacity);
	
	//draw
	frame.Canvas.DrawColor = color;
	setRenderFrameZ(frame, vsize(corona.Location - frame.View.Location));
	drawSprite(frame, CoronaTexture, point, scale, true, true);
}



defaultproperties
{
	//editables (corona)
	CoronaColorMode=CCM_Auto
	CoronaColor=(R=255,G=255,B=255)
	CoronaTexture=Texture'DefaultCorona'
	CoronaSize=1.0
	CoronaScale=(U=1.0,V=1.0)
	CoronaScaleType=CST_Fixed
	CoronaGlow=1.0
	CoronaSaturation=0
}
