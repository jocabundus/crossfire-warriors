DECLARE FUNCTION UpdateSpeed () AS DOUBLE
DECLARE FUNCTION GetDelay () AS DOUBLE

DIM SHARED DelayDelay AS DOUBLE

'- UpdateSpeed ()
'-
'- Calculate the global delay factor
'-\
FUNCTION UpdateSpeed () AS DOUBLE

	DIM speed AS DOUBLE
	STATIC timex AS DOUBLE = 0.0f

	speed = TIMER-timex
	timex = TIMER
	
	DelayDelay = speed
	
	RETURN speed
	
END FUNCTION

FUNCTION GetDelay () AS DOUBLE

	RETURN DelayDelay

END FUNCTION
