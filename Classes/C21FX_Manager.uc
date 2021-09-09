
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
	local RenderFrame frame;
	local C21FX_Controller controller;
	
	//delta time
	if (deltaTime <= 0.0) {
		return;
	}
	
	//frame
	frame.Canvas = canvas;
	frame.Delta = deltaTime;
	frame.Opacity = 1.0;
	
	//controllers
	foreach AllActors(class'C21FX_Controller', controller) {
		frame.Canvas.reset();
		frame.Canvas.Z = 1.5;
		frame.Canvas.DrawColor.R = 255;
		frame.Canvas.DrawColor.G = 255;
		frame.Canvas.DrawColor.B = 255;
		frame.Canvas.DrawColor.A = 255;
		controller.render(frame);
	}
}



defaultproperties
{
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
