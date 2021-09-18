
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_Controller extends C21FX_Editor abstract;

//Enumerations
enum EVisibilityOcclusionType
{
	VOT_All,
	VOT_Level,
	VOT_None
};

enum EVisibilityActorSync
{
	VAS_Auto,
	VAS_Same,
	VAS_Invert,
	VAS_Ignore
};


//Structures
struct NodeVisibility
{
	var() int ViewDistance;
	var() int ViewFadeDistance;
	var() bool bZoneExclusive;
	var() EVisibilityOcclusionType OcclusionType;
	var() EVisibilityActorSync ActorSync;
};


//Editable properties (controller)
var(Controller) name NodesTag;
var(Controller) NodeVisibility Visibility;


//Private properties
var private bool initializedNodes;
var private C21FX_Node firstNode;


replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		NodesTag, Visibility;
}


//Implementable events
event initialize();


//Implementable simulated events
simulated event initializeRender(RenderFrame frame);

simulated event render(RenderFrame frame);

simulated event C21FX_Node createNode(Actor actor);

simulated event initializeNodesRender(RenderFrame frame);

simulated event renderNode(C21FX_Node node, RenderFrame frame);


//Events
event postBeginPlay()
{
	//local
	local bool hasManager;
	local C21FX_Manager manager;
	local Actor actor;
	
	//manager (check)
	foreach AllActors(class'C21FX_Manager', manager) {
		hasManager = true;
		break;
	}
	
	//manager (spawn)
	if (!hasManager) {
		spawn(class'C21FX_Manager');
	}
	
	//actors
	if (NodesTag != '') {
		foreach AllActors(class'Actor', actor, NodesTag) {
			if (actor.bNoDelete || actor.bStatic) {
				actor.bAlwaysRelevant = true;
			}
		}
	}
	
	//initialize
	initialize();
}


//Final simulated functions
final simulated function drawFrame(RenderFrame frame)
{
	//local
	local C21FX_Node node;
	local float frameOpacity, viewDistanceDelta;
	
	//initialize
	initializeRender(frame);
	frameOpacity = frame.Opacity;
	viewDistanceDelta = Visibility.ViewDistance - Visibility.ViewFadeDistance;
	
	//render
	render(frame);
	
	//nodes
	initializeNodes();
	initializeNodesRender(frame);
	for (node = firstNode; node != none; node = node.NextNode) {
		//initialize
		frame.Opacity = frameOpacity;
		
		//distance
		node.Distance = vsize(node.Location - frame.View.Location);
		if (node.Distance > Visibility.ViewDistance) {
			continue;
		} else if (viewDistanceDelta > 0.0 && node.Distance >= Visibility.ViewFadeDistance) {
			frame.Opacity *= (Visibility.ViewDistance - node.Distance) / viewDistanceDelta;
		}
		
		//render
		renderNode(node, frame);
	}
}

final simulated function initializeNodes()
{
	//local
	local Actor actor;
	local C21FX_Node node;
	
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
					node = new class'C21FX_Node';
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

final simulated function bool isNodeVisible(C21FX_Node node, RenderFrame frame, optional out RenderPoint2D point)
{
	//local
	local ERenderPoint2DVisibility pointVisibility;
	local bool actorHidden;
	
	//actor sync
	actorHidden = node.Actor == none || node.Actor.bHidden;
	if (
		(Visibility.ActorSync == VAS_Auto && actorHidden && Keypoint(node.Actor) == none && 
		Light(node.Actor) == none && NavigationPoint(node.Actor) == none && Triggers(node.Actor) == none) || 
		(Visibility.ActorSync == VAS_Same && actorHidden) || 
		(Visibility.ActorSync == VAS_Invert && !actorHidden)
	) {
		return false;
	}
	
	//zone
	if (
		Visibility.bZoneExclusive && node.Actor != none && 
		node.Actor.Region.ZoneNumber != frame.View.Actor.Region.ZoneNumber
	) {
		return false;
	}
	
	//point
	point = locationToRenderPoint2D(node.Location, frame, pointVisibility);
	if (pointVisibility != RP2DV_Visible) {
		return false;
	}
	
	//occlusion
	if (isNodeOccluded(node, frame)) {
		return false;
	}
	
	//return
	return true;
}

final simulated function bool isNodeOccluded(C21FX_Node node, RenderFrame frame)
{
	//local
	local Actor traceActor, mTraceActor;
	local vector hitLocation, hitNormal, traceStart, mHitLocation, mHitNormal;
	local bool bTraceActors;
	
	//check
	if (Visibility.OcclusionType == VOT_None) {
		return false;
	}
	
	//trace
	traceActor = frame.View.Actor;
	traceStart = frame.View.Location;
	bTraceActors = Visibility.OcclusionType == VOT_All;
	while (traceActor != none) {
		traceActor = traceActor.trace(hitLocation, hitNormal, node.Location, traceStart, bTraceActors);
		if (traceActor != none) {
			if (Mover(traceActor) != none && instr(caps(traceActor.Tag), "GLASS") != -1) {
				mTraceActor = trace(mHitLocation, mHitNormal, hitLocation, node.Location);
				if (mTraceActor == traceActor) {
					traceStart = mHitLocation + mHitNormal;
				} else {
					return true;
				}
			} else if (
				traceActor == Level || (
					bTraceActors && !traceActor.bHidden && traceActor.DrawType == DT_Mesh && 
					(traceActor.Style == STY_Normal || traceActor.Style == STY_Masked)
				)
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
	//editables (controller)
	Visibility=(ViewDistance=20000,ViewFadeDistance=18000)
	
	//network
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
