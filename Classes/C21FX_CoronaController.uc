
/**
 * Author: Feralidragon
 * License: https://opensource.org/licenses/MIT The MIT License (MIT)
 */

class C21FX_CoronaController extends C21FX_Controller;

//Import directives (textures - coronas SD)
#exec TEXTURE IMPORT NAME=Corona FILE=Textures/Coronas/SD/Corona.bmp GROUP=Coronas MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=CoronaSun FILE=Textures/Coronas/SD/CoronaSun.bmp GROUP=Coronas MIPS=OFF LODSET=0

//Import directives (textures - coronas HD)
#exec TEXTURE MERGECOMPRESSED NAME=Corona FILE=Textures/Coronas/HD/Corona.png GROUP=Coronas MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=CoronaSun FILE=Textures/Coronas/HD/CoronaSun.png GROUP=Coronas MIPS=OFF LODSET=0 FORMAT=BC7

//Import directives (textures - lensflares SD)
#exec TEXTURE IMPORT NAME=Lensflare00Q FILE=Textures/Lensflares/SD/Lensflare00Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare01Q FILE=Textures/Lensflares/SD/Lensflare01Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare02Q FILE=Textures/Lensflares/SD/Lensflare02Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare03Q FILE=Textures/Lensflares/SD/Lensflare03Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare04Q FILE=Textures/Lensflares/SD/Lensflare04Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare05D FILE=Textures/Lensflares/SD/Lensflare05D.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare06D FILE=Textures/Lensflares/SD/Lensflare06D.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare07Q FILE=Textures/Lensflares/SD/Lensflare07Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare08Q FILE=Textures/Lensflares/SD/Lensflare08Q.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare09D FILE=Textures/Lensflares/SD/Lensflare09D.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare10D FILE=Textures/Lensflares/SD/Lensflare10D.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare11D FILE=Textures/Lensflares/SD/Lensflare11D.bmp GROUP=Lensflares MIPS=OFF LODSET=0
#exec TEXTURE IMPORT NAME=Lensflare12D FILE=Textures/Lensflares/SD/Lensflare12D.bmp GROUP=Lensflares MIPS=OFF LODSET=0

//Import directives (textures - lensflares HD)
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare00Q FILE=Textures/Lensflares/HD/Lensflare00Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare01Q FILE=Textures/Lensflares/HD/Lensflare01Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare02Q FILE=Textures/Lensflares/HD/Lensflare02Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare03Q FILE=Textures/Lensflares/HD/Lensflare03Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare04Q FILE=Textures/Lensflares/HD/Lensflare04Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare05D FILE=Textures/Lensflares/HD/Lensflare05D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare06D FILE=Textures/Lensflares/HD/Lensflare06D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare07Q FILE=Textures/Lensflares/HD/Lensflare07Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare08Q FILE=Textures/Lensflares/HD/Lensflare08Q.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare09D FILE=Textures/Lensflares/HD/Lensflare09D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare10D FILE=Textures/Lensflares/HD/Lensflare10D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare11D FILE=Textures/Lensflares/HD/Lensflare11D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7
#exec TEXTURE MERGECOMPRESSED NAME=Lensflare12D FILE=Textures/Lensflares/HD/Lensflare12D.png GROUP=Lensflares MIPS=OFF LODSET=0 FORMAT=BC7


//Constants
const CORONA_VISIBILITY_FADE_TIME = 0.1;
const CORONA_SCALE_FIXED = 0.125;
const LENSFLARE_SIZE_FIXED = 0.125;
const LENSFLARE_ENTRIES_COUNT = 16;
const LENSFLARE_PRESETS_COUNT = 8;
const LENSFLARE_PRESET_ANAMORPHIC_ENTRIES_COUNT = 2;
const LENSFLARE_PRESET_GLARE_ENTRIES_COUNT = 4;
const LENSFLARE_PRESET_SUN_SPECTRAL_ENTRIES_COUNT = 4;
const LENSFLARE_PRESET_SUN_ANAMORPHIC_ENTRIES_COUNT = 3;
const LENSFLARE_PRESET_SUN_LITE_ENTRIES_COUNT = 2;


//Enumerations
enum ECoronaColorMode
{
	CCM_Auto,
	CCM_Value,
	CCM_Light,
	CCM_LightHS,
	CCM_LightHue
};

enum ECoronaScaleMode
{
	CSM_Auto,
	CSM_Fixed,
	CSM_World,
	CSM_Distance
};

enum ECoronaLinkAlignment
{
	CLA_Start,
	CLA_Center,
	CLA_Middle,
	CLA_End
};

enum ECoronaLinkGradientMode
{
	CLGM_None,
	CLGM_Linear,
	CLGM_NonLinear
};

enum ELensflarePreset
{
	LP_None,
	LP_Anamorphic,
	LP_AnamorphicU,
	LP_AnamorphicV,
	LP_Bright,
	LP_Glare,
	LP_GlareU,
	LP_GlareV,
	LP_GlareSpectral,
	LP_GlareSpectralU,
	LP_GlareSpectralV,
	LP_Glow,
	LP_Ring,
	LP_Spectral,
	LP_Sun,
	LP_SunSpectral,
	LP_SunAnamorphic,
	LP_SunGlow,
	LP_Custom
};

enum ELensflareMultiplierMode
{
	LMM_None,
	LMM_Linear,
	LMM_NonLinear
};

enum ELensflarePositionAxis
{
	LPA_XY,
	LPA_X,
	LPA_Y
};

enum ELensflarePositionMode
{
	LPM_Value,
	LPM_Distributed
};

enum ELensflarePositionDistributionMode
{
	LPDM_Both,
	LPDM_Front,
	LPDM_Back
};

enum ELensflareTextureMode
{
	LTM_Value,
	LTM_Same
};

enum ELensflareColorMode
{
	LCM_Same,
	LCM_Value,
	LCM_Add,
	LCM_Subtract,
	LCM_Multiply,
	LCM_Intersect,
	LCM_Merge,
	LCM_Exclude
};

enum ELensflareColorRandomMode
{
	LCRM_None,
	LCRM_HSB,
	LCRM_RGB
};

enum ELensflareSizeMode
{
	LSM_Fixed,
	LSM_Relative,
	LSM_Absolute
};


//Structures
struct NodeCoronaTextureRender
{
	var() bool bMirrorU;
	var() bool bMirrorV;
	var() bool bSmooth;
	var() ERenderTextureMode Mode;
};

struct NodeCoronaTexture
{
	var() NodeCoronaTextureRender Render;
	var() Texture Value;
};

struct NodeCoronaScale
{
	var() ECoronaScaleMode Mode;
	var() RenderScale2D Value;
};

struct NodeCoronaColor
{
	var() ECoronaColorMode Mode;
	var() color Value;
};

struct NodeCoronaLinkGradientSize
{
	var() ECoronaLinkGradientMode Mode;
	var() float Value1;
	var() float Value2;
};

struct NodeCoronaLinkGradientGlow
{
	var() ECoronaLinkGradientMode Mode;
	var() float Value1;
	var() float Value2;
};

struct NodeCoronaLinkGradientScale
{
	var() ECoronaLinkGradientMode Mode;
	var() RenderScale2D Value1;
	var() RenderScale2D Value2;
};

struct NodeCoronaLinkGradientColor
{
	var() ECoronaLinkGradientMode Mode;
	var() color Value1;
	var() color Value2;
};

struct NodeCoronaLinkGradientSaturation
{
	var() ECoronaLinkGradientMode Mode;
	var() byte Value1;
	var() byte Value2;
};

struct NodeCoronaLinkGradient
{
	var() NodeCoronaLinkGradientSize Size;
	var() NodeCoronaLinkGradientGlow Glow;
	var() NodeCoronaLinkGradientScale Scale;
	var() NodeCoronaLinkGradientColor Color;
	var() NodeCoronaLinkGradientSaturation Saturation;
};

struct NodeCoronaLink
{
	var() float Density;
	var() ECoronaLinkAlignment Alignment;
	var() NodeCoronaLinkGradient Gradient;
};

struct NodeCorona
{
	var() NodeCoronaTexture Texture;
	var() float Size;
	var() float Glow;
	var() NodeCoronaScale Scale;
	var() NodeCoronaColor Color;
	var() byte Saturation;
	var() NodeCoronaLink Link;
};

