
class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures)
#exec TEXTURE IMPORT NAME=DefaultCorona FILE=Textures/Coronas/DefaultCorona.bmp GROUP=Coronas MIPS=OFF LODSET=0


//Constants
const CORONA_VISIBILITY_FADE_TIME = 0.05;


//Enumerations
enum ECoronaColorMode
{
	CCM_Auto,
	CCM_Color,
	CCM_Light
};

enum ECoronaOcclusionType
{
	COT_All,
	COT_Level,
	COT_None
};

enum ECoronaVisibilityActorSync
{
	CVAS_Auto,
	CVAS_Same,
	CVAS_Invert,
	CVAS_Ignore
};


//Editable properties (corona)
var(Corona) name CoronaTag;
var(Corona) ECoronaColorMode CoronaColorMode;
var(Corona) color CoronaColor;
var(Corona) texture CoronaTexture;
var(Corona) float CoronaSize;
var(Corona) RenderScale2D CoronaScale;
var(Corona) float CoronaGlow;


//Editable properties (visibility)
var(Visibility) ECoronaOcclusionType CoronaOcclusionType;
var(Visibility) ECoronaVisibilityActorSync CoronaVisibilityActorSync;
var(Visibility) bool bZoneExclusive;
var(Visibility) bool ignoreMovers;


//Private properties
var private bool initializedCoronas;
var private C21FX_Corona firstCorona;


replication
{
	reliable if (Role == ROLE_Authority && bNetInitial) {
		CoronaTag, CoronaColorMode, CoronaColor, CoronaTexture, CoronaSize, CoronaScale, CoronaGlow,
		CoronaOcclusionType, CoronaVisibilityActorSync, bZoneExclusive, ignoreMovers;
	}
}


//Implemented events
event initialize()
{
	//local
	local Actor actor;
	
	//initialize
	CoronaSize = fmax(CoronaSize, 0.0);
	CoronaGlow = fclamp(CoronaGlow, 0.0, 1.0);
	
	//actors
	if (CoronaTag != '') {
		foreach AllActors(class'Actor', actor, CoronaTag) {
			actor.bAlwaysRelevant = true;
		}
	}
}


//Implemented simulated events
simulated event render(RenderFrame frame)
{
	//local
	local C21FX_Corona corona;
	
	//initialize
	initializeCoronas();
	frame.Canvas.Style = ERenderStyle.STY_Translucent;
	
	//render
	for (corona = firstCorona; corona != none; corona = corona.NextCorona) {
		renderCorona(corona, frame);
	}
}


//Final simulated functions
final simulated function initializeCoronas()
{
	//local
	local Actor actor;
	local C21FX_Corona corona;
	
	//check
	if (initializedCoronas) {
		return;
	}
	
	//initialize
	if (CoronaTag != '') {
		foreach AllActors(class'Actor', actor, CoronaTag) {
			corona = new class'C21FX_Corona';
			corona.Actor = actor;
			corona.Location = actor.Location;
			corona.NextCorona = firstCorona;
			firstCorona = corona;
		}
		initializedCoronas = true;
	}
}

final simulated function renderCorona(C21FX_Corona corona, RenderFrame frame)
{
	//local
	local bool visible;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local ERenderPoint2DVisibility pointVisibility;
	local ECoronaColorMode colorMode;
	local Color color;
	
	//check
	if (
		CoronaTexture == none || CoronaSize == 0.0 || CoronaScale.X == 0.0 || CoronaScale.Y == 0.0 || 
		CoronaGlow == 0.0
	) {
		return;
	}
	
	//visibility
	visible = isCoronaVisible(corona, frame, point);
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
	scale = locationToRenderScale2D(corona.Location, frame);
	scale.U *= CoronaScale.U * CoronaSize;
	scale.V *= CoronaScale.V * CoronaSize;
	
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
	} else if (colorMode == CCM_Light) {
		color = hsbToColor(corona.Actor.LightHue, corona.Actor.LightSaturation, corona.Actor.LightBrightness);
	}
	color.R = byte(float(color.R) * CoronaGlow);
	color.G = byte(float(color.G) * CoronaGlow);
	color.B = byte(float(color.B) * CoronaGlow);
	
	//draw
	drawTexture(frame, CoronaTexture, point, scale, true);
}

final simulated function bool isCoronaVisible(C21FX_Corona corona, RenderFrame frame, out RenderPoint2D point)
{
	//local
	local ERenderPoint2DVisibility pointVisibility;
	local bool visible;
	
	//check
	if (corona.Actor == none) {
		return false;
	}
	
	//visibility actor sync
	if (
		(CoronaVisibilityActorSync == CVAS_Auto && corona.Actor.bHidden && Keypoint(corona.Actor) == none && 
		Light(corona.Actor) == none && NavigationPoint(corona.Actor) == none && Triggers(corona.Actor) == none) || 
		(CoronaVisibilityActorSync == CVAS_Same && corona.Actor.bHidden) || 
		(CoronaVisibilityActorSync == CVAS_Invert && !corona.Actor.bHidden)
	) {
		return false;
	}
	
	//zone
	if (bZoneExclusive && corona.Actor.Region.ZoneNumber != frame.View.Actor.Region.ZoneNumber) {
		return false;
	}
	
	//point
	point = locationToRenderPoint2D(corona.Location, frame, pointVisibility);
	if (pointVisibility != RP2DV_Visible) {
		return false;
	}
	
	//trace
	if (CoronaOcclusionType != COT_None) {
		visible = frame.View.Actor.fastTrace(corona.Location, frame.View.Location);
		if (
			(visible && CoronaOcclusionType == COT_All && isCoronaOccluded(corona, frame)) || 
			(!visible && (!ignoreMovers || isCoronaOccluded(corona, frame)))
		) {
			return false;
		}
	}
	
	//return
	return true;
}

final simulated function bool isCoronaOccluded(C21FX_Corona corona, RenderFrame frame)
{
	//local
	local Actor traceActor;
	local vector hitLocation, hitNormal, traceStart;
	local bool bTraceActors;
	
	//check
	if (CoronaOcclusionType == COT_None) {
		return false;
	}
	
	//trace
	traceActor = frame.View.Actor;
	traceStart = frame.View.Location;
	bTraceActors = CoronaOcclusionType == COT_All;
	while (traceActor != none) {
		traceActor = traceActor.trace(hitLocation, hitNormal, corona.Location, traceStart, bTraceActors);
		if (traceActor != none) {
			if (
				traceActor == Level || (Mover(traceActor) != none && !ignoreMovers) || 
				(bTraceActors && !traceActor.bHidden && traceActor.DrawType == DT_Mesh)
			) {
				return true;
			} else {
				traceStart = hitLocation;
			}
		}
	}
	
	//return
	return false;
}



defaultproperties
{
	//editables (corona)
	CoronaTag=""
	CoronaColorMode=CCM_Auto
	CoronaColor=(R=255,G=255,B=255)
	CoronaTexture=texture'DefaultCorona'
	CoronaSize=1.0
	CoronaScale=(U=1.0,V=1.0)
	CoronaGlow=1.0
	
	//editables (visibility)
	CoronaOcclusionType=COT_All
	CoronaVisibilityActorSync=CVAS_Auto
	bZoneExclusive=false
	ignoreMovers=false
}
