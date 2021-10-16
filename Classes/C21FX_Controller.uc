
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_Controller extends C21FX_Editor abstract;

//Constants
const BACKDROP_TRACE_DISTANCE = 100000.0;
const BACKDROP_TRACE_HIT_LEEWAY = 8.0;


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
	var() string TransparencySubtag;
	var() string BackdropZoneSubtag;
};

struct NodeBackdropEdgeAxis
{
	var float Min;
	var float Max;
};

struct NodeBackdropEdge
{
	var NodeBackdropEdgeAxis X;
	var NodeBackdropEdgeAxis Y;
	var NodeBackdropEdgeAxis Z;
};

struct NodeBackdrop
{
	var ZoneInfo Zone;
	var NodeBackdropEdge Edge;
};


//Programmable properties
var bool bBackdropEnabled;


//Editable properties (controller)
var(Controller) name NodesTag;
var(Controller) NodeVisibility Visibility;


//Private properties
var private bool InitializedNodes;
var private C21FX_Node RootNode;
var private C21FX_Point RootPoint;
var private NodeBackdrop Backdrops[32];
var private byte BackdropsCount;


replication
{
	reliable if (Role == ROLE_Authority)
		NodesTag, Visibility, Backdrops, BackdropsCount;
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
	
	//subtags
	Visibility.TransparencySubtag = caps(Visibility.TransparencySubtag);
	Visibility.BackdropZoneSubtag = caps(Visibility.BackdropZoneSubtag);
	
	//backdrops
	initializeBackdrops();
	
	//initialize
	initialize();
}


//Final functions
final function initializeBackdrops()
{
	//local
	local ZoneInfo zone;
	local vector vectors[6], hitLocation, hitNormal, traceEnd, edgeLocation;
	local byte i;
	
	//check
	if (!bBackdropEnabled) {
		return;
	}
	
	//vectors
	vectors[0] = vect(1.0, 0.0, 0.0);
	vectors[1] = vect(-1.0, 0.0, 0.0);
	vectors[2] = vect(0.0, 1.0, 0.0);
	vectors[3] = vect(0.0, -1.0, 0.0);
	vectors[4] = vect(0.0, 0.0, 1.0);
	vectors[5] = vect(0.0, 0.0, -1.0);
	
	//zones
	foreach AllActors(class'ZoneInfo', zone) {
		//check
		if (SkyZoneInfo(zone) != none || instr(caps(zone.Tag), Visibility.BackdropZoneSubtag) == -1) {
			continue;
		}
		
		//zone
		Backdrops[BackdropsCount].Zone = zone;
		
		//trace
		for (i = 0; i < arrayCount(vectors); i++) {
			//trace
			traceEnd = zone.Location + vectors[i] * BACKDROP_TRACE_DISTANCE;
			if (trace(hitLocation, hitNormal, traceEnd, zone.Location) != none) {
				edgeLocation = hitLocation;
			} else {
				edgeLocation = traceEnd;
			}
			
			//edge
			switch (i) {
				case 0:
					Backdrops[BackdropsCount].Edge.X.Max = edgeLocation.X;
					break;
				case 1:
					Backdrops[BackdropsCount].Edge.X.Min = edgeLocation.X;
					break;
				case 2:
					Backdrops[BackdropsCount].Edge.Y.Max = edgeLocation.Y;
					break;
				case 3:
					Backdrops[BackdropsCount].Edge.Y.Min = edgeLocation.Y;
					break;
				case 4:
					Backdrops[BackdropsCount].Edge.Z.Max = edgeLocation.Z;
					break;
				case 5:
					Backdrops[BackdropsCount].Edge.Z.Min = edgeLocation.Z;
					break;
			}
		}
		
		//finalize
		BackdropsCount++;
		if (BackdropsCount >= arrayCount(Backdrops)) {
			break;
		}
	}
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
	drawNodes(RootNode, frame);
	
	//points
	for (point = RootPoint; point != none; point = point.NextPoint) {
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
		node.Distance = vsize(node.Location - getNodeViewLocation(node, frame));
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
	if (InitializedNodes) {
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
						point.NextPoint = RootPoint;
						RootPoint = point;
						continue;
					}
				}
				
				//node
				RootNode = generateNode(RootNode, actor);
			}
		}
		InitializedNodes = true;
	}
}

final simulated function vector getNodeViewLocation(C21FX_Node node, RenderFrame frame)
{
	if (bBackdropEnabled && node.Actor != none && SkyZoneInfo(node.Actor.Region.Zone) != none) {
		return node.Actor.Region.Zone.Location;
	}
	return frame.View.Location;
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
		node.Actor.Region.ZoneNumber != frame.View.Actor.Region.ZoneNumber && (
			!bBackdropEnabled || SkyZoneInfo(node.Actor.Region.Zone) == none || 
			node.Actor.Region.Zone != frame.View.Actor.Region.Zone.SkyZone
		)
	) {
		return false;
	}
	
	//point
	point = getNodeRenderPoint2D(node, frame, pointVisibility);
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

