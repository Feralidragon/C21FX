
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_Point extends C21FX_Editor;

//Properties
var C21FX_Point NextPoint;
var bool bTraversing;


//Private properties
var private C21FX_Link rootLink;
var private bool bLinked;


//Final simulated functions
final simulated function bool isLinked()
{
	return bLinked;
}

final simulated function bool hasLinks()
{
	return rootLink != none;
}

final simulated function C21FX_Link getRootLink()
{
	return rootLink;
}

final simulated function addLink(C21FX_Link link)
{
	if (link != none && link.Point1 != none && link.Point2 != none) {
		link.Point1.bLinked = true;
		link.Point2.bLinked = true;
		link.NextLink = rootLink;
		rootLink = link;
	}
}



defaultproperties
{
	bNoDelete=true
	bNetTemporary=true
	bAlwaysRelevant=true
}
