--- thank you lemon SO much for the name
--- this *very* simple script just prevents prop flying and prop pushing.

CreateConVar(
	"sv_bugzapper",
	"1",
	FCVAR_ARCHIVE,
	"Enables bugzapper, making physgunned ents not solid to players and vehicle ents.",
	0,
	1
)
CreateConVar(
	"sv_bugzapper_vel",
	"1",
	FCVAR_ARCHIVE,
	"Enables bugzapper velocity, which sets physgunned ents velocity to 0 after letting go.",
	0,
	1
)
CreateConVar(
	"sv_bugzapper_time",
	"4",
	FCVAR_ARCHIVE,
	"Time in seconds bugzapper will be active for after a physgunned ent has been let go.",
	0
)

local bugzapperEnabled = GetConVar("sv_bugzapper")
local bugzapperVelEnabled = GetConVar("sv_bugzapper_vel")
local bugzapperTime = GetConVar("sv_bugzapper_time")

hook.Add("OnPhysgunPickup", "BugZapperPickup", function(ply, ent)
	if not bugzapperEnabled:GetBool() then
		return
	end

	ent:SetCollisionGroup(11) ---collision group 11 makes it not collide with players and vehicles, more info at https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP
end)

hook.Add("PhysgunDrop", "BugZapperDrop", function(ply, ent)
	if not bugzapperEnabled:GetBool() then
		return
	end

	timer.Simple(bugzapperTime:GetFloat(), function()
		if not IsValid(ent) then
			return
		end

		ent:SetCollisionGroup(0) ---this resets it back to normal collisions
	end)
end)

local function BugZapperVelDrop(ply, ent)
	if not bugzapperVelEnabled:GetBool() then
		return
	end

	if not IsValid(ent) then
		return
	end

	local phys = ent:GetPhysicsObject()

	if not IsValid(phys) then
		return
	end

	phys:SetVelocity(Vector(0, 0, 0))
	phys:SetAngleVelocity(Vector(0, 0, 0))
	phys:Wake()
end

hook.Add("PhysgunDrop", "BugZapperVel", BugZapperVelDrop)
