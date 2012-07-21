#INCLUDE ONCE "delay.bas"

'===============================================================================
'- Warrior Stuff
'===============================================================================
TYPE tWarrior
	
	x AS INTEGER
	y AS INTEGER
	oldx AS INTEGER
	oldy AS INTEGER
	moved AS INTEGER
	hp AS INTEGER
	lasthp AS INTEGER
	maxhp AS INTEGER
	
	strTop AS STRING * 3
	strMid AS STRING * 3
	strBot AS STRING * 3
	
	actionString AS STRING
	actionIndex AS INTEGER
	actionToX AS INTEGER
	actionToY AS INTEGER
	nextAction AS STRING
	
	selectedWeapon AS INTEGER
	lastWeapon AS INTEGER
	hasWeapon(10) AS INTEGER
	ammo(10) AS INTEGER
	score AS INTEGER
	
	credits AS INTEGER
	battleCount AS INTEGER
	battleWins AS INTEGER
	battleAccuracy AS INTEGER
	battleSeconds AS INTEGER
	
	battleAward AS INTEGER
		
	isPlayable AS INTEGER
	
END TYPE

TYPE tWarriorAction

	actionString AS STRING
	actionIndex AS INTEGER
	actionToX AS INTEGER
	actionToY AS INTEGER
	nextAction AS STRING
	
END TYPE

TYPE tWarriorDetails

	title AS STRING
	hue AS INTEGER
	credits AS INTEGER
	
	keyUp AS INTEGER
	keyDown AS INTEGER
	keyLft AS INTEGER
	keyRgt AS INTEGER
	keyFire AS INTEGER
	keyNxtWpn AS INTEGER
	keyPrvWpn AS INTEGER

END TYPE

DECLARE SUB WarriorDraw (warrior AS tWarrior)
DECLARE SUB WarriorErase (warrior AS tWarrior)
DECLARE SUB WarriorMove (warrior AS tWarrior, direction AS INTEGER)
DECLARE SUB WarriorFire (warrior AS tWarrior, weaponId AS INTEGER)
DECLARE SUB WarriorNextCommand (warrior AS tWarrior)
DECLARE SUB WarriorExecute (warrior AS tWarrior, opponent AS tWarrior)

CONST vUP = 1
CONST vDOWN = 2
CONST vLEFT = 3
CONST vRIGHT = 4

'===============================================================================
'- Weapons/Projectile Stuff
'===============================================================================
TYPE tProjectile
	wid AS INTEGER	'- weapon id
	x AS SINGLE
	y AS SINGLE
	xspeed AS SINGLE
	yspeed AS SINGLE
	hp AS INTEGER	'- hp points lost when hit
	remove AS INTEGER
	xbounce AS INTEGER
	ybounce AS INTEGER
END TYPE

CONST PROJECTILE_BOUNCE_X	= 1
CONST PROJECTILE_BOUNCE_Y	= 2
CONST PROJECTILE_SMOKE		= 4
CONST PROJECTILE_SHOOT_UP	= 8
CONST PROJECTILE_SHOOT_DOWN	= 16
CONST PROJECTILE_CLOVER		= 32

CONST PROJECTILE_SMOKETHROTTLE = 5

DIM SHARED ProjectileID AS INTEGER
DECLARE SUB ProjectileSetID (id AS INTEGER)
DECLARE SUB ProjectileFire (x AS INTEGER, y AS INTEGER, speed AS SINGLE, angle AS INTEGER, flags AS INTEGER)
DECLARE SUB ProjectilesDo (warriors() AS tWarrior)
DECLARE SUB Smoke (x AS INTEGER, y AS INTEGER)
DECLARE SUB SmokesDo ()

DIM SHARED projectiles(1000) AS tProjectile
DIM SHARED projectilesCount AS INTEGER = -1
DIM SHARED smokes(100) AS tProjectile
DIM SHARED smokesCount AS INTEGER = -1



CONST wBLASTER = 0	'- fallback weapon
CONST wLASER = 1	'- fast
CONST wSHOTGUN = 2	'- 3 spread
CONST wSONICWAVE = 3'- vertical wave spread
CONST wROCKET = 4	'- explode on impact, reverse debri spread
CONST wRICOCHET = 5	'- bounces off walls
CONST wTSUNAMI = 6	'- full vertical wave
CONST wVDISK = 7	'- horizontal bullet that fires bullets up and down as it moves across
CONST wCLOVER = 8	'- like ricochet, but fires four bullets as it moves
CONST wBLACK = 9	'- Who knows?

DIM SHARED WeaponName(10) AS STRING
DIM SHARED WeaponCode(10) AS STRING
WeaponName(0) = "Blaster"			: WeaponCode(0) = "B"
WeaponName(1) = "Laser Cannon"		: WeaponCode(1) = "L"
WeaponName(2) = "Shotgun"			: WeaponCode(2) = "S"
WeaponName(3) = "Wave Cannon"		: WeaponCode(3) = "W"
WeaponName(4) = "Rocket Launcher"	: WeaponCode(4) = "R"
WeaponName(5) = "Ricochet"			: WeaponCode(5) = "I"
WeaponName(6) = "Tsunami"			: WeaponCode(6) = "T"
WeaponName(7) = "V-Disk"			: WeaponCode(7) = "?"
WeaponName(8) = "4-Leaf Clover"		: WeaponCode(8) = "?"
WeaponName(9) = "Black Vortex"		: WeaponCode(9) = "X"


TYPE tWeaponLook
	sLft AS STRING * 1
	sMid AS STRING * 1
	sRgt AS STRING * 1
	cLft AS INTEGER
	cMid AS INTEGER
	cRgt AS INTEGER
END TYPE

DIM SHARED WeaponLook(10) AS tWeaponLook
DIM SHARED WeaponMirror(10) AS tWeaponLook
DIM SHARED SmokeLook(3) AS tWeaponLook