
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_Node extends C21FX_Object nousercreate;

//Properties
var C21FX_Node NextNode;
var bool bEnd;


//Private properties
var private Actor Actor;
var private vector Location;
var private vector ActorLocation;
var private rotator ActorRotation;


//Final functions
final function setActor(Actor actor)
{
	self.Actor = actor;
	resetActorTracking();
}

final function resetActorTracking()
{
	if (Actor != none) {
		ActorLocation = Actor.Location;
		ActorRotation = Actor.Rotation;
	}
}

final function Actor getActor()
{
	return Actor;
}

final function setLocation(vector location)
{
	self.Location = location;
	resetActorTracking();
}

final function vector getLocation()
{
	//local
	local vector location;
	
	//location
	location = self.Location;
	if (Actor != none) {
		if (Actor.Location != ActorLocation) {
			location += (Actor.Location - ActorLocation);
		}
		if (Actor.Rotation != ActorRotation) {
			location = Actor.Location + ((location - Actor.Location) << ActorRotation >> Actor.Rotation);
		}
	}
	
	//return
	return location;
}

final function vector getRenderLocation(C21FX.RenderFrame frame, optional bool bBackdropEnabled)
{
	if (bBackdropEnabled && Actor != none && SkyZoneInfo(Actor.Region.Zone) != none) {
		return frame.View.Location + ((getLocation() - Actor.Region.Zone.Location) << Actor.Region.Zone.Rotation);
	}
	return getLocation();
}

final function float getRenderDistance(C21FX.RenderFrame frame, optional bool bBackdropEnabled)
{
	if (bBackdropEnabled && Actor != none && SkyZoneInfo(Actor.Region.Zone) != none) {
		return vsize(getLocation() - Actor.Region.Zone.Location);
	}
	return vsize(getLocation() - frame.View.Location);
}
