
class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures)
#exec TEXTURE IMPORT NAME=DefaultCorona FILE=Textures/Coronas/DefaultCorona.bmp GROUP=Coronas MIPS=OFF LODSET=0


//Enumerations
enum ECoronaColorMode
{
	CCM_Auto,
	CCM_Color,
	CCM_Light
};

enum EOcclusionType
{
	OT_All,
	OT_Level,
	OT_None
};

enum EActorOcclusionType
{
	AOT_Auto,
	AOT_Same,
	AOT_Invert,
	AOT_Ignore
};

enum ECoronaVisibilityStatus
{
	CVS_Hidden,
	CVS_HidingFast,
	CVS_HidingSlow,
	CVS_Visible
};


//Editable properties (corona)
var(Corona) name CoronaTag;
var(Corona) ECoronaColorMode CoronaColorMode;
var(Corona) color CoronaColor;
var(Corona) texture CoronaTexture;
var(Corona) float CoronaSize;
var(Corona) float CoronaGlow;


//Editable properties (occlusion)
var(Occlusion) EOcclusionType OcclusionType;
var(Occlusion) EActorOcclusionType ActorOcclusionType;
var(Occlusion) bool bZoneExclusive;
var(Occlusion) bool ignoreMovers;


//Private properties
var private bool initializedCoronas;
var private C21FX_Corona firstCorona;


replication
{
	reliable if (Role == ROLE_Authority) {
		CoronaTag, CoronaColorMode, CoronaColor, CoronaTexture, CoronaSize, CoronaGlow, OcclusionType,
		ActorOcclusionType, bZoneExclusive, ignoreMovers;
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
simulated event render(Canvas canvas, float delta, float opacity)
{
	//local
	local C21FX_Corona corona;
	
	//initialize
	initializeCoronas();
	canvas.Style = ERenderStyle.STY_Translucent;
	
	//render
	for (corona = firstCorona; corona != none; corona = corona.NextCorona) {
		renderCorona(corona, canvas, delta, opacity);
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

final simulated function renderCorona(C21FX_Corona corona, Canvas canvas, float delta, float opacity)
{
	
	//TODO
	
}

final simulated function ECoronaVisibilityStatus getCoronaVisibilityStatus(C21FX_Corona corona, Canvas canvas)
{
	//local
	local Actor actor, coronaActor;
	
	//actor
	actor = canvas.ViewPort.Actor;
	if (actor == none) {
		return CVS_Hidden;
	}
	
	//corona actor
	coronaActor = corona.Actor;
	if (coronaActor == none) {
		return CVS_Hidden;
	} else if (
		(ActorOcclusionType == AOT_Auto && coronaActor.bHidden && Keypoint(coronaActor) == none && 
		Light(coronaActor) == none && NavigationPoint(coronaActor) == none && Triggers(coronaActor) == none) || 
		(ActorOcclusionType == AOT_Same && coronaActor.bHidden) || 
		(ActorOcclusionType == AOT_Invert && !coronaActor.bHidden)
	) {
		return CVS_HidingSlow;
	}
	
	//zone
	if (bZoneExclusive && actor.Region.ZoneNumber != coronaActor.Region.ZoneNumber) {
		return CVS_HidingSlow;
	}
	
	
	
	//TODO
	
	
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
	
	//editables (occlusion)
	OcclusionType=OT_All
	ActorOcclusionType=AOT_Auto
	bZoneExclusive=false
	ignoreMovers=false
}
