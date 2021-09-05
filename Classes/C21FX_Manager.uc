
class C21FX_Manager extends C21FX_Engine nousercreate;

//Private properties
var private float deltaTime;


//Events
event postBeginPlay()
{
	spawn(class'C21FX_CanvasRender', self);
}


//Simulated events
simulated event tick(float delta)
{
	deltaTime = delta;
}


//Final simulated functions
final simulated function render(Canvas canvas)
{
	//local
	local C21FX_Controller controller;
	
	//delta time
	if (deltaTime <= 0.0) {
		return;
	}
	
	//controllers
	foreach AllActors(class'C21FX_Controller', controller) {
		canvas.reset();
		canvas.Z = 1.5;
		canvas.DrawColor.R = 255;
		canvas.DrawColor.G = 255;
		canvas.DrawColor.B = 255;
		canvas.DrawColor.A = 255;
		controller.render(canvas, deltaTime, 1.0);
	}
}



defaultproperties
{
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