struct NodeLensflareMultiplier
{
	var() bool bInvert;
	var() ELensflareMultiplierMode Mode;
};

struct NodeLensflarePositionDistribution
{
	var() byte Seed;
	var() byte Count;
	var() ELensflarePositionDistributionMode Mode;
};

struct NodeLensflarePosition
{
	var() float Value;
	var() ELensflarePositionAxis Axis;
	var() ELensflarePositionMode Mode;
	var() NodeLensflarePositionDistribution Distribution;
};

struct NodeLensflareGlowMultiplier
{
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareGlow
{
	var() float Value;
	var() NodeLensflareGlowMultiplier Multiplier;
};

struct NodeLensflareTextureRender
{
	var() bool bMirrorU;
	var() bool bMirrorV;
	var() bool bSmooth;
	var() ERenderTextureMode Mode;
};

struct NodeLensflareTexture
{
	var() ELensflareTextureMode Mode;
	var() NodeLensflareTextureRender Render;
	var() Texture Value;
};

struct NodeLensflareColorMultiplier
{
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareColorRandomHSBValue
{
	var() byte Hue;
	var() byte Saturation;
	var() byte Brightness;
};

struct NodeLensflareColorRandomHSB
{
	var() NodeLensflareColorRandomHSBValue Min;
	var() NodeLensflareColorRandomHSBValue Max;
};

struct NodeLensflareColorRandom
{
	var() ELensflareColorRandomMode Mode;
	var() byte Seed;
	var() NodeLensflareColorRandomHSB HSB;
};

struct NodeLensflareColor
{
	var() ELensflareColorMode Mode;
	var() color Min;
	var() color Max;
	var() NodeLensflareColorMultiplier Multiplier;
	var() NodeLensflareColorRandom Random;
};

struct NodeLensflareSizeMultiplier
{
	var() NodeLensflareMultiplier Opacity;
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareSizeRandom
{
	var() bool bEnabled;
	var() byte Seed;
};

struct NodeLensflareSize
{
	var() ELensflareSizeMode Mode;
	var() float Min;
	var() float Max;
	var() NodeLensflareSizeMultiplier Multiplier;
	var() NodeLensflareSizeRandom Random;
};

struct NodeLensflareScaleMultiplier
{
	var() NodeLensflareMultiplier Opacity;
	var() NodeLensflareMultiplier Position;
};

struct NodeLensflareScaleRandom
{
	var() bool bEnabled;
	var() byte Seed;
};

struct NodeLensflareScale
{
	var() RenderScale2D Min;
	var() RenderScale2D Max;
	var() NodeLensflareScaleMultiplier Multiplier;
	var() NodeLensflareScaleRandom Random;
};

struct NodeLensflareDegree
{
	var() float Min;
	var() float Max;
	var() float FadeMin;
	var() float FadeMax;
};

struct NodeLensflareEntry
{
	var() NodeLensflareGlow Glow;
	var() NodeLensflarePosition Position;
	var() NodeLensflareTexture Texture;
	var() NodeLensflareColor Color;
	var() NodeLensflareSize Size;
	var() NodeLensflareScale Scale;
	var() NodeLensflareDegree Degree;
};

struct NodeLensflare
{
	var() ELensflarePreset Presets[LENSFLARE_PRESETS_COUNT];
};

struct NodeLensflareCorona
{
	var color Color;
	var float Opacity;
	var float Distance;
	var RenderPoint2D Point;
	var RenderScale2D Scale;
	var Texture Texture;
	var NodeCoronaTextureRender Render;
};


//Editable properties (controller)
var(Controller) NodeCorona Corona;
var(Controller) NodeLensflare Lensflare;


//Editable properties (presets)
var(Presets) NodeLensflareEntry LensflarePresetAnamorphic[LENSFLARE_PRESET_ANAMORPHIC_ENTRIES_COUNT];
var(Presets) NodeLensflareEntry LensflarePresetBright;
var(Presets) NodeLensflareEntry LensflarePresetGlare[LENSFLARE_PRESET_GLARE_ENTRIES_COUNT];
var(Presets) NodeLensflareEntry LensflarePresetGlareSpectral[LENSFLARE_PRESET_GLARE_ENTRIES_COUNT];
var(Presets) NodeLensflareEntry LensflarePresetGlow;
var(Presets) NodeLensflareEntry LensflarePresetRing;
var(Presets) NodeLensflareEntry LensflarePresetSpectral;
var(Presets) NodeLensflareEntry LensflarePresetSun[LENSFLARE_ENTRIES_COUNT];
var(Presets) NodeLensflareEntry LensflarePresetCustom[LENSFLARE_ENTRIES_COUNT];


//Private properties
var private byte LensflareEntriesCount;
var private NodeLensflareEntry LensflareEntry00;
var private NodeLensflareEntry LensflareEntry01;
var private NodeLensflareEntry LensflareEntry02;
var private NodeLensflareEntry LensflareEntry03;
var private NodeLensflareEntry LensflareEntry04;
var private NodeLensflareEntry LensflareEntry05;
var private NodeLensflareEntry LensflareEntry06;
var private NodeLensflareEntry LensflareEntry07;
var private NodeLensflareEntry LensflareEntry08;
var private NodeLensflareEntry LensflareEntry09;
var private NodeLensflareEntry LensflareEntry10;
var private NodeLensflareEntry LensflareEntry11;
var private NodeLensflareEntry LensflareEntry12;
var private NodeLensflareEntry LensflareEntry13;
var private NodeLensflareEntry LensflareEntry14;
var private NodeLensflareEntry LensflareEntry15;
var private NodeLensflareEntry LensflareEntries[LENSFLARE_ENTRIES_COUNT];


replication
{
	reliable if (Role == ROLE_Authority)
		Corona, LensflareEntriesCount, LensflareEntry00, LensflareEntry01, LensflareEntry02, LensflareEntry03,
		LensflareEntry04, LensflareEntry05, LensflareEntry06, LensflareEntry07, LensflareEntry08, LensflareEntry09,
		LensflareEntry10, LensflareEntry11, LensflareEntry12, LensflareEntry13, LensflareEntry14, LensflareEntry15;
}


//Implemented events
event initialize()
{
	//local
	local byte n, i, j, limit, offset, count;
	
	//corona
	Corona.Size = fmax(Corona.Size, 0.0);
	Corona.Glow = fclamp(Corona.Glow, 0.0, 1.0);
	Corona.Link.Density = fmax(Corona.Link.Density, 0.0);
	Corona.Link.Gradient.Size.Value1 = fmax(Corona.Link.Gradient.Size.Value1, 0.0);
	Corona.Link.Gradient.Size.Value2 = fmax(Corona.Link.Gradient.Size.Value2, 0.0);
	Corona.Link.Gradient.Glow.Value1 = fclamp(Corona.Link.Gradient.Glow.Value1, 0.0, 1.0);
	Corona.Link.Gradient.Glow.Value2 = fclamp(Corona.Link.Gradient.Glow.Value2, 0.0, 1.0);
	
	//lensflares
	for (n = 0; n < LENSFLARE_PRESETS_COUNT; n++) {
		//check
		if (Lensflare.Presets[n] == LP_None) {
			continue;
		}
		
		//limit and offset
		switch (Lensflare.Presets[n]) {
			case LP_Anamorphic:
				limit = LENSFLARE_PRESET_ANAMORPHIC_ENTRIES_COUNT;
				break;
			case LP_AnamorphicU:
				limit = 1;
				break;
			case LP_AnamorphicV:
				limit = 1;
				offset = 1;
				break;
			case LP_Bright:
				limit = 1;
				break;
			case LP_Glare:
			case LP_GlareSpectral:
				limit = LENSFLARE_PRESET_GLARE_ENTRIES_COUNT;
				break;
			case LP_GlareU:
			case LP_GlareSpectralU:
				limit = 2;
				break;
			case LP_GlareV:
			case LP_GlareSpectralV:
				limit = 2;
				offset = 2;
				break;
			case LP_Glow:
			case LP_Ring:
			case LP_Spectral:
				limit = 1;
				break;
			case LP_SunSpectral:
				limit = LENSFLARE_PRESET_SUN_SPECTRAL_ENTRIES_COUNT;
				break;
			case LP_SunAnamorphic:
				limit = LENSFLARE_PRESET_SUN_ANAMORPHIC_ENTRIES_COUNT;
				break;
			case LP_SunGlow:
				limit = LENSFLARE_PRESET_SUN_LITE_ENTRIES_COUNT;
				break;
			default:
				limit = LENSFLARE_ENTRIES_COUNT;
				break;
		}
		
		//prepare
		count = limit + offset;
		for (i = offset; i < count; i++) {
			//check
			if (j >= LENSFLARE_ENTRIES_COUNT) {
				break;
			}
			
			//set
			switch (Lensflare.Presets[n]) {
				case LP_Anamorphic:
				case LP_AnamorphicU:
				case LP_AnamorphicV:
					LensflareEntries[j] = LensflarePresetAnamorphic[i];
					break;
				case LP_Bright:
					LensflareEntries[j] = LensflarePresetBright;
					break;
				case LP_Glare:
				case LP_GlareU:
				case LP_GlareV:
					LensflareEntries[j] = LensflarePresetGlare[i];
					break;
				case LP_GlareSpectral:
				case LP_GlareSpectralU:
				case LP_GlareSpectralV:
					LensflareEntries[j] = LensflarePresetGlareSpectral[i];
					break;
				case LP_Glow:
					LensflareEntries[j] = LensflarePresetGlow;
					break;
				case LP_Ring:
					LensflareEntries[j] = LensflarePresetRing;
					break;
				case LP_Spectral:
					LensflareEntries[j] = LensflarePresetSpectral;
					break;
				case LP_Sun:
				case LP_SunSpectral:
				case LP_SunAnamorphic:
				case LP_SunGlow:
					LensflareEntries[j] = LensflarePresetSun[i];
					break;
				default:
					LensflareEntries[j] = LensflarePresetCustom[i];
					break;
			}
			
			//check (entry)
			if (
				(LensflareEntries[j].Texture.Mode == LTM_Value && LensflareEntries[j].Texture.Value == none) || 
				LensflareEntries[j].Glow.Value <= 0.0
			) {
				continue;
			}
			
			//initialize
			LensflareEntries[j].Glow.Value = fclamp(LensflareEntries[j].Glow.Value, 0.0, 1.0);
			LensflareEntries[j].Position.Value = fclamp(LensflareEntries[j].Position.Value, -1.0, 1.0);
			LensflareEntries[j].Size.Min = fmax(LensflareEntries[j].Size.Min, 0.0);
			LensflareEntries[j].Size.Max = fmax(LensflareEntries[j].Size.Max, 0.0);
			LensflareEntries[j].Degree.Min = fclamp(LensflareEntries[j].Degree.Min, 0.0, 1.0);
			LensflareEntries[j].Degree.Max = fclamp(LensflareEntries[j].Degree.Max, 0.0, 1.0);
			LensflareEntries[j].Degree.FadeMin = fclamp(LensflareEntries[j].Degree.FadeMin, 0.0, 1.0);
			LensflareEntries[j].Degree.FadeMax = fclamp(LensflareEntries[j].Degree.FadeMax, 0.0, 1.0);
			
			//next
			j++;
		}
		
		//count
		LensflareEntriesCount = j;
		
		//replicate
		LensflareEntry00 = LensflareEntries[0];
		LensflareEntry01 = LensflareEntries[1];
		LensflareEntry02 = LensflareEntries[2];
		LensflareEntry03 = LensflareEntries[3];
		LensflareEntry04 = LensflareEntries[4];
		LensflareEntry05 = LensflareEntries[5];
		LensflareEntry06 = LensflareEntries[6];
		LensflareEntry07 = LensflareEntries[7];
		LensflareEntry08 = LensflareEntries[8];
		LensflareEntry09 = LensflareEntries[9];
		LensflareEntry10 = LensflareEntries[10];
		LensflareEntry11 = LensflareEntries[11];
		LensflareEntry12 = LensflareEntries[12];
		LensflareEntry13 = LensflareEntries[13];
		LensflareEntry14 = LensflareEntries[14];
		LensflareEntry15 = LensflareEntries[15];
	}
}


//Implemented simulated events
simulated event C21FX_Node createNode(Actor actor)
{
	return new class'C21FX_CoronaNode';
}

simulated event initializeNodesRender(RenderFrame frame)
{
	//canvas
	frame.Canvas.Style = ERenderStyle.STY_Translucent;
	
	//lensflares
	if (LensflareEntriesCount > 0) {
		LensflareEntries[0] = LensflareEntry00;
		LensflareEntries[1] = LensflareEntry01;
		LensflareEntries[2] = LensflareEntry02;
		LensflareEntries[3] = LensflareEntry03;
		LensflareEntries[4] = LensflareEntry04;
		LensflareEntries[5] = LensflareEntry05;
		LensflareEntries[6] = LensflareEntry06;
		LensflareEntries[7] = LensflareEntry07;
		LensflareEntries[8] = LensflareEntry08;
		LensflareEntries[9] = LensflareEntry09;
		LensflareEntries[10] = LensflareEntry10;
		LensflareEntries[11] = LensflareEntry11;
		LensflareEntries[12] = LensflareEntry12;
		LensflareEntries[13] = LensflareEntry13;
		LensflareEntries[14] = LensflareEntry14;
		LensflareEntries[15] = LensflareEntry15;
	}
}

simulated event renderNode(C21FX_Node node, RenderFrame frame)
{
	renderCoronaNode(C21FX_CoronaNode(node), frame);
}

simulated event C21FX_Link createLink(C21FX_Point point1, C21FX_Point point2)
{
	return new class'C21FX_CoronaLink';
}

simulated event renderLink(C21FX_Link link, RenderFrame frame)
{
	renderCoronaLink(C21FX_CoronaLink(link), frame);
}


//Final simulated functions
final simulated function renderCoronaNode(C21FX_CoronaNode node, RenderFrame frame)
{
	//local
	local bool visible;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local ERenderPoint2DVisibility pointVisibility;
	local ECoronaScaleMode scaleMode;
	local ECoronaColorMode colorMode;
	local float fscale, opacity, gSize;
	local byte saturation;
	local color c, color;
	local NodeLensflareCorona lCorona;
	
	//check
	if (
		node == none || Corona.Texture.Value == none || Corona.Size <= 0.0 || Corona.Scale.Value.U <= 0.0 || 
		Corona.Scale.Value.V <= 0.0 || Corona.Glow <= 0.0
	) {
		return;
	}
	
	//visibility
	visible = isNodeVisible(node, frame, point);
	if (!visible) {
		point = locationToRenderPoint2D(node.Location, frame, pointVisibility);
		if (pointVisibility != RP2DV_Visible) {
			return;
		}
	}
	
	//opacity
	if (visible && node.Opacity < 1.0) {
		node.Opacity = fmin(node.Opacity + frame.Delta / CORONA_VISIBILITY_FADE_TIME, 1.0);
	} else if (!visible) {
		//reduce
		if (node.Opacity > 0.0) {
			node.Opacity = fmax(node.Opacity - frame.Delta / CORONA_VISIBILITY_FADE_TIME, 0.0);
		}
		
		//check
		if (node.Opacity == 0.0) {
			return;
		}
	}
	
	//scale mode
	scaleMode = Corona.Scale.Mode;
	if (scaleMode == CSM_Auto) {
		if (node.bLinked) {
			scaleMode = CSM_World;
		} else {
			scaleMode = CSM_Fixed;
		}
	}
	
	//scale
	if (scaleMode == CSM_Fixed || scaleMode == CSM_Distance) {
		//scale
		fscale = fmin(frame.Canvas.ClipX - frame.Canvas.OrgX, frame.Canvas.ClipY - frame.Canvas.OrgY) * 
			CORONA_SCALE_FIXED / float(max(Corona.Texture.Value.USize, Corona.Texture.Value.VSize));
		
		//distance
		if (scaleMode == CSM_Distance && Visibility.ViewDistance > 0.0) {
			fscale *= 1.0 - (node.Distance / Visibility.ViewDistance);
		}
		
		//finalize
		scale.U = fscale;
		scale.V = fscale;
		
	} else if (scaleMode == CSM_World) {
		scale = locationToRenderScale2D(node.Location, frame);
	}
	scale.U *= Corona.Scale.Value.U * Corona.Size;
	scale.V *= Corona.Scale.Value.V * Corona.Size;
	
	//gradient (size)
	if (node.bLinked && Corona.Link.Gradient.Size.Mode != CLGM_None) {
		if (Corona.Link.Gradient.Size.Mode == CLGM_NonLinear) {
			gSize = smerp(node.Position, Corona.Link.Gradient.Size.Value1, Corona.Link.Gradient.Size.Value2);
		} else {
			gSize = lerp(node.Position, Corona.Link.Gradient.Size.Value1, Corona.Link.Gradient.Size.Value2);
		}
		scale.U *= gSize;
		scale.V *= gSize;
	}
	
	//gradient (scale)
	if (node.bLinked && Corona.Link.Gradient.Scale.Mode != CLGM_None) {
		if (Corona.Link.Gradient.Scale.Mode == CLGM_NonLinear) {
			scale.U *= smerp(node.Position, Corona.Link.Gradient.Scale.Value1.U, Corona.Link.Gradient.Scale.Value2.U);
			scale.V *= smerp(node.Position, Corona.Link.Gradient.Scale.Value1.V, Corona.Link.Gradient.Scale.Value2.V);
		} else {
			scale.U *= lerp(node.Position, Corona.Link.Gradient.Scale.Value1.U, Corona.Link.Gradient.Scale.Value2.U);
			scale.V *= lerp(node.Position, Corona.Link.Gradient.Scale.Value1.V, Corona.Link.Gradient.Scale.Value2.V);
		}
	}
	
	//scale (check)
	if (scale.U <= 0.0 || scale.V <= 0.0) {
		return;
	}
	
	//opacity
	opacity = frame.Opacity * node.Opacity * Corona.Glow;
	
	//gradient (glow)
	if (node.bLinked && Corona.Link.Gradient.Glow.Mode != CLGM_None) {
		if (Corona.Link.Gradient.Glow.Mode == CLGM_NonLinear) {
			opacity *= smerp(node.Position, Corona.Link.Gradient.Glow.Value1, Corona.Link.Gradient.Glow.Value2);
		} else {
			opacity *= lerp(node.Position, Corona.Link.Gradient.Glow.Value1, Corona.Link.Gradient.Glow.Value2);
		}
	}
	
	//opacity (check)
	if (opacity <= 0.0) {
		return;
	}
	
	//color mode
	colorMode = Corona.Color.Mode;
	if (colorMode == CCM_Auto) {
		if (Light(node.Actor) != none) {
			colorMode = CCM_Light;
		} else {
			colorMode = CCM_Value;
		}
	}
	
	//color
	if (colorMode == CCM_Value) {
		if (node.bLinked && Corona.Link.Gradient.Color.Mode != CLGM_None) {
			if (Corona.Link.Gradient.Color.Mode == CLGM_NonLinear) {
				color.R = byte(
					smerp(node.Position, Corona.Link.Gradient.Color.Value1.R, Corona.Link.Gradient.Color.Value2.R)
				);
				color.G = byte(
					smerp(node.Position, Corona.Link.Gradient.Color.Value1.G, Corona.Link.Gradient.Color.Value2.G)
				);
				color.B = byte(
					smerp(node.Position, Corona.Link.Gradient.Color.Value1.B, Corona.Link.Gradient.Color.Value2.B)
				);
			} else {
				color.R = byte(
					lerp(node.Position, Corona.Link.Gradient.Color.Value1.R, Corona.Link.Gradient.Color.Value2.R)
				);
				color.G = byte(
					lerp(node.Position, Corona.Link.Gradient.Color.Value1.G, Corona.Link.Gradient.Color.Value2.G)
				);
				color.B = byte(
					lerp(node.Position, Corona.Link.Gradient.Color.Value1.B, Corona.Link.Gradient.Color.Value2.B)
				);
			}
		} else {
			color = Corona.Color.Value;
		}
	} else if (node.Actor != none) {
		if (colorMode == CCM_Light) {
			color = hsbToColor(node.Actor.LightHue, node.Actor.LightSaturation, node.Actor.LightBrightness);
		} else if (colorMode == CCM_LightHS) {
			color = hsbToColor(node.Actor.LightHue, node.Actor.LightSaturation, 255);
		} else if (colorMode == CCM_LightHue) {
			if (node.bLinked && Corona.Link.Gradient.Saturation.Mode != CLGM_None) {
				if (Corona.Link.Gradient.Saturation.Mode == CLGM_NonLinear) {
					saturation = byte(smerp(
						node.Position, Corona.Link.Gradient.Saturation.Value1, Corona.Link.Gradient.Saturation.Value2
					));
				} else {
					saturation = byte(lerp(
						node.Position, Corona.Link.Gradient.Saturation.Value1, Corona.Link.Gradient.Saturation.Value2
					));
				}
			} else {
				saturation = Corona.Saturation;
			}
			color = hsbToColor(node.Actor.LightHue, saturation, 255);
		}
	}
	c.R = byte(float(color.R) * opacity);
	c.G = byte(float(color.G) * opacity);
	c.B = byte(float(color.B) * opacity);
	
	//color (check)
	if (c.R == 0 && c.G == 0 && c.B == 0) {
		return;
	}
	
	//draw
	setRenderFrameNearestZ(frame, node.Distance);
	drawSprite(
		frame, Corona.Texture.Value, c, point, scale, true, true, Corona.Texture.Render.Mode,
		Corona.Texture.Render.bMirrorU, Corona.Texture.Render.bMirrorV, Corona.Texture.Render.bSmooth
	);
	
	//lensflares
	if (LensflareEntriesCount > 0) {
		lCorona.Color = color;
		lCorona.Opacity = opacity;
		lCorona.Distance = node.Distance;
		lCorona.Point = point;
		lCorona.Scale = scale;
		lCorona.Texture = Corona.Texture.Value;
		lCorona.Render = Corona.Texture.Render;
		drawLensflares(lCorona, frame);
	}
}

final simulated function drawLensflares(NodeLensflareCorona corona, RenderFrame frame)
{
	//local
	local int seed, colorSeed, sizeSeed, scaleSeed;
	local byte i, j, count;
	local RenderPoint2D point;
	local RenderScale2D scale;
	local float degree, position, absPosition, opacity, alpha, size, sAlpha, cAlpha, f;
	local color colorMin, colorMax, c;
	local vector v, vector, pointVector;
	local NodeLensflareEntry entry;
	local Texture texture;
	local ERenderTextureMode renderMode;
	local bool bRenderMirrorU, bRenderMirrorV;
	
	//check
	if (LensflareEntriesCount == 0) {
		return;
	}
	
	//vector
	v.X = lerp(0.5, frame.Canvas.OrgX, frame.Canvas.ClipX) - corona.Point.X;
	v.Y = lerp(0.5, frame.Canvas.OrgY, frame.Canvas.ClipY) - corona.Point.Y;
	v *= 2.0;
	
	//degree
	degree = fmax(
		abs(v.X / (frame.Canvas.ClipX - frame.Canvas.OrgX)),
		abs(v.Y / (frame.Canvas.ClipY - frame.Canvas.OrgY))
	);
	
	//z
	setRenderFrameNearestZ(frame, corona.Distance);
	
	//entries
	for (i = 0; i < LensflareEntriesCount; i++) {
		//entry
		entry = LensflareEntries[i];
		
		//texture
		if (entry.Texture.Mode == LTM_Same) {
			texture = corona.Texture;
			renderMode = corona.Render.Mode;
			bRenderMirrorU = corona.Render.bMirrorU;
			bRenderMirrorV = corona.Render.bMirrorV;
		} else {
			texture = entry.Texture.Value;
			renderMode = entry.Texture.Render.Mode;
			bRenderMirrorU = entry.Texture.Render.bMirrorU;
			bRenderMirrorV = entry.Texture.Render.bMirrorV;
		}
		
		//vector
		vector = v;
		switch (entry.Position.Axis) {
			case LPA_X:
				vector.Y = 0.0;
				break;
			case LPA_Y:
				vector.X = 0.0;
				break;
		}
		
		//check
		if (texture == none || entry.Glow.Value <= 0.0 || degree < entry.Degree.Min || degree > entry.Degree.Max) {
			continue;
		}
		
		//seeds and count
		sizeSeed = iseed(entry.Size.Random.Seed);
		scaleSeed = iseed(entry.Scale.Random.Seed);
		colorSeed = iseed(entry.Color.Random.Seed);
		if (entry.Position.Mode == LPM_Distributed) {
			seed = iseed(entry.Position.Distribution.Seed);
			count = entry.Position.Distribution.Count;
		} else {
			count = 1;
		}
		
		//iterate
		for (j = 0; j < count; j++) {
			//position
			if (entry.Position.Mode == LPM_Distributed) {
				position = frandom(seed);
				switch (entry.Position.Distribution.Mode) {
					case LPDM_Back:
						position = -position;
						break;
					case LPDM_Both:
						position = position * 2.0 - 1.0;
						break;
				}
			} else {
				position = entry.Position.Value;
			}
			absPosition = abs(position);
			
			//opacity
			opacity = corona.Opacity * entry.Glow.Value;
			if (degree < entry.Degree.FadeMin && entry.Degree.FadeMin > entry.Degree.Min) {
				opacity *= (degree - entry.Degree.Min) / (entry.Degree.FadeMin - entry.Degree.Min);
			} else if (degree > entry.Degree.FadeMax && entry.Degree.FadeMax < entry.Degree.Max) {
				opacity *= 1.0 - (degree - entry.Degree.FadeMax) / (entry.Degree.Max - entry.Degree.FadeMax);
			}
			
			//opacity (multiplier)
			if (entry.Glow.Multiplier.Position.Mode != LMM_None) {
				opacity *= lensflareMultiplierAlpha(absPosition, entry.Glow.Multiplier.Position);
			}
			
			//opacity (check)
			if (opacity <= 0.0) {
				continue;
			}
			
			//alpha
			alpha = (degree - entry.Degree.Min) / (entry.Degree.Max - entry.Degree.Min);
			
			//size (alpha)
			if (entry.Size.Random.bEnabled) {
				sAlpha = frandom(sizeSeed);
			} else {
				sAlpha = alpha;
			}
			
			//size (multiplier)
			if (entry.Size.Multiplier.Opacity.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(opacity, entry.Size.Multiplier.Opacity);
			}
			if (entry.Size.Multiplier.Position.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(absPosition, entry.Size.Multiplier.Position);
			}
			
			//size
			size = lerp(sAlpha, entry.Size.Min, entry.Size.Max);
			
			//size (check)
			if (size <= 0.0) {
				continue;
			}
			
			//scale (alpha)
			if (entry.Scale.Random.bEnabled) {
				sAlpha = frandom(scaleSeed);
			} else {
				sAlpha = alpha;
			}
			
			//scale (multiplier)
			if (entry.Scale.Multiplier.Opacity.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(opacity, entry.Scale.Multiplier.Opacity);
			}
			if (entry.Scale.Multiplier.Position.Mode != LMM_None) {
				sAlpha *= lensflareMultiplierAlpha(absPosition, entry.Scale.Multiplier.Position);
			}
			
			//scale (set)
			scale.U = size * lerp(sAlpha, entry.Scale.Min.U, entry.Scale.Max.U);
			scale.V = size * lerp(sAlpha, entry.Scale.Min.V, entry.Scale.Max.V);
			switch (entry.Size.Mode) {
				case LSM_Fixed:
					size = fmin(frame.Canvas.ClipX - frame.Canvas.OrgX, frame.Canvas.ClipY - frame.Canvas.OrgY) * 
						LENSFLARE_SIZE_FIXED / float(max(entry.Texture.Value.USize, entry.Texture.Value.VSize));
					scale.U *= size;
					scale.V *= size;
					break;
				case LSM_Relative:
					scale.U *= corona.Scale.U;
					scale.V *= corona.Scale.V;
					break;
			}
			
			//scale (check)
			if (scale.U <= 0.0 || scale.V <= 0.0) {
				continue;
			}
			
			//color
			if (entry.Color.Random.Mode != LCRM_None && entry.Color.Mode != LCM_Same) {
				switch (entry.Color.Random.Mode) {
					case LCRM_HSB:
						colorMin = hsbToColor(
							lerp(
								frandom(colorSeed),
								entry.Color.Random.HSB.Min.Hue,
								entry.Color.Random.HSB.Max.Hue
							),
							lerp(
								frandom(colorSeed),
								entry.Color.Random.HSB.Min.Saturation,
								entry.Color.Random.HSB.Max.Saturation
							),
							lerp(
								frandom(colorSeed),
								entry.Color.Random.HSB.Min.Brightness,
								entry.Color.Random.HSB.Max.Brightness
							)
						);
						break;
					case LCRM_RGB:
						colorMin.R = lerp(frandom(colorSeed), entry.Color.Min.R, entry.Color.Max.R);
						colorMin.G = lerp(frandom(colorSeed), entry.Color.Min.G, entry.Color.Max.G);
						colorMin.B = lerp(frandom(colorSeed), entry.Color.Min.B, entry.Color.Max.B);
						break;
				}
				colorMax = colorMin;
			} else {
				colorMin = entry.Color.Min;
				colorMax = entry.Color.Max;
			}
			
			//color (mode)
			switch (entry.Color.Mode) {
				case LCM_Same:
					colorMin = corona.Color;
					colorMax = corona.Color;
					break;
				case LCM_Add:
					colorMin.R = byte(min(int(corona.Color.R) + int(colorMin.R), 255));
					colorMin.G = byte(min(int(corona.Color.G) + int(colorMin.G), 255));
					colorMin.B = byte(min(int(corona.Color.B) + int(colorMin.B), 255));
					colorMax.R = byte(min(int(corona.Color.R) + int(colorMax.R), 255));
					colorMax.G = byte(min(int(corona.Color.G) + int(colorMax.G), 255));
					colorMax.B = byte(min(int(corona.Color.B) + int(colorMax.B), 255));
					break;
				case LCM_Subtract:
					colorMin.R = byte(max(int(corona.Color.R) - int(colorMin.R), 0));
					colorMin.G = byte(max(int(corona.Color.G) - int(colorMin.G), 0));
					colorMin.B = byte(max(int(corona.Color.B) - int(colorMin.B), 0));
					colorMax.R = byte(max(int(corona.Color.R) - int(colorMax.R), 0));
					colorMax.G = byte(max(int(corona.Color.G) - int(colorMax.G), 0));
					colorMax.B = byte(max(int(corona.Color.B) - int(colorMax.B), 0));
					break;
				case LCM_Multiply:
					f = 1.0 / 255.0;
					colorMin.R = byte(fmin(float(corona.Color.R) * float(colorMin.R) * f, 255.0));
					colorMin.G = byte(fmin(float(corona.Color.G) * float(colorMin.G) * f, 255.0));
					colorMin.B = byte(fmin(float(corona.Color.B) * float(colorMin.B) * f, 255.0));
					colorMax.R = byte(fmin(float(corona.Color.R) * float(colorMax.R) * f, 255.0));
					colorMax.G = byte(fmin(float(corona.Color.G) * float(colorMax.G) * f, 255.0));
					colorMax.B = byte(fmin(float(corona.Color.B) * float(colorMax.B) * f, 255.0));
					break;
				case LCM_Intersect:
					colorMin.R = byte(int(corona.Color.R) & int(colorMin.R));
					colorMin.G = byte(int(corona.Color.G) & int(colorMin.G));
					colorMin.B = byte(int(corona.Color.B) & int(colorMin.B));
					colorMax.R = byte(int(corona.Color.R) & int(colorMax.R));
					colorMax.G = byte(int(corona.Color.G) & int(colorMax.G));
					colorMax.B = byte(int(corona.Color.B) & int(colorMax.B));
					break;
				case LCM_Merge:
					colorMin.R = byte(int(corona.Color.R) | int(colorMin.R));
					colorMin.G = byte(int(corona.Color.G) | int(colorMin.G));
					colorMin.B = byte(int(corona.Color.B) | int(colorMin.B));
					colorMax.R = byte(int(corona.Color.R) | int(colorMax.R));
					colorMax.G = byte(int(corona.Color.G) | int(colorMax.G));
					colorMax.B = byte(int(corona.Color.B) | int(colorMax.B));
					break;
				case LCM_Exclude:
					colorMin.R = byte(int(corona.Color.R) ^ int(colorMin.R));
					colorMin.G = byte(int(corona.Color.G) ^ int(colorMin.G));
					colorMin.B = byte(int(corona.Color.B) ^ int(colorMin.B));
					colorMax.R = byte(int(corona.Color.R) ^ int(colorMax.R));
					colorMax.G = byte(int(corona.Color.G) ^ int(colorMax.G));
					colorMax.B = byte(int(corona.Color.B) ^ int(colorMax.B));
					break;
			}
			
			//color (alpha)
			cAlpha = alpha;
			if (entry.Color.Multiplier.Position.Mode != LMM_None) {
				cAlpha *= lensflareMultiplierAlpha(absPosition, entry.Color.Multiplier.Position);
			}
			
			//color (set)
			c.R = byte(lerp(cAlpha, colorMin.R, colorMax.R) * opacity);
			c.G = byte(lerp(cAlpha, colorMin.G, colorMax.G) * opacity);
			c.B = byte(lerp(cAlpha, colorMin.B, colorMax.B) * opacity);
			
			//color (check)
			if (c.R == 0 && c.G == 0 && c.B == 0) {
				continue;
			}
			
			//point
			pointVector = vector * position;
			point.X = corona.Point.X + pointVector.X;
			point.Y = corona.Point.Y + pointVector.Y;
			
			//mirror
			if (entry.Texture.Mode != LTM_Same) {
				if (vector.X < 0.0) {
					bRenderMirrorU = !bRenderMirrorU;
				}
				if (vector.Y < 0.0) {
					bRenderMirrorV = !bRenderMirrorV;
				}
			}
			
			//draw
			drawSprite(
				frame, texture, c, point, scale, true, true, renderMode, bRenderMirrorU, bRenderMirrorV,
				entry.Texture.Render.bSmooth
			);
		}
	}
}

final simulated function renderCoronaLink(C21FX_CoronaLink link, RenderFrame frame)
{
	//local
	local vector vector;
	local float distance, fcount, position, unit;
	local int count, i, imax;
	local C21FX_CoronaNode node;
	
	//check
	if (
		link == none || link.Point1 == none || link.Point2 == none || Corona.Texture.Value == none || 
		Corona.Link.Density <= 0.0
	) {
		return;
	}
	
	//initialize
	vector = link.Point2.Location - link.Point1.Location;
	distance = vsize(vector);
	fcount = distance / fmax(Corona.Texture.Value.USize, Corona.Texture.Value.VSize) * Corona.Link.Density;
	count = int(fcount);
	
	//check (count)
	if (count == 0) {
		return;
	}
	
	//nodes
	if (
		link.RootNode == none || link.Point1.Location != link.Point1.OldLocation || 
		link.Point2.Location != link.Point2.OldLocation
	) {
		//imax
		imax = count - 1;
		if (Corona.Link.Alignment == CLA_Middle && (imax % 2) == 0) {
			if (imax == 0) {
				return;
			}
			imax--;
		}
		
		//setup
		node = link.RootNode;
		for (i = 0; i <= imax; i++) {
			if (node == none) {
				link.RootNode = C21FX_CoronaNode(generateNode(link.RootNode, link.Point1));
				link.RootNode.bLinked = true;
			} else {
				node.bEnd = i == imax || node.NextNode == none;
				node = C21FX_CoronaNode(node.NextNode);
			}
		}
		
		//position
		unit = 1.0 / (fcount - 1.0);
		if (Corona.Link.Alignment > CLA_Start) {
			position = 1.0 - unit * float(imax);
			if (Corona.Link.Alignment == CLA_Center || Corona.Link.Alignment == CLA_Middle) {
				position *= 0.5;
			}
		}
		
		//locations
		for (node = link.RootNode; node != none; node = C21FX_CoronaNode(node.NextNode)) {
			//set
			node.Position = position;
			node.Location = link.Point1.Location + position * vector;
			position = fmin(position + unit, 1.0);
			
			//finalize
			if (node.bEnd) {
				break;
			}
		}
	}
	
	//draw
	drawNodes(link.RootNode, frame);
}


//Final static functions
final static function float lensflareMultiplierAlpha(float alpha, NodeLensflareMultiplier multiplier)
{
	if (multiplier.Mode == LMM_NonLinear) {
		if (multiplier.bInvert) {
			alpha = smerp(alpha, 1.0, 0.0);
		} else {
			alpha = smerp(alpha, 0.0, 1.0);
		}
	} else if (multiplier.bInvert) {
		alpha = 1.0 - alpha;
	}
	return alpha;
}



defaultproperties
{
	//editables (controller - corona)
	Corona=(Texture=(Value=Texture'Corona',Render=(bSmooth=true)),Size=1.0,Glow=1.0)
	Corona=(Scale=(Value=(U=1.0,V=1.0)))
	Corona=(Color=(Value=(R=255,G=255,B=255)))
	Corona=(Link=(Density=1.0,Alignment=CLA_Center))
	Corona=(Link=(Gradient=(Size=(Value1=1.0,Value2=1.0))))
	Corona=(Link=(Gradient=(Glow=(Value1=1.0,Value2=1.0))))
	Corona=(Link=(Gradient=(Scale=(Value1=(U=1.0,V=1.0),Value2=(U=1.0,V=1.0)))))
	Corona=(Link=(Gradient=(Color=(Value1=(R=255,G=255,B=255),Value2=(R=255,G=255,B=255)))))
	
	//editables (presets - anamorphic lensflares)
	LensflarePresetAnamorphic(0)=(Glow=(Value=0.25))
	LensflarePresetAnamorphic(0)=(Position=(Distribution=(Count=1)))
	LensflarePresetAnamorphic(0)=(Texture=(Value=Texture'Lensflare05D',Render=(bSmooth=true,Mode=RTM_DualU)))
	LensflarePresetAnamorphic(0)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetAnamorphic(0)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetAnamorphic(0)=(Size=(Mode=LSM_Relative,Min=3.0,Max=3.0))
	LensflarePresetAnamorphic(0)=(Scale=(Min=(U=1.5,V=1.0),Max=(U=3.0,V=1.0)))
	LensflarePresetAnamorphic(0)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=0.9,Max=1.0))
	
