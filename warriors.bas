#INCLUDE ONCE "warriors.bi"

SUB WarriorMove (warrior AS tWarrior, direction AS INTEGER)

	warrior.oldx = warrior.x
	warrior.oldy = warrior.y
	warrior.moved = 1

	SELECT CASE direction
	CASE vUP:
		warrior.y -= 3
	CASE vDOWN
		warrior.y += 3
	CASE vLEFT
		warrior.x -= 3
	CASE vRIGHT
		warrior.x += 3
	END SELECT
	
	IF warrior.x < 40 THEN
		IF warrior.y < 7 THEN warrior.y = 7
		IF warrior.y > 49 THEN warrior.y = 49
		IF warrior.x < 3 THEN warrior.x = 3
		IF warrior.x > 33 THEN warrior.x = 33
	ELSE
		IF warrior.y < 7 THEN warrior.y = 7
		IF warrior.y > 49 THEN warrior.y = 49
		IF warrior.x < 46 THEN warrior.x = 46
		IF warrior.x > 76 THEN warrior.x = 76
	END IF

END SUB

SUB WarriorFire (warrior AS tWarrior, weaponId AS INTEGER)

	DIM x AS INTEGER, y AS INTEGER
	DIM ang AS INTEGER
	
	IF warrior.x < 40 THEN
		x = warrior.x + 3
		ang = 0
	ELSE
		x = warrior.x - 3
		ang = 180
	END IF
	y = warrior.y + 1

	ProjectileSetID weaponId

	SELECT CASE weaponId
	CASE wBLASTER:
		ProjectileFire x, y, 1, ang, 0
	CASE wLASER:
		ProjectileFire x, y, 5, ang, 0
	CASE wSHOTGUN:
		ProjectileFire x, y, 1.5, ang-10, 0
		ProjectileFire x, y, 1.5, ang, 0
		ProjectileFire x, y, 1.5, ang+10, 0
	CASE wSONICWAVE:
		FOR y = warrior.y-5 TO warrior.y+5
			ProjectileFire x, y+1, 1.2, ang+(y-warrior.y)*5, 0
		NEXT y
	CASE wROCKET:
		ProjectileFire x, y, 1.5, ang, PROJECTILE_SMOKE
	CASE wRICOCHET:
		ProjectileFire x, y, 1, ang+(60-INT(120*RND(1))+1), PROJECTILE_BOUNCE_X OR PROJECTILE_BOUNCE_Y
		'ProjectileFire x, y, 1, ang-30, PROJECTILE_BOUNCE_X OR PROJECTILE_BOUNCE_Y
		'ProjectileFire x, y, 1, ang+30, PROJECTILE_BOUNCE_X OR PROJECTILE_BOUNCE_Y
	CASE wTSUNAMI:
		FOR y = 7 TO 51
			ProjectileFire x, y, 0.5, ang, 0
		NEXT y
	CASE wVDISK:
		ProjectileFire x, y, 0.5, ang, PROJECTILE_SHOOT_UP OR PROJECTILE_SHOOT_DOWN
	CASE wCLOVER:
		ProjectileFire x, y, 1, ang+(60-INT(120*RND(1))+1), PROJECTILE_BOUNCE_X OR PROJECTILE_BOUNCE_Y
	END SELECT
END SUB

SUB WarriorDraw (warrior AS tWarrior)

	IF warrior.x < 40 THEN
		COLOR &hCCCC77
	ELSE
		COLOR &hFF7777
	END IF
	
	LOCATE warrior.y, warrior.x: PRINT warrior.strTop
	LOCATE , warrior.x: PRINT warrior.strMid
	LOCATE , warrior.x: PRINT warrior.strBot
	
END SUB

SUB WarriorErase (warrior AS tWarrior)

	LOCATE warrior.oldy, warrior.oldx: PRINT "   "
	LOCATE , warrior.oldx: PRINT "   "
	LOCATE , warrior.oldx: PRINT "   "

END SUB

