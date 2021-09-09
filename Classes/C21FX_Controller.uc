
class C21FX_Controller extends C21FX_Editor abstract;

//Implementable events
event initialize();


//Implementable simulated events
simulated event render(RenderFrame frame);


//Events
event postBeginPlay()
{
	//local
	local bool hasManager;
	local C21FX_Manager manager;
	
	//manager (check)
	foreach AllActors(class'C21FX_Manager', manager) {
		hasManager = true;
		break;
	}
	
	//manager (spawn)
	if (!hasManager) {
		spawn(class'C21FX_Manager');
	}
	
	//initialize
	initialize();
}



defaultproperties
{
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
