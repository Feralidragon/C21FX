
class C21FX_ViewController extends C21FX_Controller abstract;

//Enumerations
enum EViewOcclusionType
{
	VOT_All,
	VOT_Level,
	VOT_None
};

enum EViewActorVisibilitySync
{
	VAVS_Auto,
	VAVS_Same,
	VAVS_Invert,
	VAVS_Ignore
};


//Editable properties (events)
var(Events) name NodesTag;


//Editable properties (view)
var(View) EViewOcclusionType OcclusionType;
var(View) EViewActorVisibilitySync ActorVisibilitySync;
var(View) bool bZoneExclusive;
var(View) bool ignoreMovers;


//Private properties
var private bool initializedNodes;
var private C21FX_ViewNode firstNode;


replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		NodesTag, OcclusionType, ActorVisibilitySync, bZoneExclusive, ignoreMovers;
}


//Implementable events
event initializeView();


//Implementable simulated events
simulated event C21FX_ViewNode createNode(Actor actor);

simulated event initializeViewRender(RenderFrame frame);

simulated event renderNode(C21FX_ViewNode node, RenderFrame frame);


//Implemented events
event initialize()
{
	//local
	local Actor actor;
	
	//actors
	if (NodesTag != '') {
		foreach AllActors(class'Actor', actor, NodesTag) {
			if (actor.bNoDelete || actor.bStatic) {
				actor.bAlwaysRelevant = true;
			}
		}
	}
	
	//initialize
	initializeView();
}


//Implemented simulated events
simulated event render(RenderFrame frame)
{
	//local
	local C21FX_ViewNode node;
	
	//initialize
	initializeNodes();
	initializeViewRender(frame);
	
	//render
	for (node = firstNode; node != none; node = node.NextNode) {
		renderNode(node, frame);
	}
}


//Final simulated functions
final simulated function initializeNodes()
{
	//local
	local Actor actor;
	local C21FX_ViewNode node;
	
	//check
	if (initializedNodes) {
		return;
	}
	
	//initialize
	if (NodesTag != '') {
		foreach AllActors(class'Actor', actor, NodesTag) {
			if (actor.bNoDelete || actor.bStatic) {
				node = createNode(actor);
				if (node == none) {
					node = new class'C21FX_ViewNode';
				}
				node.Actor = actor;
				node.Location = actor.Location;
				node.NextNode = firstNode;
				firstNode = node;
			}
		}
		initializedNodes = true;
	}
}

final simulated function bool isNodeVisible(C21FX_ViewNode node, RenderFrame frame, out RenderPoint2D point)
{
	//local
	local ERenderPoint2DVisibility pointVisibility;
	local bool actorHidden, visible;
	
	//actor visibility sync
	actorHidden = node.Actor == none || node.Actor.bHidden;
	if (
		(ActorVisibilitySync == VAVS_Auto && actorHidden && Keypoint(node.Actor) == none && 
		Light(node.Actor) == none && NavigationPoint(node.Actor) == none && Triggers(node.Actor) == none) || 
		(ActorVisibilitySync == VAVS_Same && actorHidden) || 
		(ActorVisibilitySync == VAVS_Invert && !actorHidden)
	) {
		return false;
	}
	
	//zone
	if (bZoneExclusive && node.Actor != none && node.Actor.Region.ZoneNumber != frame.View.Actor.Region.ZoneNumber) {
		return false;
	}
	
	//point
	point = locationToRenderPoint2D(node.Location, frame, pointVisibility);
	if (pointVisibility != RP2DV_Visible) {
		return false;
	}
	
	//trace
	if (OcclusionType != VOT_None) {
		visible = frame.View.Actor.fastTrace(node.Location, frame.View.Location);
		if (
			(visible && OcclusionType == VOT_All && isNodeOccluded(node, frame)) || 
			(!visible && (!ignoreMovers || isNodeOccluded(node, frame)))
		) {
			return false;
		}
	}
	
	//return
	return true;
}

final simulated function bool isNodeOccluded(C21FX_ViewNode node, RenderFrame frame)
{
	//local
	local Actor traceActor;
	local vector hitLocation, hitNormal, traceStart;
	local bool bTraceActors;
	
	//check
	if (OcclusionType == VOT_None) {
		return false;
	}
	
	//trace
	traceActor = frame.View.Actor;
	traceStart = frame.View.Location;
	bTraceActors = OcclusionType == VOT_All;
	while (traceActor != none) {
		traceActor = traceActor.trace(hitLocation, hitNormal, node.Location, traceStart, bTraceActors);
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
	//editables (view)
	OcclusionType=VOT_All
	ActorVisibilitySync=VAVS_Auto
	bZoneExclusive=false
	ignoreMovers=false
}