SUB WarriorExecute (warrior AS tWarrior, opponent AS tWarrior)

	IF warrior.nextAction = "" THEN

		WarriorNextCommand warrior
		
		SELECT CASE warrior.nextAction
			CASE "sweep up"
				warrior.actionToY = 7
				warrior.actionToX = warrior.x
			CASE "sweep down"
				warrior.actionToY = 49
				warrior.actionToX = warrior.x
			CASE "sweep center"
				warrior.actionToY = 28
				warrior.actionToX = warrior.x
			CASE "sweep left"
				warrior.actionToX = 46
				warrior.actionToY = warrior.y
			CASE "sweep right"
				warrior.actionToX = 76
				warrior.actionToY = warrior.y
			CASE "sweep opponent"
				warrior.actionToY = opponent.y
				warrior.actionToX = warrior.x 
		END SELECT
		
	ELSE
	
		IF LEFT$(warrior.nextAction, 5) = "sweep" THEN
	
			IF warrior.y <> warrior.actionToY THEN
				IF warrior.y < warrior.actionToY THEN
					WarriorMove warrior, vDOWN
				ELSEIF warrior.y > warrior.actionToY THEN
					WarriorMove warrior, vUP
				END IF
			END IF
			
			IF warrior.x <> warrior.actionToX THEN
				IF warrior.x < warrior.actionToX THEN
					WarriorMove warrior, vRIGHT
				ELSEIF warrior.x > warrior.actionToX THEN
					WarriorMove warrior, vLEFT
				END IF
			END IF
			
			IF warrior.x = warrior.actionToX AND warrior.y = warrior.actionToY THEN
				warrior.nextAction = ""
			END IF
			
		END IF
			
		IF warrior.nextAction = "fire" THEN
			WarriorFire warrior, warrior.selectedWeapon
			warrior.nextAction = ""
		END IF
	
	END IF

END SUB

'- WarriorNextCommand ()
'-
'- Strip out the next command form the action string and store it in nextAction
'- or randomly select a maneuver (set of commands separated by commas that is copied to the action string)
'-\
SUB WarriorNextCommand (warrior AS tWarrior)

	DIM i AS INTEGER
	
	IF warrior.actionString <> "" THEN
	
		IF warrior.actionIndex = 0 THEN warrior.actionIndex = 1
	
		i = INSTR$(warrior.actionIndex, warrior.actionString, ",")
		
		IF i = 0 THEN
			warrior.nextAction = RIGHT$(warrior.actionString, LEN(warrior.actionString)-warrior.actionIndex+1)
			warrior.actionIndex = 0
			warrior.actionString = ""
		ELSE
			warrior.nextAction = MID$(warrior.actionString, warrior.actionIndex, i-warrior.actionIndex)
			warrior.actionIndex = i+1
		END IF
		
	ELSE
	
		DIM r AS INTEGER
		r = INT(7 * RND(1)) + 1
		
		IF r = 1 THEN warrior.actionString = "sweep center,fire,sweep up,fire,sweep center,fire,sweep down,fire,sweep center"
		IF r = 2 THEN warrior.actionString = "sweep opponent,fire"
		IF r = 3 THEN warrior.actionString = "sweep left,sweep opponent,fire,sweep right"
		IF r = 4 THEN warrior.actionString = "sweep top,fire,sweep left,sweep opponent,fire,sweep right"
		IF r = 5 THEN warrior.actionString = "sweep center,fire,fire,fire"
		IF r = 6 THEN warrior.actionString = "sweep left,sweep opponent,fire,fire,sweep right,sweep opponent,fire"
		IF r = 7 THEN warrior.actionString = "sweep center,fire,fire,sweep opponent,fire"
		
	END IF

END SUB

'- ProjectileSetID ()
'-
'- Simple, but important!
'- Set the projectile ID before firing a projectile
'- I like this way better rather than passing the ID in for the firing function
'-\
SUB ProjectileSetID (id AS INTEGER)

	ProjectileID = id

END SUB

