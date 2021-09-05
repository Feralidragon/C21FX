
class C21FX extends Actor abstract;

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



defaultproperties
{
	bGameRelevant=true
}
