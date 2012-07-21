'- CROSSFIRE WARRIORS
'- 06/01/2009
'- Programming: Joe King
'- Testing: Adam Kewley
'- http://www.deltacode.net
'----------------------------

#INCLUDE ONCE "ASCII.BI"
#INCLUDE ONCE "WARRIORS.BAS"
#INCLUDE ONCE "MENU.BAS"
#INCLUDE ONCE "BATTLE.BAS"

DECLARE SUB GameDo(warriors() AS tWarrior)

DIM warriors(12) AS tWarrior
DIM SHARED warriorsCount AS INTEGER
warriorsCount = 1

'===============================================================================
'- Weapon/Projectile GFX
'===============================================================================

DIM n AS INTEGER
DIM l AS INTEGER, m AS INTEGER, r AS INTEGER
FOR n = 0 TO 8
	READ l, m, r: WeaponLook(n).sLft = CHR$(l): WeaponLook(n).sMid = CHR$(m): WeaponLook(n).sRgt = CHR$(r)
	READ l, m, r: WeaponMirror(n).sLft = CHR$(l): WeaponMirror(n).sMid = CHR$(m): WeaponMirror(n).sRgt = CHR$(r)
	READ l, m, r: WeaponLook(n).cLft = l: WeaponLook(n).cMid = m: WeaponLook(n).cRgt = r
				  WeaponMirror(n).cLft = r: WeaponMirror(n).cMid = m: WeaponMirror(n).cRgt = l
NEXT n
FOR n = 0 TO 2
	READ l, m, r: SmokeLook(n).sLft = CHR$(l): SmokeLook(n).sMid = CHR$(m): SmokeLook(n).sRgt = CHR$(r)
	READ l, m, r: SmokeLook(n).cLft = l: SmokeLook(n).cMid = m: SmokeLook(n).cRgt = r
NEXT n
'===============================================================================
'===============================================================================

DIM bcount AS SINGLE

SystemInit

DO WHILE ExitProgram = 0

	MenuTitle
	'MenuStore
	'MenuSetWarrior warriors(0)
	'MenuStats
	'END
	IF ExitProgram THEN EXIT DO
	
	BATTLE_Reset
	BATTLE_AddWarrior 0, 1
	BATTLE_AddWarrior 1, 0
	DO
		BATTLE_Do
		IF MULTIKEY(FB.SC_ESCAPE) THEN EXIT DO
	LOOP
	
	'CLS
	'HUDdrawTemplate warriors()
	'HUDupdateLifeBar PLAYER, warriors(0).hp, warriors()
	'HUDupdateLifeBar BOSS, warriors(1).hp, warriors()
	'HUDupdateSelectedWeapon PLAYER, warriors(0).selectedWeapon, warriors()
	'HUDupdateAmmoCount PLAYER, warriors(1).ammo(warriors(PLAYER).selectedWeapon), warriors()

	'DO
	'	GameDo warriors()
	'	IF MULTIKEY(FB.SC_ESCAPE) THEN EXIT DO
	'LOOP
LOOP

SystemRelease
END

SUB SystemInit ()
	SCREENRES 640, 480,  32, , 1
	SETMOUSE ,,0
END SUB

SUB SystemRelease ()
	SETMOUSE ,,1
END SUB


'===============================================================================
'- Weapon/Projectile GFX
'- projectile -> (3 characters)
'- projectile <- (3 characters)
'- color for projectile -> (it is automatically reversed when mirrored)
'===============================================================================
'- blaster
DATA 175,175,175
DATA 174,174,174
DATA &hCC7700, &hFFCC77, &hFFFF77
'- laser
DATA 196,196,196
DATA 196,196,196
DATA &h007700, &h77FF77, &hFFFFFF
'- shotgun
DATA 000,254,000
DATA 000,254,000
DATA &h000000, &hCCCCCC, &h000000
'- sonic wave
DATA 041,041,041
DATA 040,040,040
DATA &h777700, &hCCCC77, &hFFFFFF
'- rocket
DATA 220,220,220
DATA 220,220,220
DATA &hFFFFFF, &hFFFFFF, &hFF0000
'- ricochet
DATA 000,079,000
DATA 000,079,000
DATA &h007777, &h77FFFF, &h007777
'- tsunami
DATA 175,175,175
DATA 174,174,174
DATA &h000077, &h7777FF, &hFFFFFF
'- v-disk
DATA 093,061,091
DATA 093,061,091
DATA &hFFFFFF, &hFFFFFF, &hFFFFFF
'- 4-leaf clover
DATA 000,178,000
DATA 000,178,000
DATA &hFFFFFF, &hFFFFFF, &hFFFFFF
'===============================================================================
'===============================================================================

'- smoke
DATA 177,178,177
DATA &h999999, &h999999, &h999999
DATA 176,177,176
DATA &h777777, &h777777, &h777777
DATA 000,176,000
DATA &h333333, &h333333, &h333333