'- ProjectileFire ()
'-
'- Add a projectile into the projectile queue
'-\
SUB ProjectileFire (x AS INTEGER, y AS INTEGER, speed AS SINGLE, angle AS INTEGER, flags AS INTEGER)

	DIM count AS INTEGER
	DIM vx AS SINGLE, vy AS SINGLE
	
	'IF projectilesCount >= 2 THEN RETURN
	
	IF angle = 0 THEN
		vx = 1
		vy = 0
	ELSEIF angle = 180 THEN
		vx = -1
		vy = 0
	ELSE
		vx =  COS(angle * 3.141592/180)
		vy = -SIN(angle * 3.141592/180)
	END IF

	projectilesCount += 1
	count = projectilesCount
	
	projectiles(count).wid = ProjectileID
	projectiles(count).x = x
	projectiles(count).y = y
	projectiles(count).xspeed = vx*speed*60
	projectiles(count).yspeed = vy*speed*60
	projectiles(count).hp = 1
	projectiles(count).xbounce = (flags AND 1)
	projectiles(count).ybounce = (flags AND 2)

END SUB

'- ProjectilesDo ()
'-
'- Draw, move, and remove (if necessary) the projectiles
'-\
SUB ProjectilesDo (warriors() AS tWarrior)

	DIM n AS INTEGER, w AS INTEGER
	DIM x AS INTEGER, y AS INTEGER
	DIM oldx AS INTEGER, oldy AS INTEGER
	DIM removeCount AS INTEGER
	DIM id AS INTEGER
	DIM delay AS DOUBLE: delay = GetDelay()
	
	STATIC smokeThrottle AS SINGLE = PROJECTILE_SMOKETHROTTLE
	
	IF smokeThrottle = -1 THEN smokeThrottle = PROJECTILE_SMOKETHROTTLE
	smokeThrottle -= delay
	IF smokeThrottle <= 0 THEN smokeThrottle = 0
	
	removeCount = 0
	FOR n = 0 TO projectilesCount
	
		id = projectiles(n).wid
		oldx = projectiles(n).x
		oldy = projectiles(n).y
		
		'- erase last position
		LOCATE oldy, oldx
		PRINT "   ";
	
		'- move projectile
		projectiles(n).x += projectiles(n).xspeed * delay
		projectiles(n).y += projectiles(n).yspeed * delay
		x = projectiles(n).x
		y = projectiles(n).y

		'- check bounds
		IF x > 78 OR x < 1 THEN
			IF projectiles(n).xbounce THEN
				projectiles(n).xspeed = -projectiles(n).xspeed
				projectiles(n).x = oldx
				CONTINUE FOR
			ELSE
				removeCount += 1
				projectiles(n).remove = 1
				LOCATE oldy, oldx: PRINT "   ";
			END IF
		END IF
		IF y < 7 OR y > 51 THEN
			IF projectiles(n).ybounce THEN
				projectiles(n).yspeed = -projectiles(n).yspeed
				projectiles(n).y = oldy
				CONTINUE FOR
			ELSE
				removeCount += 1
				projectiles(n).remove = 1
				LOCATE oldy, oldx: PRINT "   ";
			END IF
		END IF
		
		'- check for collision with enemy
		FOR w = 0 TO UBOUND(warriors)
		
			IF x >= warriors(w).x AND x < warriors(w).x+3 AND y >= warriors(w).y AND y < warriors(w).y+3 THEN
				removeCount += 1
				projectiles(n).remove = 1
				warriors(w).hp -= 1
			END IF
		
		NEXT w
		
		'- if projectile is targeted for removal, and it's a rocket, then
		'- do the fancy stuff to make it go poof! and fire debris
		IF projectiles(n).remove = 1 THEN
			SELECT CASE id
			CASE wROCKET
				Smoke oldx, oldy
				Smoke oldx, oldy-2
				Smoke oldx, oldy-1
				Smoke oldx, oldy+1
				ProjectileSetID wSHOTGUN
				ProjectileFire oldx, oldy, 1, 180-60, 0
				ProjectileFire oldx, oldy, 1, 180+60, 0
				ProjectileFire oldx, oldy, 1, 180-30, 0
				ProjectileFire oldx, oldy, 1, 180+30, 0
			END SELECT
			CONTINUE FOR
		END IF
		
		'- create puffs of smoke if the projectile is a rocket
		'- frequency controlled by smokeThrottle
		IF id = wROCKET AND smokeThrottle <= 0 THEN
			Smoke oldx-3, oldy
			smokeThrottle = -1
		END IF
		
		'- draw the projectile
		LOCATE y, x
		IF projectiles(n).xspeed >= 0 THEN
			COLOR WeaponLook(id).cLft: PRINT WeaponLook(id).sLft;
			COLOR WeaponLook(id).cMid: PRINT WeaponLook(id).sMid;
			COLOR WeaponLook(id).cRgt: PRINT WeaponLook(id).sRgt;
		ELSE
			COLOR WeaponMirror(id).cLft: PRINT WeaponMirror(id).sRgt;
			COLOR WeaponMirror(id).cMid: PRINT WeaponMirror(id).sMid;
			COLOR WeaponMirror(id).cRgt: PRINT WeaponMirror(id).sLft;
		END IF
	
	NEXT n
	
	'- remove projectiles flagged for deletion
	DIM copy AS INTEGER: copy = 0
	DIM i AS INTEGER: i = 0
	n = 0
	IF removeCount > 0 THEN
		WHILE copy <= projectilesCount
			WHILE projectiles(copy).remove = 1
				projectiles(copy).remove = 0
				copy += 1
			WEND
			projectiles(n) = projectiles(copy)
			copy += 1
			n += 1
		WEND
		projectilesCount -= removeCount
	END IF

