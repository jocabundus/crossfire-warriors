#INCLUDE ONCE "warriors.bi"

DECLARE SUB CenterText (text AS STRING, row AS INTEGER)
DECLARE SUB DrawBox (row AS INTEGER, col AS INTEGER, w AS INTEGER, h AS INTEGER, text AS STRING, textColor AS INTEGER, borderColor AS INTEGER)
DECLARE SUB CenterBox (row AS INTEGER, w AS INTEGER, h AS INTEGER, text AS STRING, textColor AS INTEGER, borderColor AS INTEGER)
DECLARE SUB MenuSetWarrior (warrior AS tWarrior)
DECLARE SUB MenuStoreDraw ()
DECLARE SUB MenuStore ()
DECLARE SUB MenuStatsDraw ()
DECLARE SUB MenuStats ()
DECLARE SUB MenuWeaponsDraw ()
DECLARE SUB MenuWeapons ()
DECLARE SUB MenuAmmoDraw ()
DECLARE SUB MenuAmmo ()

DIM SHARED ActiveWarrior AS tWarrior

SUB MenuSetWarrior (warrior AS tWarrior)

	ActiveWarrior = warrior

END SUB

SUB MenuTitle ()

	CLS
	PRINT "                                                                                "; : COLOR &hFFFFFF, 0
	PRINT "________________________________________________________________________________"; : COLOR &h7777FF, 0
	PRINT "________________________________________________________________________________";
	PRINT "                                                                                ";
	PRINT "                                                                                "; : COLOR &hFFFFFF, 0
	PRINT "    === ===  === /// /// === = ===  ===     = =  =  ===  ===  = === ===  ///    "; : COLOR &hFFFF77, 0
	PRINT "    =   =_=  = = \\\ \\\ ==  = =_=  ==      = = =_= =_=  =_=  = = = =_=  \\\    "; : COLOR &hCCCC00, 0
	PRINT "    === = \\ === /// /// =   = = \\ ===     /^\ = = = \\ = \\ = === = \\ ///    ";
	PRINT "                                                                                "; : COLOR &h7777FF, 0
	PRINT "________________________________________________________________________________"; : COLOR &hFFFFFF, 0
	PRINT "________________________________________________________________________________";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                ";
	PRINT "                                                                                "; : COLOR &hFFFFFF, 0
	PRINT "________________________________________________________________________________"; : COLOR &h7777FF, 0
	PRINT "________________________________________________________________________________";
	PRINT "                                                                                "; : COLOR &hFFFFFF, 0
	PRINT "(C) 2009 DELTA CODE                                            www.deltacode.net";

	DIM strMenu(4) AS STRING
	DIM n AS INTEGER
	strMenu(0) = "1 PLAYER"
	strMenu(1) = "2 PLAYER"
	strMenu(2) = "OPTIONS "
	strMenu(3) = "EXIT    "
	
	'- draw menu first time
	COLOR &hFFFFFF, 0
	FOR n = 0 TO 3
		IF n > 0 THEN
			COLOR &h1111FF, 0
			CenterText "----------------", 21+5*n
			CenterText "=              =", 21+5*n+1
			CenterText "=              =", 21+5*n+2
			CenterText "=              =", 21+5*n+3
			CenterText "----------------", 21+5*n+4
			COLOR &hFFFFFF, 0
			CenterText strMenu(n), 21+5*n+2
		ELSE
			COLOR &hFFFFFF, 0
			CenterText "----------------", 21+5*n
			CenterText "=              =", 21+5*n+1
			CenterText "=              =", 21+5*n+2
			CenterText "=              =", 21+5*n+3
			CenterText "----------------", 21+5*n+4
			COLOR &hFF1111, 0
			CenterText strMenu(n), 21+5*n+2
		END IF
	NEXT n
	
	DIM strKey AS STRING
	DIM selection AS INTEGER
	DIM selectionLast AS INTEGER
	DO

		IF selection <> selectionLast THEN
			COLOR &h1111FF, 0
			CenterText "----------------", 21+5*selectionLast
			CenterText "=              =", 21+5*selectionLast+1
			CenterText "=              =", 21+5*selectionLast+2
			CenterText "=              =", 21+5*selectionLast+3
			CenterText "----------------", 21+5*selectionLast+4
			COLOR &hFFFFFF, 0
			CenterText strMenu(selectionLast), 21+5*selectionLast+2
			COLOR &hFFFFFF, 0
			CenterText "----------------", 21+5*selection
			CenterText "=              =", 21+5*selection+1
			CenterText "=              =", 21+5*selection+2
			CenterText "=              =", 21+5*selection+3
			CenterText "----------------", 21+5*selection+4
			COLOR &hFF1111, 0
			CenterText strMenu(selection), 21+5*selection+2
		END IF
		
		DO: strKey = INKEY$: LOOP WHILE strKey = ""
		
		selectionLast = selection
		
		IF strKey = CHR$(255) + "P" THEN selection += 1
		IF strKey = CHR$(255) + "H" THEN selection -= 1
		IF strKey = CHR$(13) OR strKey = " " THEN
			IF selection = 0 THEN EXIT DO
			IF selection = 3 THEN ExitProgram = 1: EXIT DO
		END IF
		
		IF selection < 0 THEN selection = 0
		IF selection > 3 THEN selection = 3

	LOOP

