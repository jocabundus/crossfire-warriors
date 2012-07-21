#INCLUDE ONCE "battle.bi"

DIM SHARED BattleFirstDo AS INTEGER

SUB BATTLE_Reset ()

	BattleFirstDo = 1

END SUB

SUB BATTLE_AddWarrior (team AS INTEGER, isPlayable AS INTEGER)

	DIM w AS tWarrior

	IF team = 0 THEN
		w.x = 3: w.y = 7
	ELSE
		w.x = 76: w.y = 7
	END IF
	
	w.strTop = "\-/"
	w.strMid = "o o"
	w.strBot = "_-_"
	w.selectedWeapon = wBLASTER
	w.maxhp = 35
	w.hp = 35
	w.lasthp = 35
	w.isPlayable = isPlayable
	
	'- default weapon setup
	w.hasWeapon(0) = 1
	w.hasWeapon(1) = 1
	w.hasWeapon(2) = 1
	w.hasWeapon(3) = 1
	w.hasWeapon(4) = 1
	w.ammo(0) = -1
	w.ammo(1) = 25
	w.ammo(2) = 50
	w.ammo(3) = 15
	w.ammo(4) = 10
	w.ammo(5) = 5
	w.ammo(6) = 1
	w.ammo(7) = 0
	w.ammo(8) = 0
	
	BattleWarriorsCount += 1
	BattleWarriors(BattleWarriorsCount) = w

END SUB

SUB BATTLE_Do ()

	DIM n AS INTEGER
	DIM delay AS DOUBLE
	
	IF BattleFirstDo = 1 THEN
		CLS
		HUDdrawTemplate BattleWarriors()
		FOR n = 0 TO BattleWarriorsCount
			HUDupdateLifeBar n, BattleWarriors(n).hp, BattleWarriors()
			IF n = 0 THEN
				HUDupdateSelectedWeapon n, BattleWarriors(n).selectedWeapon, BattleWarriors()
				HUDupdateAmmoCount n, BattleWarriors(n).ammo(BattleWarriors(n).selectedWeapon), BattleWarriors()
			END IF
		NEXT n
		delay = UpdateSpeed
		SLEEP 1
		BattleFirstDo = 0
	END IF
	
	FOR n = 0 TO BattleWarriorsCount
		
		IF BattleWarriors(n).moved = 1 THEN
			WarriorErase BattleWarriors(n)
			BattleWarriors(n).moved = 0
		END IF
		IF BattleWarriors(n).hp <> BattleWarriors(n).lasthp THEN
			HUDupdateLifeBar n, BattleWarriors(n).hp, BattleWarriors()
		END IF
		WarriorDraw BattleWarriors(n)
	NEXT n
	
	ProjectilesDo BattleWarriors()
	SmokesDo
	
	DO: LOOP UNTIL INKEY$ = ""

	delay = UpdateSpeed

	FOR n = 0 TO BattleWarriorsCount
	
		IF BattleWarriors(n).isPlayable THEN
		
			IF keyDown(FB.SC_UP) THEN
				WarriorMove BattleWarriors(n), vUP
			ELSEIF keyDown(FB.SC_DOWN) THEN
				WarriorMove BattleWarriors(n), vDOWN
			ELSEIF keyDown(FB.SC_LEFT) THEN
				WarriorMove BattleWarriors(n), vLEFT
			ELSEIF keyDown(FB.SC_RIGHT) THEN
				WarriorMove BattleWarriors(n), vRIGHT
			END IF
		
			STATIC refire AS SINGLE
			refire += delay
			IF refire > 15 THEN refire = 15
		
			IF (MULTIKEY(FB.SC_F) AND refire = 15) OR KeyDown(FB.SC_F) THEN
				refire = 0
				DIM ammoCount AS INTEGER
				ammoCount = BattleWarriors(n).ammo(BattleWarriors(n).selectedWeapon) 
				IF ammoCount <> 0 THEN
					WarriorFire BattleWarriors(n), BattleWarriors(n).selectedWeapon
					IF ammoCount > 0 THEN BattleWarriors(n).ammo(BattleWarriors(n).selectedWeapon) -= 1
					HUDupdateAmmoCount n, ammoCount, BattleWarriors()
					'- this will make the weapon code turn red
					IF ammoCount = 1 THEN
						HUDupdateSelectedWeapon n, BattleWarriors(n).selectedWeapon, BattleWarriors()
					END IF
				END IF
			END IF
			IF keyDown(FB.SC_D) THEN
				BattleWarriors(n).selectedWeapon += 1
				WHILE BattleWarriors(n).ammo(BattleWarriors(n).selectedWeapon) = 0
					BattleWarriors(n).selectedWeapon += 1
					IF BattleWarriors(n).selectedWeapon > 8 THEN BattleWarriors(n).selectedWeapon = 0
				WEND
				HUDupdateSelectedWeapon n, BattleWarriors(n).selectedWeapon, BattleWarriors()
				HUDupdateAmmoCount n, BattleWarriors(n).ammo(BattleWarriors(n).selectedWeapon), BattleWarriors()
			END IF
		ELSE
	
			DIM opponentSpeed AS DOUBLE = 7/60
			STATIC bcount AS DOUBLE
			bcount += delay
			IF bcount > opponentSpeed THEN
				WarriorExecute BattleWarriors(1), BattleWarriors(0) '- needs to be changed in future
				bcount = 0
			END IF
		
		END IF
	NEXT n
	
END SUB

