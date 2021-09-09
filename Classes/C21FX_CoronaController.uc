
class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures)
#exec TEXTURE IMPORT NAME=DefaultCorona FILE=Textures/Coronas/DefaultCorona.bmp GROUP=Coronas MIPS=OFF LODSET=0


//Enums
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
		CoronaTag, CoronaColorMode, CoronaColor, CoronaTexture, CoronaSize, CoronaGlow, CoronaOcclusionType,
		CoronaVisibilityActorSync, bZoneExclusive, ignoreMovers;
	}
}


//Implemented events
event initialize()
{
	//local
	local Actor actor;
	
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
			corona.NextCorona = firstCorona;
			firstCorona = corona;
		}
	}
	
	//finalize
	initializedCoronas = true;
}

final simulated function renderCorona(C21FX_Corona corona, RenderFrame frame)
{
	
	//TODO
	
}

final simulated function bool isCoronaVisible(C21FX_Corona corona, Canvas canvas, out RenderPoint2D point)
{
	//local
	local Actor coronaActor, canvasActor;
	local ERenderPoint2DVisibility pointVisibility;
	
	//actors
	coronaActor = corona.Actor;
	canvasActor = canvas.ViewPort.Actor;
	if (coronaActor == none || canvasActor == none) {
		return false;
	}
	
	//visibility actor sync
	if (
		(CoronaVisibilityActorSync == CVAS_Auto && coronaActor.bHidden && Keypoint(coronaActor) == none && 
		Light(coronaActor) == none && NavigationPoint(coronaActor) == none && Triggers(coronaActor) == none) || 
		(CoronaVisibilityActorSync == CVAS_Same && coronaActor.bHidden) || 
		(CoronaVisibilityActorSync == CVAS_Invert && !coronaActor.bHidden)
	) {
		return false;
	}
	
	//zone
	if (bZoneExclusive && coronaActor.Region.ZoneNumber != canvasActor.Region.ZoneNumber) {
		return false;
	}
	
	//point
	point = vectorToRenderPoint2D(coronaActor.Location, canvas, pointVisibility);
	if (pointVisibility == RP2DV_Hidden) {
		return false;
	}
	
	
	
	//TODO: fast trace
	//TODO: slow trace
	//TODO: movers
	
	
	
	//return
	return true;
}



defaultproperties
{
	//editables (corona)
	CoronaTag=""
	CoronaColorMode=CCM_Auto
	CoronaColor=(R=255,G=255,B=255,A=255)
	CoronaTexture=texture'DefaultCorona'
	CoronaSize=1.0
	CoronaGlow=1.0
	
	//editables (visibility)
	CoronaOcclusionType=COT_All
	CoronaVisibilityActorSync=CVAS_Auto
	bZoneExclusive=false
	ignoreMovers=false
}
