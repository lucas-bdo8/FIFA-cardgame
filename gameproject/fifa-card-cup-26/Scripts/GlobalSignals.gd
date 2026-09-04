extends Node

signal Start_Kick_Off_event(TeamWPoss: int) #1 = home, 2 = away

signal Pass(Player: int, Team: int)

signal Shoot(PlayerSkill: int, AgainstGLSkill: int, luck: float, luckTarget: float, ShooterPos: float, DefenderPos)

signal GoalScored(Team: int, Player: int, When: int)

signal StartIntro()

signal NextSong()

signal SongChanged(SongName: String)
