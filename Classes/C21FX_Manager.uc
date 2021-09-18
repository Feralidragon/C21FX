
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

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
	local Actor viewActor;
	local vector viewLocation;
	local rotator viewRotation;
	
	//check
	if (canvas == none || deltaTime <= 0.0) {
		return;
	}
	
	//view
	canvas.ViewPort.Actor.playerCalcView(viewActor, viewLocation, viewRotation);
	if (viewActor == none) {
		return;
	}
	
	//controllers
	foreach AllActors(class'C21FX_Controller', controller) {
		//canvas
		canvas.reset();
		canvas.Z = MAX_RENDER_NEAREST_Z;
		canvas.DrawColor.R = 255;
		canvas.DrawColor.G = 255;
		canvas.DrawColor.B = 255;
		
		//frame
		frame.Canvas = canvas;
		frame.Delta = deltaTime;
		frame.Opacity = 1.0;
		frame.View.Actor = viewActor;
		frame.View.Location = viewLocation;
		frame.View.Rotation = viewRotation;
		
		//render
		controller.drawFrame(frame);
	}
	
	//finalize
	canvas.reset();
}



defaultproperties
{
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
