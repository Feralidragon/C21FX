
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_SunCoronaController extends C21FX_CoronaController;

//Import directives (textures - coronas SD)
#exec TEXTURE IMPORT NAME=CoronaSun FILE=Textures/Coronas/SD/CoronaSun.bmp GROUP=Coronas MIPS=OFF LODSET=0

//Import directives (textures - coronas HD)
#exec TEXTURE MERGECOMPRESSED NAME=CoronaSun FILE=Textures/Coronas/HD/CoronaSun.png GROUP=Coronas MIPS=OFF LODSET=0 FORMAT=BC7



defaultproperties
{
	NodesTag="C21FX_SunPoint"
	Corona=(Texture=(Value=Texture'CoronaSun'),Size=2.5,Color=(Mode=CCM_Value,Value=(R=255,G=224,B=192)))
	Lensflare=(Presets=LP_Sun)
}
