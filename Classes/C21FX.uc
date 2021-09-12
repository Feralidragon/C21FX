
class C21FX extends Actor abstract;

//Enumerations
enum ERenderPoint2DVisibility
{
	RP2DV_Unknown,
	RP2DV_Hidden,
	RP2DV_Visible
};


//Structures
struct RenderPoint2D
{
	var() float X;
	var() float Y;
};

struct RenderScale2D
{
	var() float U;
	var() float V;
};

struct RenderView
{
	var Actor Actor;
	var vector Location;
	var rotator Rotation;
};

struct RenderFrame
{
	var Canvas Canvas;
	var float Delta;
	var float Opacity;
	var RenderView View;
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
final static function RenderPoint2D locationToRenderPoint2D(
	vector location, RenderFrame frame, optional out ERenderPoint2DVisibility visibility, optional bool skipVisibility
) {
	//local
	local float tanFovX, tanFovY, axisXSize, tanX, tanY;
	local vector direction, axisX, axisY, axisZ, axisXDelta;
	local RenderPoint2D point;
	
	//calculate
	direction = normal(location - frame.View.Location);
	tanFovX = tan(frame.Canvas.ViewPort.Actor.FOVAngle * PI / 360);
	tanFovY = (frame.Canvas.ClipY / frame.Canvas.ClipX) * tanFovX;
	getAxes(frame.View.Rotation, axisX, axisY, axisZ);
	axisX *= direction dot axisX;
	axisXDelta = direction - axisX;
	axisXSize = vsize(axisX);
	tanX = (axisXDelta dot axisY) / axisXSize;
	tanY = (axisXDelta dot axisZ) / axisXSize;
	
	//finalize
	point.X = frame.Canvas.ClipX * 0.5 * (1.0 + tanX / tanFovX);
	point.Y = frame.Canvas.ClipY * 0.5 * (1.0 - tanY / tanFovY);
	
	//visibility
	visibility = RP2DV_Unknown;
	if (!skipVisibility) {
		if (
			(axisX dot vector(frame.View.Rotation)) > 0.0 && 
			point.X == fclamp(point.X, frame.Canvas.OrgX, frame.Canvas.ClipX) && 
			point.Y == fclamp(point.Y, frame.Canvas.OrgY, frame.Canvas.ClipY)
		) {
			visibility = RP2DV_Visible;
		} else {
			visibility = RP2DV_Hidden;
		}
	}
	
	//return
	return point;
}

final static function RenderScale2D locationToRenderScale2D(vector location, RenderFrame frame)
{
	//local
	local vector axisX, axisY, axisZ;
	local float pxX, pxY, pyX, pyY;
	local RenderPoint2D pointO, pointX, pointY;
	local RenderScale2D scale;
	
	//calculate
	getAxes(rotator(location - frame.View.Location), axisX, axisY, axisZ);
	pointO = locationToRenderPoint2D(location, frame,, true);
	pointX = locationToRenderPoint2D(location + axisY, frame,, true);
	pointY = locationToRenderPoint2D(location + axisZ, frame,, true);
	pxX = pointX.X - pointO.X;
	pxY = pointX.Y - pointO.Y;
	pyX = pointY.X - pointO.X;
	pyY = pointY.Y - pointO.Y;
	
	//finalize
	scale.U = sqrt(pxX * pxX + pxY * pxY);
	scale.V = sqrt(pyX * pyX + pyY * pyY);
	
	//return
	return scale;
}

final static function color hsbToColor(byte hue, byte saturation, byte brightness)
{
	//local
	local float h, s, b, i, f, p, q, t, cR, cG, cB;
	local color color;
	
	//hsb
	h = float(hue) / 255.0;
	s = 1.0 - float(saturation) / 255.0;
	b = float(brightness) / 255.0;
	
	//calculate
	i = float(int(h * 6.0));
	f = h * 6.0 - i;
	p = b * (1.0 - s);
	q = b * (1.0 - f * s);
	t = b * (1.0 - (1.0 - f) * s);
	
	//set
	switch (int(i) % 6) {
		case 0:
			cR = b;
			cG = t;
			cB = p;
			break;
		case 1:
			cR = q;
			cG = b;
			cB = p;
			break;
		case 2:
			cR = p;
			cG = b;
			cB = t;
			break;
		case 3:
			cR = p;
			cG = q;
			cB = b;
			break;
		case 4:
			cR = t;
			cG = p;
			cB = b;
			break;
		case 5:
			cR = b;
			cG = p;
			cB = q;
			break;
	}
	
	//finalize
	color.R = byte(cR * 255.0);
	color.G = byte(cG * 255.0);
	color.B = byte(cB * 255.0);
	
	//return
	return color;
}

final static function drawTexture(
	RenderFrame frame, texture texture, RenderPoint2D point, RenderScale2D scale, optional bool bCenter
) {
	//local
	local float x, y, u, v;
	
	//uv
	u = float(texture.USize) * scale.U;
	v = float(texture.VSize) * scale.V;
	
	//xy
	x = point.X;
	y = point.Y;
	if (bCenter) {
		x -= u * 0.5;
		y -= v * 0.5;
	}
	
	//render
	frame.Canvas.setPos(x, y);
	frame.Canvas.drawRect(texture, u, v);
}



defaultproperties
{
	bGameRelevant=true
}