END SUB

SUB CenterText (text AS STRING, row AS INTEGER)

	LOCATE row, (80-LEN(text))\2
	PRINT text

END SUB

SUB DrawBox (row AS INTEGER, col AS INTEGER, w AS INTEGER, h AS INTEGER, text AS STRING, textColor AS INTEGER, borderColor AS INTEGER)

	DIM x AS INTEGER, y AS INTEGER
	
	COLOR borderColor, 0
	FOR y = 0 TO h-1
		LOCATE row+y, col
		IF y > 0 AND y < h-1 THEN
			PRINT "=" + SPACE$(w-2) + "=";
		ELSE
			PRINT STRING$(w, "-");
		END IF
	NEXT y
	
	COLOR textColor, 0
	LOCATE row+h\2, col+(w-LEN(text))\2
	PRINT text;

END SUB

SUB CenterBox (row AS INTEGER, w AS INTEGER, h AS INTEGER, text AS STRING, textColor AS INTEGER, borderColor AS INTEGER)

	DrawBox row, (80-w)\2+1, w, h, text, textColor, borderColor

END SUB

SUB PrintVar (strName AS STRING, value AS INTEGER, strFormat AS STRING)

	COLOR &h11FF11:	PRINT strName;
	COLOR &hFFFFFF:	PRINT " : ";

	COLOR &hFFFF11

	SELECT CASE strFormat
	CASE "i":
		PRINT STR$(value);
	CASE "p":
		PRINT STR$(value) + "%";
	CASE "c":
		PRINT "$" + STR$(value);
	CASE "t":
		DIM minutes AS INTEGER
		DIM seconds AS INTEGER
		minutes = value\60
		seconds = value MOD 60
		IF seconds < 10 THEN
			PRINT STR$(minutes) + ":0" + STR$(seconds);
		ELSE
			PRINT STR$(minutes) + ":" + STR$(seconds);
		END IF
	END SELECT

END SUB