	LensflarePresetAnamorphic(1)=(Glow=(Value=0.25))
	LensflarePresetAnamorphic(1)=(Position=(Distribution=(Count=1)))
	LensflarePresetAnamorphic(1)=(Texture=(Value=Texture'Lensflare06D',Render=(bSmooth=true,Mode=RTM_DualV)))
	LensflarePresetAnamorphic(1)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetAnamorphic(1)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetAnamorphic(1)=(Size=(Mode=LSM_Relative,Min=3.0,Max=3.0))
	LensflarePresetAnamorphic(1)=(Scale=(Min=(U=1.0,V=.75),Max=(U=1.0,V=1.5)))
	LensflarePresetAnamorphic(1)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=0.9,Max=1.0))
	
	//editables (presets - bright lensflare)
	LensflarePresetBright=(Glow=(Value=1.0))
	LensflarePresetBright=(Position=(Distribution=(Count=1)))
	LensflarePresetBright=(Texture=(Mode=LTM_Same,Render=(bSmooth=true)))
	LensflarePresetBright=(Color=(Mode=LCM_Value,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetBright=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetBright=(Size=(Mode=LSM_Relative,Min=0.65,Max=0.45))
	LensflarePresetBright=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetBright=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	//editables (presets - glare lensflares)
	LensflarePresetGlare(0)=(Glow=(Value=0.35))
	LensflarePresetGlare(0)=(Position=(Value=0.25,Axis=LPA_X,Distribution=(Count=1)))
	LensflarePresetGlare(0)=(Texture=(Value=Texture'Lensflare09D',Render=(bSmooth=true,Mode=RTM_DualV)))
	LensflarePresetGlare(0)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlare(0)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlare(0)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlare(0)=(Scale=(Min=(U=1.0,V=0.1),Max=(U=1.0,V=3.0)))
	LensflarePresetGlare(0)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	LensflarePresetGlare(1)=(Glow=(Value=0.35))
	LensflarePresetGlare(1)=(Position=(Value=-0.25,Axis=LPA_X,Distribution=(Count=1)))
	LensflarePresetGlare(1)=(Texture=(Value=Texture'Lensflare09D',Render=(bSmooth=true,Mode=RTM_DualV,bMirrorU=true)))
	LensflarePresetGlare(1)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlare(1)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlare(1)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlare(1)=(Scale=(Min=(U=1.0,V=0.1),Max=(U=1.0,V=3.0)))
	LensflarePresetGlare(1)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	LensflarePresetGlare(2)=(Glow=(Value=0.35))
	LensflarePresetGlare(2)=(Position=(Value=0.25,Axis=LPA_Y,Distribution=(Count=1)))
	LensflarePresetGlare(2)=(Texture=(Value=Texture'Lensflare10D',Render=(bSmooth=true,Mode=RTM_DualU)))
	LensflarePresetGlare(2)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlare(2)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlare(2)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlare(2)=(Scale=(Min=(U=0.1,V=1.0),Max=(U=3.0,V=1.0)))
	LensflarePresetGlare(2)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	LensflarePresetGlare(3)=(Glow=(Value=0.35))
	LensflarePresetGlare(3)=(Position=(Value=-0.25,Axis=LPA_Y,Distribution=(Count=1)))
	LensflarePresetGlare(3)=(Texture=(Value=Texture'Lensflare10D',Render=(bSmooth=true,Mode=RTM_DualU,bMirrorV=true)))
	LensflarePresetGlare(3)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlare(3)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlare(3)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlare(3)=(Scale=(Min=(U=0.1,V=1.0),Max=(U=3.0,V=1.0)))
	LensflarePresetGlare(3)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	//editables (presets - glare spectral lensflares)
	LensflarePresetGlareSpectral(0)=(Glow=(Value=0.35))
	LensflarePresetGlareSpectral(0)=(Position=(Value=0.25,Axis=LPA_X,Distribution=(Count=1)))
	LensflarePresetGlareSpectral(0)=(Texture=(Value=Texture'Lensflare11D',Render=(bSmooth=true,Mode=RTM_DualV)))
	LensflarePresetGlareSpectral(0)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlareSpectral(0)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlareSpectral(0)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlareSpectral(0)=(Scale=(Min=(U=1.0,V=0.1),Max=(U=1.0,V=3.0)))
	LensflarePresetGlareSpectral(0)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	LensflarePresetGlareSpectral(1)=(Glow=(Value=0.35))
	LensflarePresetGlareSpectral(1)=(Position=(Value=-0.25,Axis=LPA_X,Distribution=(Count=1)))
	LensflarePresetGlareSpectral(1)=(Texture=(Value=Texture'Lensflare11D',Render=(bSmooth=true,Mode=RTM_DualV,bMirrorU=true)))
	LensflarePresetGlareSpectral(1)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlareSpectral(1)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlareSpectral(1)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlareSpectral(1)=(Scale=(Min=(U=1.0,V=0.1),Max=(U=1.0,V=3.0)))
	LensflarePresetGlareSpectral(1)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	LensflarePresetGlareSpectral(2)=(Glow=(Value=0.35))
	LensflarePresetGlareSpectral(2)=(Position=(Value=0.25,Axis=LPA_Y,Distribution=(Count=1)))
	LensflarePresetGlareSpectral(2)=(Texture=(Value=Texture'Lensflare12D',Render=(bSmooth=true,Mode=RTM_DualU)))
	LensflarePresetGlareSpectral(2)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlareSpectral(2)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlareSpectral(2)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlareSpectral(2)=(Scale=(Min=(U=0.1,V=1.0),Max=(U=3.0,V=1.0)))
	LensflarePresetGlareSpectral(2)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	LensflarePresetGlareSpectral(3)=(Glow=(Value=0.35))
	LensflarePresetGlareSpectral(3)=(Position=(Value=-0.25,Axis=LPA_Y,Distribution=(Count=1)))
	LensflarePresetGlareSpectral(3)=(Texture=(Value=Texture'Lensflare12D',Render=(bSmooth=true,Mode=RTM_DualU,bMirrorV=true)))
	LensflarePresetGlareSpectral(3)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlareSpectral(3)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlareSpectral(3)=(Size=(Mode=LSM_Relative,Min=1.0,Max=3.0))
	LensflarePresetGlareSpectral(3)=(Scale=(Min=(U=0.1,V=1.0),Max=(U=3.0,V=1.0)))
	LensflarePresetGlareSpectral(3)=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	//editables (presets - glow lensflare)
	LensflarePresetGlow=(Glow=(Value=0.4))
	LensflarePresetGlow=(Position=(Distribution=(Count=1)))
	LensflarePresetGlow=(Texture=(Value=Texture'Lensflare03Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetGlow=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetGlow=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetGlow=(Size=(Mode=LSM_Relative,Min=4.0,Max=4.0))
	LensflarePresetGlow=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetGlow=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=0.75,Max=1.0))
	
	//editables (presets - ring lensflare)
	LensflarePresetRing=(Glow=(Value=0.35))
	LensflarePresetRing=(Position=(Value=0.0,Distribution=(Count=1)))
	LensflarePresetRing=(Texture=(Value=Texture'Lensflare07Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetRing=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetRing=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetRing=(Size=(Mode=LSM_Relative,Min=0.5,Max=4.0))
	LensflarePresetRing=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetRing=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	//editables (presets - spectral lensflare)
	LensflarePresetSpectral=(Glow=(Value=0.35))
	LensflarePresetSpectral=(Position=(Value=0.0,Distribution=(Count=1)))
	LensflarePresetSpectral=(Texture=(Value=Texture'Lensflare08Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSpectral=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSpectral=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSpectral=(Size=(Mode=LSM_Relative,Min=0.5,Max=4.0))
	LensflarePresetSpectral=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSpectral=(Degree=(Min=0.0,FadeMin=0.2,FadeMax=0.2,Max=1.0))
	
	//editables (presets - sun lensflares)
	LensflarePresetSun(0)=(Glow=(Value=1.0))
	LensflarePresetSun(0)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(0)=(Texture=(Mode=LTM_Same,Render=(bSmooth=true)))
	LensflarePresetSun(0)=(Color=(Mode=LCM_Value,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(0)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(0)=(Size=(Mode=LSM_Relative,Min=0.85,Max=0.65))
	LensflarePresetSun(0)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(0)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetSun(1)=(Glow=(Value=0.4))
	LensflarePresetSun(1)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(1)=(Texture=(Value=Texture'Lensflare03Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(1)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(1)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(1)=(Size=(Min=10.0,Max=20.0))
	LensflarePresetSun(1)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(1)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=0.75,Max=1.0))
	
	LensflarePresetSun(2)=(Glow=(Value=0.15))
	LensflarePresetSun(2)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(2)=(Texture=(Value=Texture'Lensflare05D',Render=(bSmooth=true,Mode=RTM_DualU)))
	LensflarePresetSun(2)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(2)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(2)=(Size=(Min=7.5,Max=10.0))
	LensflarePresetSun(2)=(Scale=(Min=(U=2.0,V=1.0),Max=(U=4.0,V=1.0)))
	LensflarePresetSun(2)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=0.85,Max=1.0))
	
	LensflarePresetSun(3)=(Glow=(Value=0.25))
	LensflarePresetSun(3)=(Position=(Value=0.2,Distribution=(Count=1)))
	LensflarePresetSun(3)=(Texture=(Value=Texture'Lensflare08Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(3)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(3)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(3)=(Size=(Min=1.0,Max=10.0))
	LensflarePresetSun(3)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(3)=(Degree=(Min=0.2,FadeMin=0.4,FadeMax=0.7,Max=1.0))
	
	LensflarePresetSun(4)=(Glow=(Value=0.2))
	LensflarePresetSun(4)=(Position=(Mode=LPM_Distributed,Distribution=(Seed=31,Count=5)))
	LensflarePresetSun(4)=(Texture=(Value=Texture'Lensflare00Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(4)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(4)=(Color=(Random=(Mode=LCRM_HSB,Seed=72,HSB=(Min=(Saturation=64,Brightness=64),Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(4)=(Size=(Min=0.1,Max=1.5,Random=(bEnabled=true,Seed=23)))
	LensflarePresetSun(4)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(4)=(Degree=(Min=0.0,FadeMin=0.3,FadeMax=0.8,Max=1.0))
	
	LensflarePresetSun(5)=(Glow=(Value=0.3))
	LensflarePresetSun(5)=(Position=(Mode=LPM_Distributed,Distribution=(Seed=78,Count=3)))
	LensflarePresetSun(5)=(Texture=(Value=Texture'Lensflare01Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(5)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(5)=(Color=(Random=(Mode=LCRM_HSB,Seed=61,HSB=(Min=(Saturation=64,Brightness=64),Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(5)=(Size=(Min=0.15,Max=1.0,Random=(bEnabled=true,Seed=98)))
	LensflarePresetSun(5)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(5)=(Degree=(Min=0.0,FadeMin=0.3,FadeMax=0.8,Max=1.0))
	
	LensflarePresetSun(6)=(Glow=(Value=0.55))
	LensflarePresetSun(6)=(Position=(Mode=LPM_Distributed,Distribution=(Seed=80,Count=7)))
	LensflarePresetSun(6)=(Texture=(Value=Texture'Lensflare02Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(6)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(6)=(Color=(Random=(Mode=LCRM_HSB,Seed=45,HSB=(Min=(Saturation=64,Brightness=64),Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(6)=(Size=(Min=0.1,Max=0.7,Random=(bEnabled=true,Seed=25))
	LensflarePresetSun(6)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(6)=(Degree=(Min=0.0,FadeMin=0.3,FadeMax=0.8,Max=1.0))
	
	LensflarePresetSun(7)=(Glow=(Value=0.9))
	LensflarePresetSun(7)=(Position=(Mode=LPM_Distributed,Distribution=(Seed=87,Count=18)))
	LensflarePresetSun(7)=(Texture=(Value=Texture'Lensflare04Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(7)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(7)=(Color=(Random=(Mode=LCRM_HSB,Seed=45,HSB=(Min=(Saturation=64,Brightness=64),Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(7)=(Size=(Min=0.075,Max=0.4,Random=(bEnabled=true,Seed=29))
	LensflarePresetSun(7)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(7)=(Degree=(Min=0.0,FadeMin=0.3,FadeMax=0.8,Max=1.0))
	
	LensflarePresetSun(8)=(Glow=(Value=0.9))
	LensflarePresetSun(8)=(Position=(Mode=LPM_Distributed,Distribution=(Seed=87,Count=18)))
	LensflarePresetSun(8)=(Texture=(Value=Texture'Lensflare04Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(8)=(Color=(Mode=LCM_Value,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(8)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(8)=(Size=(Min=0.03,Max=0.27,Random=(bEnabled=true,Seed=29))
	LensflarePresetSun(8)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(8)=(Degree=(Min=0.0,FadeMin=0.3,FadeMax=0.8,Max=1.0))
	
	LensflarePresetSun(9)=(Glow=(Value=0.2))
	LensflarePresetSun(9)=(Position=(Mode=LPM_Distributed,Distribution=(Seed=63,Count=5)))
	LensflarePresetSun(9)=(Texture=(Value=Texture'Lensflare01Q',Render=(bSmooth=true,Mode=RTM_Quad)))
	LensflarePresetSun(9)=(Color=(Mode=LCM_Multiply,Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(9)=(Color=(Random=(Mode=LCRM_HSB,Seed=131,HSB=(Min=(Saturation=0,Brightness=0),Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(9)=(Size=(Min=1.0,Max=4.0,Random=(bEnabled=true,Seed=146)))
	LensflarePresetSun(9)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(9)=(Degree=(Min=0.0,FadeMin=0.3,FadeMax=0.8,Max=1.0))
	
	LensflarePresetSun(10)=(Glow=(Value=1.0))
	LensflarePresetSun(10)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(10)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetSun(10)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(10)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(10)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetSun(10)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(10)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetSun(11)=(Glow=(Value=1.0))
	LensflarePresetSun(11)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(11)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetSun(11)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(11)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(11)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetSun(11)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(11)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetSun(12)=(Glow=(Value=1.0))
	LensflarePresetSun(12)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(12)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetSun(12)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(12)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(12)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetSun(12)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(12)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetSun(13)=(Glow=(Value=1.0))
	LensflarePresetSun(13)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(13)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetSun(13)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(13)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(13)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetSun(13)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(13)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetSun(14)=(Glow=(Value=1.0))
	LensflarePresetSun(14)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(14)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetSun(14)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(14)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(14)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetSun(14)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(14)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetSun(15)=(Glow=(Value=1.0))
	LensflarePresetSun(15)=(Position=(Distribution=(Count=1)))
	LensflarePresetSun(15)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetSun(15)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetSun(15)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetSun(15)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetSun(15)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetSun(15)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	//editables (presets - custom lensflares)
	LensflarePresetCustom(0)=(Glow=(Value=1.0))
	LensflarePresetCustom(0)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(0)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(0)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(0)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(0)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(0)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(0)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(1)=(Glow=(Value=1.0))
	LensflarePresetCustom(1)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(1)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(1)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(1)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(1)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(1)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(1)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(2)=(Glow=(Value=1.0))
	LensflarePresetCustom(2)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(2)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(2)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(2)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(2)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(2)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(2)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(3)=(Glow=(Value=1.0))
	LensflarePresetCustom(3)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(3)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(3)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(3)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(3)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(3)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(3)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(4)=(Glow=(Value=1.0))
	LensflarePresetCustom(4)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(4)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(4)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(4)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(4)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(4)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(4)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(5)=(Glow=(Value=1.0))
	LensflarePresetCustom(5)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(5)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(5)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(5)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(5)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(5)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(5)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(6)=(Glow=(Value=1.0))
	LensflarePresetCustom(6)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(6)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(6)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(6)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(6)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(6)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(6)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(7)=(Glow=(Value=1.0))
	LensflarePresetCustom(7)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(7)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(7)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(7)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(7)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(7)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(7)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(8)=(Glow=(Value=1.0))
	LensflarePresetCustom(8)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(8)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(8)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(8)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(8)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(8)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(8)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(9)=(Glow=(Value=1.0))
	LensflarePresetCustom(9)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(9)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(9)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(9)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(9)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(9)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(9)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(10)=(Glow=(Value=1.0))
	LensflarePresetCustom(10)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(10)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(10)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(10)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(10)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(10)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(10)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(11)=(Glow=(Value=1.0))
	LensflarePresetCustom(11)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(11)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(11)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(11)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(11)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(11)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(11)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(12)=(Glow=(Value=1.0))
	LensflarePresetCustom(12)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(12)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(12)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(12)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(12)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(12)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(12)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(13)=(Glow=(Value=1.0))
	LensflarePresetCustom(13)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(13)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(13)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(13)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(13)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(13)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(13)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(14)=(Glow=(Value=1.0))
	LensflarePresetCustom(14)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(14)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(14)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(14)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(14)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(14)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(14)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
	
	LensflarePresetCustom(15)=(Glow=(Value=1.0))
	LensflarePresetCustom(15)=(Position=(Distribution=(Count=1)))
	LensflarePresetCustom(15)=(Texture=(Render=(bSmooth=true)))
	LensflarePresetCustom(15)=(Color=(Min=(R=255,G=255,B=255),Max=(R=255,G=255,B=255)))
	LensflarePresetCustom(15)=(Color=(Random=(HSB=(Max=(Hue=255,Saturation=255,Brightness=255)))))
	LensflarePresetCustom(15)=(Size=(Min=1.0,Max=1.0))
	LensflarePresetCustom(15)=(Scale=(Min=(U=1.0,V=1.0),Max=(U=1.0,V=1.0)))
	LensflarePresetCustom(15)=(Degree=(Min=0.0,FadeMin=0.0,FadeMax=1.0,Max=1.0))
}
