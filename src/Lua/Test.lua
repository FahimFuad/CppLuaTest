
-- PlayerTitle = "RDX"
-- PlayerName = "Fahim"
-- PlayerStatus = "Noob"
-- PlayerLevel = 20

-- Player = {}
-- Player["Title"] = "RDX"
-- Player["Name"] = "Fahim"
-- Player["Status"] = "Noob"
-- Player["Level"] = "20"

players = {}
players[0] = { Title = "[Ridhwan]", Name = "Fahim", Status = "GOD", Level = 20 }
players[1] = { Title = "Quo", Name = "George", Status = "Pro", Level = 15 }

function AddStuff(a, b)
    print("[LUA] AddStuff("..a..", "..b..") called! \n")
    return a + b;
end

function GetPlayer(n)
    return players[n]
end

function DoAThing(a, b)
    print("[LUA] DoAThing("..a..", "..b..") called! \n")

    c = HostFunction(a + 10, b)
    return c;
end