SUB UpdateWeaponInventory ()

	DIM w AS tWarrior
	DIM strWeaponName AS STRING
	DIM strAmmo AS STRING
	DIM n AS INTEGER
	
	w = ActiveWarrior

	COLOR &hFFFFFF
	LOCATE 36, 27: PRINT "INVENTORY SUMMARY";
	LOCATE 40, 27: PRINT "WEAPONS             AMMO            LEVEL";
	COLOR &hFFFF11
	
	FOR n = 0 TO 6
		IF w.hasWeapon(n) = 0 THEN CONTINUE FOR
		
		strWeaponName = WeaponName(n)
		IF w.ammo(n) > 0 THEN
			strAmmo = STR$(w.ammo(n))
		ELSEIF w.ammo(n) = 0 THEN
			strAmmo = "OUT"
		ELSEIF w.ammo(n) = -1 THEN
			strAmmo = "INF"
		ELSE
			strAmmo = "WTF?"
		END IF
		
		LOCATE 42+n*2, 27
		PRINT CHR$(254) + " ";
		PRINT strWeaponName + SPACE$(18-LEN(strWeaponName)) + strAmmo + SPACE$(18-LEN(strAmmo));
	NEXT n
	
	'LOCATE 42, 27: PRINT CHR$(254) + " Blaster           INF               I  ";
	'LOCATE 44, 27: PRINT CHR$(254) + " Laser Cannon      " + STR$(w.ammo(wLASER)) + SPACE$(18-LEN(STR$(w.ammo(wLASER)))) + "I  ";
	'LOCATE 46, 27: PRINT CHR$(254) + " Shotgun           " + STR$(w.ammo(wSHOTGUN)) + SPACE$(18-LEN(STR$(w.ammo(wSHOTGUN)))) + "I  ";
	'LOCATE 48, 27: PRINT CHR$(254) + " Wave Cannon       " + STR$(w.ammo(wSONICWAVE)) + SPACE$(18-LEN(STR$(w.ammo(wSONICWAVE)))) + "I  "; 
	'LOCATE 50, 27: PRINT CHR$(254) + " Rocket Launcher   " + STR$(w.ammo(wROCKET)) + SPACE$(18-LEN(STR$(w.ammo(wROCKET)))) + "I  "
	'LOCATE 52, 27: PRINT CHR$(254) + " Ricochet          " + STR$(w.ammo(wRICOCHET)) + SPACE$(18-LEN(STR$(w.ammo(wRICOCHET)))) + "I  ";
	'LOCATE 54, 27: PRINT CHR$(254) + " Tsunami           " + STR$(w.ammo(wTSUNAMI)) + SPACE$(18-LEN(STR$(w.ammo(wTSUNAMI)))) + "I  ";

END SUB

SUB MenuStatsDraw ()

	DIM w AS tWarrior
	w = ActiveWarrior
	
	DIM winRatio AS INTEGER
	
	IF w.battleCount > 0 THEN
		winRatio = (w.battleWins/w.battleCount)*100
	ELSE
		winRatio = 0
	END IF

	CLS
	PRINT STRING$(80, "_");
	CenterText  "BATTLE COMPLETE", 3
	PRINT STRING$(80, "_");
	
	DrawBox 8, 25, 54, 50, "", &hFF1111, &hFFFFFF
	
	LOCATE 10, 27: PrintVar "Battles completed", w.battleCount, "i"
	LOCATE 12, 27: PrintVar "Battles won      ", w.battleWins, "i"
	LOCATE 14, 27: PrintVar "Battles lost     ", w.battleCount-w.battleWins, "i"
	LOCATE 16, 27: PrintVar "Win ratio        ", winRatio, "p"
	
	'LOCATE 10, 52: PrintVar "Total time       ", 305, "t"
	'LOCATE 12, 52: PrintVar "Average accuracy ", 23, "p"
	'LOCATE 14, 52: PrintVar "Average HP loss  ", 45, "i"
	'LOCATE 16, 52: PrintVar "Keystrokes       ", 2030, "i"
	
	LOCATE 22, 27: PrintVar "Match Time       ", w.battleSeconds, "t"
	LOCATE 24, 27: PrintVar "Match Accuracy   ", w.battleAccuracy, "p"
	LOCATE 26, 27: PrintVar "HP Loss          ", w.maxhp-w.hp, "i"
	
	DrawBox 41, 3, 20, 17, "", &hFFFFFF, &hFFFFFF
	LOCATE 43, 5: PRINT "CREDITS : ";: COLOR &h11FF11: PRINT "$" + STR$(w.credits);
	COLOR &hFFFFFF
	IF w.battleAward > 0 THEN
		LOCATE 46, 5: PrintVar "Award  ", w.battleAward, "c"
		'LOCATE 48, 5: PrintVar "Medical", 50, "c"
		'LOCATE 50, 5: PrintVar "Net    ", 950, "c"	
		LOCATE 54, 5: PrintVar "Total  ", w.credits, "c"
	END IF
	
	UpdateWeaponInventory
	
END SUB

