#INCLUDE ONCE "warriors.bi"
#INCLUDE ONCE "delay.bas"


DECLARE SUB BATTLE_Reset ()
DECLARE SUB BATTLE_AddWarrior (team AS INTEGER, isPlayable AS INTEGER)
DECLARE SUB BATTLE_Do ()

'- Heads-Up Display (Stats)
DECLARE SUB HUDdrawTemplate (warriors() AS tWarrior)
DECLARE SUB HUDupdateAmmoCount (warriorId AS INTEGER, count AS INTEGER, warriors() AS tWarrior)
DECLARE SUB HUDupdateSelectedWeapon (warriorId AS INTEGER, weaponId AS INTEGER, warriors() AS tWarrior)
DECLARE SUB HUDupdateLifeBar (warriorId AS INTEGER, life AS INTEGER, warriors() AS tWarrior)

'- system functions
DECLARE FUNCTION KeyDown(keyCode AS INTEGER) AS INTEGER

DIM SHARED BattleTime AS INTEGER
DIM SHARED BattleWarriorsCount AS INTEGER = -1

DIM SHARED BattleWarriors(10) AS tWarrior