'- HUDdrawTemplate ()
'-
'- Draw the static HUD objects
'-\
SUB HUDdrawTemplate (warriors() AS tWarrior)

	DIM x AS INTEGER, y AS INTEGER
	DIM wid AS INTEGER
	
	COLOR &h9999FF, 0
	LOCATE 6, 1: PRINT STRING$(80, "_");
	LOCATE 52, 1: PRINT STRING$(80, "_");
	
	'- left life bar
	COLOR , &h77FF00
	LOCATE 2, 3: PRINT SPACE$(35)
	COLOR , &h007700
	LOCATE 3, 3: PRINT SPACE$(35)
	'- right life bar
	COLOR , &hFF7777
	LOCATE 2, 44: PRINT SPACE$(35)
	COLOR , &h770000
	LOCATE 3, 44: PRINT SPACE$(35)

	'- left bonus
	COLOR &hFFFFFF, 0
	LOCATE 5, 3: PRINT "BONUS [";
	COLOR &hCCCC00, 0: PRINT "000000";
	COLOR &hFFFFFF, 0: PRINT "]";
	
	'- right bonus
	COLOR &hFFFFFF, 0
	LOCATE 5, 65: PRINT "[";
	COLOR &hCCCC00, 0: PRINT "000000";
	COLOR &hFFFFFF, 0: PRINT "] BONUS";
	
	'- ammo box
	COLOR &hFFFFFF, 0
	LOCATE 54, 3: PRINT "[   ]";
	
	'- available weapons
	wid = 0
	LOCATE 56, 1
	FOR y = 0 TO 2
		LOCATE , 3
		FOR x = 0 TO 2
			IF warriors(0).ammo(wid) <> 0 THEN
				COLOR &h777777, 0
			ELSE
				COLOR &h333333, 0
			END IF
			PRINT "[" + WeaponCode(wid) + "] ";
			wid += 1
		NEXT x
		PRINT
	NEXT y

END SUB

SUB HUDupdateAmmoCount (warriorId AS INTEGER, count AS INTEGER, warriors() AS tWarrior)
	
	DIM w AS tWarrior
	DIM strAmmo AS STRING
	DIM zeros AS INTEGER
	
	w = warriors(warriorId)
	
	strAmmo = STR$(w.ammo(w.selectedWeapon))
	IF strAmmo = "-1" THEN strAmmo = "INF"
	IF strAmmo = "0" THEN strAmmo = "OUT"
	zeros = 3-LEN(strAmmo)
	LOCATE 54, 4:
	COLOR &h991111, 0
	PRINT STRING$(zeros, "0");
	'- make it a deeper red if you are out of ammo
	COLOR &hFF3333, 0
	LOCATE 54, 4+zeros
	PRINT strAmmo
	
END SUB

SUB HUDupdateSelectedWeapon (warriorId AS INTEGER, weaponId AS INTEGER, warriors() AS tWarrior)

	DIM w AS tWarrior
	DIM strWpName AS STRING
	DIM ammoCount AS INTEGER
	
	w = warriors(warriorId)
	
	warriors(warriorId).lastWeapon = w.selectedWeapon
	
	strWpName = WeaponName(w.selectedWeapon)
	LOCATE 54, 9
	COLOR &h77FF77, 0
	PRINT strWpName + "               "
	
	ammoCount = w.ammo(w.lastWeapon) 
	IF ammoCount = 0 THEN COLOR &h333333, 0 ELSE COLOR &h777777, 0
	LOCATE 56+w.lastWeapon\3, 4*(w.lastWeapon MOD 3)+3
	PRINT "[" + WeaponCode(w.lastWeapon) + "]"
	
	ammoCount = w.ammo(w.selectedWeapon)
	IF ammoCount = 0 THEN COLOR &hFF0000, 0 ELSE COLOR &hFFFFFF, 0
	LOCATE 56+w.selectedWeapon\3, 4*(w.selectedWeapon MOD 3)+3
	PRINT "[" + WeaponCode(w.selectedWeapon) + "]"
	
END SUB

SUB HUDupdateLifeBar (warriorId AS INTEGER, life AS INTEGER, warriors() AS tWarrior)

	DIM lasthp AS INTEGER = warriors(warriorId).lasthp

	IF life < 0 THEN life = 0

	IF warriorId = 0 THEN
		COLOR , &h004400
		LOCATE 2, 3+(35-lasthp): PRINT SPACE$(warriors(warriorId).lasthp-life)
		COLOR , &h002200
		LOCATE 3, 3+(35-lasthp): PRINT SPACE$(warriors(warriorId).lasthp-life)
		COLOR , 0
	ELSEIF warriorId = 1 THEN
		COLOR , &h440000
		LOCATE 2, 44+life: PRINT SPACE$(warriors(warriorId).lasthp-life)
		COLOR , &h220000
		LOCATE 3, 44+life: PRINT SPACE$(warriors(warriorId).lasthp-life)
		COLOR , 0
	END IF

END SUB

'- KeyDown()
'-
'- Throttles keypresses
'- Returns true for a state change, from keyup to keydown, of the given scancode
'- After the key is down, it will return false until the key is released and pressed again
'-\
FUNCTION KeyDown(keyCode AS INTEGER) AS INTEGER

	STATIC mkey(255) AS INTEGER
	
	IF MULTIKEY(keyCode) THEN
		IF mkey(keyCode) = 0 THEN
			mkey(keyCode) = 1
			RETURN 1
		END IF
		mkey(keyCode) = 1
	ELSE
		mkey(keyCode) = 0
	END IF
	
	RETURN 0

END FUNCTION

