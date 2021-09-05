
class C21FX_CanvasRender extends Mutator nousercreate;

//Simulated events
simulated event tick(float delta)
{
	if (!bHUDMutator && Level.NetMode != NM_DedicatedServer) {
		registerHUDMutator();
	}
}

simulated event postRender(Canvas canvas)
{
	//local
	local C21FX_Manager manager;
	
	//next
	if (NextHUDMutator != none) {
		NextHUDMutator.postRender(canvas);
	}
	
	//manager
	manager = C21FX_Manager(Owner);
	if (manager != none) {
		manager.render(canvas);
	}
}



defaultproperties
{
	bNetTemporary=true
	bAlwaysRelevant=true
	RemoteRole=ROLE_SimulatedProxy
}
