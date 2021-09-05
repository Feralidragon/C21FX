
class C21FX_Manager extends C21FX_Engine nousercreate;

event postBeginPlay()
{
	spawn(class'C21FX_CanvasRender', self);
}

final simulated function render(Canvas canvas)
{
	//local
	local C21FX_Controller controller;
	
	//controllers
	foreach AllActors(class'C21FX_Controller', controller) {
		canvas.reset();
		canvas.Z = 1.5;
		canvas.DrawColor.R = 255;
		canvas.DrawColor.G = 255;
		canvas.DrawColor.B = 255;
		controller.render(canvas);
	}
}

defaultproperties
{
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