END SUB

'- Smoke ()
'-
'- Create a puff of smoke (add to smokes queue)
'-\
SUB Smoke (x AS INTEGER, y AS INTEGER)

	DIM count AS INTEGER
	
	smokesCount += 1
	count = smokesCount
	
	smokes(count).x = x
	smokes(count).y = y
	smokes(count).xspeed = 0
	smokes(count).yspeed = -0.5
		
END SUB

'- SmokesDo()
'-
'- Draw, animate, and remove (if necessary) the smoke puffs
'-\
SUB SmokesDo ()

	DIM n AS INTEGER
	DIM x AS INTEGER, y AS INTEGER
	DIM oldx AS INTEGER, oldy AS INTEGER
	DIM removeCount AS INTEGER
	DIM delay AS DOUBLE: delay = GetDelay()
	
	removeCount = 0
	FOR n = 0 TO smokesCount
	
		oldx = smokes(n).x
		oldy = smokes(n).y

		'- erase old position
		LOCATE oldy, oldx
		PRINT "   ";
	
		'smokes(n).x += smokes(n).xspeed * delay
		smokes(n).xspeed += delay
		'- float upward
		smokes(n).y += smokes(n).yspeed * delay
		x = smokes(n).x
		y = smokes(n).y

		'- check bounds
		IF x > 78 OR x < 1 THEN
			removeCount += 1
			smokes(n).remove = 1
			LOCATE oldy, oldx: PRINT "   ";
			CONTINUE FOR
		END IF
		IF y < 7 OR y > 51 THEN
			removeCount += 1
			smokes(n).remove = 1
			LOCATE oldy, oldx: PRINT "   ";
			CONTINUE FOR
		END IF
		
		DIM lk AS INTEGER
		lk = INT(smokes(n).xspeed) \ 4
		IF lk >= 3 THEN
			removeCount += 1
			smokes(n).remove = 1
			LOCATE oldy, oldx: PRINT "   ";
			CONTINUE FOR
		END IF
		LOCATE y, x
		COLOR SmokeLook(lk).cLft: PRINT SmokeLook(lk).sLft;
		COLOR SmokeLook(lk).cMid: PRINT SmokeLook(lk).sMid;
		COLOR SmokeLook(lk).cRgt: PRINT SmokeLook(lk).sRgt;
		
	NEXT n
	
	'- remove smoke puffs flagged for deletion
	DIM copy AS INTEGER: copy = 0
	DIM i AS INTEGER: i = 0
	n = 0
	IF removeCount > 0 THEN
		WHILE copy <= smokesCount
			WHILE smokes(copy).remove = 1
				smokes(copy).remove = 0
				copy += 1
			WEND
			smokes(n) = smokes(copy)
			copy += 1
			n += 1
		WEND
		smokesCount -= removeCount
	END IF
	
END SUB
