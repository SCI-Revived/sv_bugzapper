# sv_bugzapper
Simple script to prevent prop push, prop kill, and prop flying, configurable using ConVars.

## Console Commands (Serverside)
- `sv_bugzapper` 0 or 1, enables the collision part of the script.
- `sv_bugzapper_time`, in seconds starting from 0, is the delay before setting the physgunned entity back to its normal collision group after being dropped.
- `sv_bugzapper_vel` 0 or 1, enables the part of the script that sets velocity to 0 after letting go of an entity with the physgun.