SUB MenuStats ()

	MenuStatsDraw
	
	DIM strMenu(10) AS STRING
	DIM n AS INTEGER
	DIM top AS INTEGER
	strMenu(0) = "NEXT BATTLE   "
	strMenu(1) = "PURCHASE ITEMS"
	strMenu(2) = "STATS >>      "
	strMenu(3) = "STATS <<      "
	strMenu(4) = "END GAME      "
	
	DIM first AS INTEGER = 1
	
	DIM selection AS INTEGER
	DIM selectionLast AS INTEGER
	DIM strKey AS STRING
	DO
	
		IF first THEN
			top = 8
			FOR n = 0 TO 4
				IF n = 4 THEN top += 5
				IF n = selection THEN
					DrawBox top, 3, 20, 5, strMenu(n), &hFF1111, &hFFFFFF
				ELSE
					DrawBox top, 3, 20, 5, strMenu(n), &hFFFFFF, &h1111FF
				END IF
				top += 5
			NEXT n
			first = 0
		END IF
		
		IF selection <> selectionLast THEN
			COLOR &h1111FF, 0
			top = 8+selection*5: IF selection = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selection), &hFF1111, &hFFFFFF
			top = 8+selectionLast*5: IF selectionLast = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selectionLast), &hFFFFFF, &h1111FF
		END IF
		
		DO: strKey = INKEY$: LOOP WHILE strKey = ""
		
		selectionLast = selection
		
		IF strKey = CHR$(255) + "P" THEN selection += 1
		IF strKey = CHR$(255) + "H" THEN selection -= 1
		IF strKey = CHR$(13) OR strKey = " " THEN
			IF selection = 0 THEN EXIT DO
			IF selection = 1 THEN MenuStore: MenuStatsDraw: first = 1
			IF selection = 4 THEN END'ExitProgram = 1: EXIT DO
		END IF
		
		IF selection < 0 THEN selection = 0
		IF selection > 4 THEN selection = 4

	LOOP

	SLEEP

END SUB

SUB MenuStoreDraw ()

	'CLS
	DrawBox 8, 25, 54, 50, "", &hFF1111, &hFFFFFF
	
	UpdateWeaponInventory
	
	COLOR &hFFFFFF
	LOCATE 32, 27: PRINT "NOTES";
	COLOR &h1111FF
	LOCATE 36, 27: PRINT "* Before you can buy ammo, you must purchase the   ";
	LOCATE 38, 27: PRINT "  weapon that will use the ammo first.";
	LOCATE 42, 27: PRINT "* Weapons can be upgraded up to level four (IV).";
	LOCATE 46, 27: PRINT "* You always have infinite ammo for the blaster,";
	LOCATE 48, 27: PRINT "  but it can be upgraded.";
	LOCATE 52, 27: PRINT "* Try to find the balance between offense and";
	LOCATE 54, 27: PRINT "  defense.";
	
END SUB

SUB MenuStore ()

	'MenuStoreDraw '- not really necessary?
	
	DIM strMenu(10) AS STRING
	DIM n AS INTEGER
	DIM top AS INTEGER
	strMenu(0) = "WEAPONS      "
	strMenu(1) = "AMMUNITION   "
	strMenu(2) = "UPGRADES     "
	strMenu(3) = "DEFENSE      "
	strMenu(4) = "GO BACK      "
	
	DIM first AS INTEGER = 1
	
	DIM selection AS INTEGER
	DIM selectionLast AS INTEGER
	DIM strKey AS STRING
	DO
	
		IF first THEN
			top = 8
			FOR n = 0 TO 4
				IF n = 4 THEN top += 5
				IF n = selection THEN
					DrawBox top, 3, 20, 5, strMenu(n), &hFF1111, &hFFFFFF
				ELSE
					DrawBox top, 3, 20, 5, strMenu(n), &hFFFFFF, &h1111FF
				END IF
				top += 5
			NEXT n
			first = 0
		END IF
		
		IF selection <> selectionLast THEN
			COLOR &h1111FF, 0
			top = 8+selection*5: IF selection = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selection), &hFF1111, &hFFFFFF
			top = 8+selectionLast*5: IF selectionLast = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selectionLast), &hFFFFFF, &h1111FF
		END IF
		
		DO: strKey = INKEY$: LOOP WHILE strKey = ""
		
		selectionLast = selection
		
		IF strKey = CHR$(255) + "P" THEN selection += 1
		IF strKey = CHR$(255) + "H" THEN selection -= 1
		IF strKey = CHR$(13) OR strKey = " " THEN
			IF selection = 0 THEN MenuWeapons: MenuStatsDraw: first = 1
			IF selection = 1 THEN MenuAmmo: MenuStatsDraw: first = 1
			IF selection = 4 THEN EXIT DO
		END IF
		
		IF selection < 0 THEN selection = 0
		IF selection > 4 THEN selection = 4

	LOOP

