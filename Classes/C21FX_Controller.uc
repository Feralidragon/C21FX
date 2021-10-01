
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
	var() string TransparencyTag;
};


//Editable properties (controller)
var(Controller) name NodesTag;
var(Controller) NodeVisibility Visibility;


//Private properties
var private bool initializedNodes;
var private C21FX_Node rootNode;
var private C21FX_Point rootPoint;


replication
{
	reliable if (Role == ROLE_Authority)
		NodesTag, Visibility;
}


//Implementable events
event initialize();


//Implementable simulated events
simulated event render(RenderFrame frame);

simulated event C21FX_Node createNode(Actor actor);

simulated event initializeNodesRender(RenderFrame frame);

simulated event renderNode(C21FX_Node node, RenderFrame frame);

simulated event C21FX_Link createLink(C21FX_Point point1, C21FX_Point point2);

simulated event renderLink(C21FX_Link link, RenderFrame frame);


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
	
	//transparency
	Visibility.TransparencyTag = caps(Visibility.TransparencyTag);
	
	//initialize
	initialize();
}


//Final simulated functions
final simulated function drawFrame(RenderFrame frame)
{
	//local
	local C21FX_Point point;
	
	//render
	render(frame);
	
	//nodes
	initializeNodes();
	drawNodes(rootNode, frame);
	
	//points
	for (point = rootPoint; point != none; point = point.NextPoint) {
		drawLinks(point, frame);
	}
}

final simulated function drawNodes(C21FX_Node rootNode, RenderFrame frame)
{
	//local
	local C21FX_Node node;
	local float frameOpacity, viewDistanceDelta;
	
	//initialize
	frameOpacity = frame.Opacity;
	viewDistanceDelta = Visibility.ViewDistance - Visibility.ViewFadeDistance;
	initializeNodesRender(frame);
	
	//nodes
	for (node = rootNode; node != none; node = node.NextNode) {
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
		
		//finalize
		if (node.bEnd) {
			break;
		}
	}
	
	//finalize
	frame.Opacity = frameOpacity;
}

final simulated function drawLinks(C21FX_Point point, RenderFrame frame)
{
	//local
	local C21FX_Link link;
	
	//check
	if (point == none || point.bTraversing) {
		return;
	}
	
	//initialize
	point.bTraversing = true;
	
	//links
	for (link = point.getRootLink(); link != none; link = link.NextLink) {
		//render
		renderLink(link, frame);
		
		//recursive
		drawLinks(link.Point2, frame);
	}
	
	//finalize
	point.bTraversing = false;
}

final simulated function initializeNodes()
{
	//local
	local Actor actor;
	local C21FX_Point point;
	
	//check
	if (initializedNodes) {
		return;
	}
	
	//initialize
	if (NodesTag != '') {
		foreach AllActors(class'Actor', actor, NodesTag) {
			if (actor.bNoDelete || actor.bStatic) {
				//point
				point = C21FX_Point(actor);
				if (point != none) {
					initializeLinks(point);
					if (point.isLinked()) {
						point.NextPoint = rootPoint;
						rootPoint = point;
						continue;
					}
				}
				
				//node
				rootNode = generateNode(rootNode, actor);
			}
		}
		initializedNodes = true;
	}
}

final simulated function C21FX_Node generateNode(C21FX_Node rootNode, Actor actor)
{
	//local
	local C21FX_Node node;
	
	//check
	if (actor == none) {
		return none;
	}
	
	//node
	node = createNode(actor);
	if (node == none) {
		node = new class'C21FX_Node';
	}
	node.Actor = actor;
	node.Location = actor.Location;
	node.NextNode = rootNode;
	
	//return
	return node;
}

final simulated function initializeLinks(C21FX_Point point)
{
	//local
	local C21FX_Link link;
	local C21FX_Point point2;
	
	//check
	if (point == none || point.Event == '' || point.hasLinks()) {
		return;
	}
	
	//initialize
	foreach AllActors(class'C21FX_Point', point2, point.Event) {
		//check
		if (point2 == point) {
			continue;
		}
		
		//link
		link = createLink(point, point2);
		if (link == none) {
			link = new class'C21FX_Link';
		}
		link.Point1 = point;
		link.Point2 = point2;
		point.addLink(link);
		
		//recursive
		initializeLinks(point2);
	}
}

final simulated function bool isNodeVisible(C21FX_Node node, RenderFrame frame, optional out RenderPoint2D point)
{
	//local
	local ERenderPoint2DVisibility pointVisibility;
	local bool actorHidden;
	
	//check
	if (node == none) {
		return false;
	}
	
	//actor sync
	actorHidden = node.Actor == none || node.Actor.bHidden;
	if (
		(Visibility.ActorSync == VAS_Auto && actorHidden && C21FX_Point(node.Actor) == none && 
		Keypoint(node.Actor) == none && Light(node.Actor) == none && NavigationPoint(node.Actor) == none && 
		Triggers(node.Actor) == none) || 
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
	if (node == none || Visibility.OcclusionType == VOT_None) {
		return false;
	}
	
	//trace
	traceActor = frame.View.Actor;
	traceStart = frame.View.Location;
	bTraceActors = Visibility.OcclusionType == VOT_All;
	while (traceActor != none) {
		traceActor = traceActor.trace(hitLocation, hitNormal, node.Location, traceStart, bTraceActors);
		if (traceActor != none) {
			//next
			traceStart = hitLocation;
			
			//glass
			if (instr(caps(traceActor.Tag), Visibility.TransparencyTag) != -1) {
				if (Mover(traceActor) != none) {
					mTraceActor = trace(mHitLocation, mHitNormal, hitLocation, node.Location);
					if (mTraceActor != traceActor) {
						return true;
					}
					traceStart = mHitLocation + mHitNormal;
				}
				continue;
			}
			
			//actor	
			if (
				traceActor == Level || Mover(traceActor) != none || (
					bTraceActors && !traceActor.bHidden && traceActor.DrawType == DT_Mesh && 
					(traceActor.Style == STY_Normal || traceActor.Style == STY_Masked)
				)
			) {
				return true;
			}
		}
	}
	
	//return
	return false;
}



defaultproperties
{
	//editables (controller)
	Visibility=(ViewDistance=20000,ViewFadeDistance=18000,TransparencyTag="glass")
	
	//network
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
