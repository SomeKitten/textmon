require "pokemon"
require "term"

player = {}
player.party = {}

player.party[1] = mons["Bulbasaur"]
player.party[2] = mons["Squirtle"]
player.party[3] = Pokemon:new()
player.party[4] = Pokemon:new()
player.party[5] = Pokemon:new()
player.party[6] = Pokemon:new()

function displayParty()
  print("-----Party-----")
  for i = 1, 6 do
    local mon = player.party[i]
    if mon.name ~= "—" then
      print("[" .. i .. "] " .. mon.name .. " \t[ HP:" .. string.format("%03d",mon.healthpoints) .. " | Attack:" .. string.format("%03d",mon.attack) .. " | Defence:" .. string.format("%03d",mon.defence) .. " | Sp. Atk:" .. string.format("%03d",mon.specialattack) .. " | Sp. Def:" .. string.format("%03d",mon.specialdefence) .. " | Speed:" .. string.format("%03d",mon.speed) .. " ]")
    else
      print("[" .. i .. "] " .. mon.name)
    end
  end

  nextFunc = function(input) displayPokemon(player.party[tonumber(input)] or {}) end
end

function displayPokemon(mon)
  print("----Pokemon----")
  print(mon.name)
  for i = 1, 4 do
    print("[" .. i .. "] " .. mon.moves[i])
  end

  nextFunc = function(input) displayMove(moves[mon.moves[tonumber(input)] or "—"]) end
end

function displayMove(move)
  print("-----Move------")
  print(move.name)
  print("Type: " .. move.type)
  print("Category: " .. move.category)
  print("Power: " .. move.power)
  print("Accuracy: " .. move.accuracy)
  print("Power Points: " .. move.powerpoints)
  print("Effect: " .. move.effect)

  nextFunc = nil
end

function start()
  functree = {}

  term.clear()

  nextFunc = displayParty
  table.insert(functree, displayParty)
  nextFunc()

  while true do
    io.write("> ")
    local input = io.read()

    if input == "" or nextFunc == nil then
      table.remove(functree)
    else
      local curfunc = nextFunc
      table.insert(functree, function() curfunc(input) end)
    end

    if functree[#functree] ~= nil then
      term.clear()
      functree[#functree]()
    else
      break
    end
  end
end


start()

term.clear()

math.randomseed(os.time())
math.random(); math.random(); math.random()
pokeascii = math.random(134)

curascii = io.open(string.format("ascii/%03d.txt", pokeascii))

print("\n\n\n" .. curascii:read("*a")..[[

Thanks for playing!
Have a ]] .. pokenames[pokeascii][2] .. ".")