END SUB

SUB MenuWeaponsDraw ()

	'CLS
	DrawBox 8, 25, 54, 50, "", &hFF1111, &hFFFFFF
	
	COLOR &hFFFFFF
	LOCATE 10, 27: PRINT "WEAPON          LEVEL       PRICE";
	
	UpdateWeaponInventory
	
END SUB

SUB MenuWeapons ()

	MenuWeaponsDraw
	
	DIM strWeapons(10, 4) AS STRING
	DIM strPrice(10, 4) AS STRING
	DIM strWeaponDesc(10, 4) AS STRING
	
	DIM selectedWeapon AS INTEGER
	strWeapons(0,0) = "Blaster           I": strPrice(0,0) = "$000": strWeaponDesc(0,0) = "Fires a blast                                     "
	strWeapons(1,0) = "Laser Cannon      I": strPrice(1,0) = "$250": strWeaponDesc(1,0) = "Weak strength, fast speed                         "
	strWeapons(2,0) = "Shotgun           I": strPrice(2,0) = "$100": strWeaponDesc(2,0) = "Fires a spread                                    "
	strWeapons(3,0) = "Wave Cannon       I": strPrice(3,0) = "$500": strWeaponDesc(3,0) = "Fires a spread                                    "
	strWeapons(4,0) = "Rocket Launcher   I": strPrice(4,0) = "$850": strWeaponDesc(4,0) = "Fires a fast rocket that explodes with debris     "
	strWeapons(5,0) = "Ricochet          I": strPrice(5,0) = "$1500":strWeaponDesc(5,0) = "Bounces off walls                                 "
	strWeapons(6,0) = "Tsunami           I": strPrice(6,0) = "$3000":strWeaponDesc(6,0) = "Epic tidal force                                  "
	
	strWeapons(0,1) = "Blaster          II": strPrice(0,1) = "$300": strWeaponDesc(0,1) = "Blaster upgrade includes: double damage           "
	strWeapons(1,1) = "Laser Cannon     II": strPrice(1,1) = "$500": strWeaponDesc(1,1) = "Laser upgrade inlcudes: dobule damage             "
	strWeapons(2,1) = "Shotgun          II": strPrice(2,1) = "$200": strWeaponDesc(2,1) = "Shotgun upgrade includes: 5 spread                "
	strWeapons(3,1) = "Wave Cannon      II": strPrice(3,1) = "$1000":strWeaponDesc(3,1) = "Wave cannon upgrade includes: 15 spread           "
	strWeapons(4,1) = "Rocket Launcher  II": strPrice(4,1) = "$1700":strWeaponDesc(4,1) = "Rocket upgrade includes: double damage, debris    "
	strWeapons(5,1) = "Ricochet         II": strPrice(5,1) = "$3000":strWeaponDesc(5,1) = "Ricochet upgrade includes: two ricochets per shot "
	strWeapons(6,1) = "Tsunami          II": strPrice(6,1) = "$6000":strWeaponDesc(6,1) = "Tsunami upgrade includes: double damage           "
	
	strWeapons(0,2) = "Blaster         III": strPrice(0,2) = "$600":  strWeaponDesc(0,2) = "Blaster III includes: triple damage               "
	strWeapons(1,2) = "Laser Cannon    III": strPrice(1,2) = "$1000": strWeaponDesc(1,2) = "Laser Cannon III includes: triple damage          "
	strWeapons(2,2) = "Shotgun         III": strPrice(2,2) = "$400":  strWeaponDesc(2,2) = "Shotgun III includes: double damage               "
	strWeapons(3,2) = "Wave Cannon     III": strPrice(3,2) = "$2000": strWeaponDesc(3,2) = "Wave Cannon III includes: double damage           "
	strWeapons(4,2) = "Rocket Launcher III": strPrice(4,2) = "$3400": strWeaponDesc(4,2) = "Rocket III includes: triple damage                "
	strWeapons(5,2) = "Ricochet        III": strPrice(5,2) = "$6000": strWeaponDesc(5,2) = "Ricochet III includes: double damage              "
	strWeapons(6,2) = "Tsunami         III": strPrice(6,2) = "$12000":strWeaponDesc(6,2) = "Tsunami III includes: triple damage               "
	
	strWeapons(0,3) = "Blaster          IV": strPrice(0,3) = "$1200": strWeaponDesc(0,3) = "Blaster IV includes: fast speed                   "
	strWeapons(1,3) = "Laser Cannon     IV": strPrice(1,3) = "$2000": strWeaponDesc(1,3) = "Laser Cannon IV includes: quad damage             "
	strWeapons(2,3) = "Shotgun          IV": strPrice(2,3) = "$800":  strWeaponDesc(2,3) = "Shotgun IV includes: 7 spread                     "
	strWeapons(3,3) = "Wave Cannon      IV": strPrice(3,3) = "$4000": strWeaponDesc(3,3) = "Wave Cannon IV includes: triple damage            "
	strWeapons(4,3) = "Rocket Launcher  IV": strPrice(4,3) = "$6800": strWeaponDesc(4,3) = "Rocket IV includes: double debris                 "
	strWeapons(5,3) = "Ricochet         IV": strPrice(5,3) = "$12000":strWeaponDesc(5,3) = "Ricochet IV includes: four ricochets per shot     "
	strWeapons(6,3) = "Tsunami          IV": strPrice(6,3) = "$24000":strWeaponDesc(6,3) = "Tsunami IV includes: fast speed                   "
	
	DIM strMenu(10) AS STRING
	DIM n AS INTEGER
	DIM top AS INTEGER
	strMenu(0) = "PURCHASE     "
	strMenu(1) = "NEXT >>      "
	strMenu(2) = "LAST <<      "
	strMenu(3) = "             "
	strMenu(4) = "GO BACK      "
	
	top = 8
	FOR n = 0 TO 4
		IF n = 4 THEN top += 5
		IF n = 0 THEN
			DrawBox top, 3, 20, 5, strMenu(n), &hFF1111, &hFFFFFF
		ELSE
			DrawBox top, 3, 20, 5, strMenu(n), &hFFFFFF, &h1111FF
		END IF
		top += 5
	NEXT n
	
	DIM selection AS INTEGER
	DIM selectionLast AS INTEGER
	DIM strKey AS STRING
	DO
	
		FOR n = 0 TO 6
			IF n = selectedWeapon THEN
				COLOR &hFF1111, &hFFFFFF
				LOCATE 14+n*2, 27: PRINT strWeapons(n,0);
				PRINT SPACE$(9);
				PRINT strPrice(n, 0);
			ELSE
				COLOR &hFFFFFF, 0
				LOCATE 14+n*2, 27: PRINT strWeapons(n,0);
				PRINT SPACE$(9);
				COLOR &h11FF11, 0
				LOCATE 14+n*2, 55: PRINT strPrice(n,0);
			END IF
		NEXT n
		
		LOCATE 30, 27
		COLOR &h1111FF, 0
		PRINT strWeaponDesc(selectedWeapon,0)

		IF selection <> selectionLast THEN
			COLOR &h1111FF, 0
			top = 8+selection*5: IF selection = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selection), &hFF1111, &hFFFFFF
			top = 8+selectionLast*5: IF selectionLast = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selectionLast), &hFFFFFF, &h1111FF
		END IF
		
		DO: strKey = INKEY$: LOOP WHILE strKey = ""
		
		selectionLast = selection
		
		IF strKey = CHR$(255) + "P" THEN selection += 1
		IF strKey = CHR$(255) + "H" THEN selection -= 1
		IF strKey = CHR$(13) OR strKey = " " THEN
			'IF selection = 0 THEN MenuWeapons: MenuStoreDraw
			IF selection = 1 THEN selectedWeapon += 1
			IF selection = 2 THEN selectedWeapon -= 1
			IF selection = 4 THEN EXIT DO
		END IF
		
		IF selection < 0 THEN selection = 0
		IF selection > 4 THEN selection = 4
		IF selectedWeapon < 0 THEN selectedWeapon = 0
		IF selectedWeapon > 6 THEN selectedWeapon = 6

	LOOP
	
