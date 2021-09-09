
class C21FX extends Actor abstract;

//Enums
enum ERenderPoint2DVisibility
{
	RP2DV_Hidden,
	RP2DV_Visible
};


//Structs
struct RenderPoint2D
{
	var int X;
	var int Y;
};

struct RenderFrame
{
	var Canvas Canvas;
	var float Delta;
	var float Opacity;
};


//Private properties
var private PlayerPawn Player;


//Final simulated functions
final simulated function PlayerPawn getLocalPlayer()
{
	//local
	local PlayerPawn p;
	
	//search
	if (Player == none && Level.NetMode != NM_DedicatedServer) {
		foreach AllActors(class'PlayerPawn', p) {
			if (Viewport(p.Player) != none) {
				Player = p;
				break;
			}
		}
	}
	
	//return
	return Player;
}


//Final static functions
final static function RenderPoint2D vectorToRenderPoint2D(
	vector vector, Canvas canvas, optional out ERenderPoint2DVisibility visibility
) {
	//local
	local Actor viewActor;
	local vector viewLocation;
	local rotator viewRotation;
	local float tanFovX, tanFovY, dirSize, tanX, tanY;
	local vector targetDir, dir, x, y, xy;
	local RenderPoint2D point;
	
	//calculate
	canvas.ViewPort.Actor.playerCalcView(viewActor, viewLocation, viewRotation);
	targetDir = normal(vector - viewLocation);
	tanFovX = tan(canvas.ViewPort.Actor.FOVAngle * PI / 360);
	tanFovY = (canvas.ClipY / canvas.ClipX) * tanFovX;
	getAxes(viewRotation, dir, x, y);
	dir *= targetDir dot dir;
	xy = targetDir - dir;
	dirSize = vsize(dir);
	tanX = (xy dot x) / dirSize;
	tanY = (xy dot y) / dirSize;
	
	//finalize
	point.X = int(canvas.ClipX * 0.5 * (1.0 + tanX / tanFovX));
	point.Y = int(canvas.ClipY * 0.5 * (1.0 - tanY / tanFovY));
	
	//visibility
	if (
		(dir dot vector(viewRotation)) > 0.0 && 
		point.X == clamp(point.X, int(canvas.OrgX), int(canvas.ClipX)) && 
		point.Y == clamp(point.Y, int(canvas.OrgY), int(canvas.ClipY))
	) {
		visibility = RP2DV_Visible;
	} else {
		visibility = RP2DV_Hidden;
	}
	
	//return
	return point;
}



defaultproperties
{
	bGameRelevant=true
}