final simulated function RenderPoint2D getNodeRenderPoint2D(
	C21FX_Node node, RenderFrame frame, out ERenderPoint2DVisibility visibility
) {
	//local
	local vector location;
	
	//location
	if (bBackdropEnabled && node.Actor != none && SkyZoneInfo(node.Actor.Region.Zone) != none) {
		location = frame.View.Location + (
			(node.Location - node.Actor.Region.Zone.Location) << node.Actor.Region.Zone.Rotation
		);
	} else {
		location = node.Location;
	}
	
	//return
	return locationToRenderPoint2D(location, frame, visibility);
}

final simulated function bool isNodeOccluded(C21FX_Node node, RenderFrame frame)
{
	//local
	local Actor traceActor, mTraceActor;
	local vector nodeLocation, hitLocation, hitNormal, traceStart, mHitLocation, mHitNormal;
	local bool bTraceActors;
	
	//check
	if (node == none || Visibility.OcclusionType == VOT_None) {
		return false;
	}
	
	//trace
	traceActor = frame.View.Actor;
	traceStart = frame.View.Location;
	bTraceActors = Visibility.OcclusionType == VOT_All;
	nodeLocation = getNodeOcclusionLocation(node, frame);
	while (traceActor != none) {
		traceActor = traceActor.trace(hitLocation, hitNormal, nodeLocation, traceStart, bTraceActors);
		if (traceActor != none) {
			//next
			traceStart = hitLocation;
			
			//glass
			if (instr(caps(traceActor.Tag), Visibility.TransparencySubtag) != -1) {
				if (Mover(traceActor) != none) {
					mTraceActor = trace(mHitLocation, mHitNormal, hitLocation, nodeLocation);
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
			
			//collision
			traceStart += (fmin(traceActor.CollisionHeight, traceActor.CollisionRadius) + 1.0) * 
				normal(nodeLocation - traceStart);
		}
	}
	
	//return
	return false;
}

final simulated function vector getNodeOcclusionLocation(C21FX_Node node, RenderFrame frame)
{
	//local
	local vector location, hitLocation, hitNormal, hitLocationMin;
	local NodeBackdrop backdrop;
	local byte i;
	
	//backdrop
	if (bBackdropEnabled && node.Actor != none && SkyZoneInfo(node.Actor.Region.Zone) != none) {
		//location
		location = frame.View.Location + BACKDROP_TRACE_DISTANCE * normal(
			(node.Location - node.Actor.Region.Zone.Location) << node.Actor.Region.Zone.Rotation
		);
		
		//trace
		if (BackdropsCount > 0 && trace(hitLocation, hitNormal, location, frame.View.Location) != none) {
			hitLocationMin = hitLocation + BACKDROP_TRACE_HIT_LEEWAY * hitNormal;
			for (i = 0; i < BackdropsCount; i++) {
				backdrop = Backdrops[i];
				if (
					backdrop.Zone.SkyZone == node.Actor.Region.Zone && 
					hitLocationMin.X >= backdrop.Edge.X.Min && hitLocationMin.X <= backdrop.Edge.X.Max && 
					hitLocationMin.Y >= backdrop.Edge.Y.Min && hitLocationMin.Y <= backdrop.Edge.Y.Max && 
					hitLocationMin.Z >= backdrop.Edge.Z.Min && hitLocationMin.Z <= backdrop.Edge.Z.Max && (
						abs(hitLocation.X - backdrop.Edge.X.Min) <= BACKDROP_TRACE_HIT_LEEWAY || 
						abs(hitLocation.X - backdrop.Edge.X.Max) <= BACKDROP_TRACE_HIT_LEEWAY || 
						abs(hitLocation.Y - backdrop.Edge.Y.Min) <= BACKDROP_TRACE_HIT_LEEWAY || 
						abs(hitLocation.Y - backdrop.Edge.Y.Max) <= BACKDROP_TRACE_HIT_LEEWAY || 
						abs(hitLocation.Z - backdrop.Edge.Z.Min) <= BACKDROP_TRACE_HIT_LEEWAY || 
						abs(hitLocation.Z - backdrop.Edge.Z.Max) <= BACKDROP_TRACE_HIT_LEEWAY
					)
				) {
					return hitLocationMin;
				}
			}
		}
		
		//return
		return location;
	}
	
	//return
	return node.Location;
}



defaultproperties
{
	//editables (controller)
	Visibility=(ViewDistance=20000,ViewFadeDistance=18000,TransparencySubtag="glass",BackdropZoneSubtag="backdrop")
	
	//network
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