END SUB

SUB MenuAmmoDraw ()

	'CLS
	DrawBox 8, 25, 54, 50, "", &hFF1111, &hFFFFFF
	
	COLOR &hFFFFFF
	LOCATE 10, 27: PRINT "AMMO TYPE        PRICE";
	
	UpdateWeaponInventory
	
END SUB

SUB MenuAmmo ()

	DIM w AS tWarrior
	w = ActiveWarrior

	MenuAmmoDraw
	
	DIM strAmmo(10) AS STRING
	DIM strPrice(10) AS STRING
	
	DIM selectedAmmo AS INTEGER
	strAmmo(0) = "Blaster Ammo  ": strPrice(0) = "FREE  "
	strAmmo(1) = "Laser Cells   ": strPrice(1) = "5/$25 "
	strAmmo(2) = "Shotgun Shells": strPrice(2) = "5/$10 "
	strAmmo(3) = "Wave Charge   ": strPrice(3) = "5/$35 "
	strAmmo(4) = "Rockets       ": strPrice(4) = "1/$10 "
	strAmmo(5) = "Ricochet      ": strPrice(5) = "1/$100"
	strAmmo(6) = "Tsunami       ": strPrice(6) = "1/$300"
	
	DIM n AS INTEGER
	DIM strMenu(10) AS STRING
	DIM top AS INTEGER
	strMenu(0) = "PURCHASE     "
	strMenu(1) = "NEXT >>      "
	strMenu(2) = "LAST <<      "
	strMenu(3) = "             "
	strMenu(4) = "GO BACK      "
	
	top = 8
	FOR n = 0 TO 4
		IF n = 4 THEN top += 5
		IF n = 0 THEN
			DrawBox top, 3, 20, 5, strMenu(n), &hFF1111, &hFFFFFF
		ELSE
			DrawBox top, 3, 20, 5, strMenu(n), &hFFFFFF, &h1111FF
		END IF
		top += 5
	NEXT n
	
	DIM selection AS INTEGER
	DIM selectionLast AS INTEGER
	DIM strKey AS STRING
	DO
	
		FOR n = 0 TO 6
			IF w.hasWeapon(n) THEN
				IF n = selectedAmmo THEN
					COLOR &hFF1111, &hFFFFFF
					LOCATE 14+n*2, 27: PRINT strAmmo(n);
					PRINT SPACE$(3);
					PRINT strPrice(n);
				ELSE
					COLOR &hFFFFFF, 0
					LOCATE 14+n*2, 27: PRINT strAmmo(n);
					PRINT SPACE$(3);
					COLOR &h11FF11, 0
					PRINT strPrice(n);
				END IF
			ELSE
				COLOR &h777777, 0
				LOCATE 14+n*2, 27: PRINT strAmmo(n);
				PRINT SPACE$(3);
				COLOR &h119911, 0
				PRINT "Purchase weapon first";
				'LOCATE 14+n*2, 27+16: PRINT strPrice(n);
			END IF
		NEXT n
		
		IF selection <> selectionLast THEN
			COLOR &h1111FF, 0
			top = 8+selection*5: IF selection = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selection), &hFF1111, &hFFFFFF
			top = 8+selectionLast*5: IF selectionLast = 4 THEN top += 5
			DrawBox top, 3, 20, 5, strMenu(selectionLast), &hFFFFFF, &h1111FF
		END IF
		
		DO: strKey = INKEY$: LOOP WHILE strKey = ""
		
		selectionLast = selection
		
		IF strKey = CHR$(255) + "P" THEN selection += 1
		IF strKey = CHR$(255) + "H" THEN selection -= 1
		IF strKey = CHR$(13) OR strKey = " " THEN
			'IF selection = 0 THEN MenuWeapons: MenuStoreDraw
			IF selection = 1 THEN
				selectedAmmo += 1
				WHILE w.hasWeapon(selectedAmmo) = 0
					selectedAmmo += 1
					IF selectedAmmo > 6 THEN selectedAmmo = 0
				WEND
			END IF
			IF selection = 2 THEN
				selectedAmmo -= 1
				WHILE w.hasWeapon(selectedAmmo) = 0
					selectedAmmo -= 1
					IF selectedAmmo < 0 THEN selectedAmmo = 6
				WEND
			END IF
			IF selection = 4 THEN EXIT DO
		END IF
		
		IF selection < 0 THEN selection = 0
		IF selection > 4 THEN selection = 4
		IF selectedAmmo < 0 THEN selectedAmmo = 0
		IF selectedAmmo > 6 THEN selectedAmmo = 6

	LOOP

END SUB

SUB MenuDefense ()
END SUB

SUB MenuWarriors ()
END SUB