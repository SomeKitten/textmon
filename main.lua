require "pokemon"
require "term"

player = {}
player.party = {}

player.party[1] = mons["Bulbasaur"]:new()
player.party[1].moves[1] = "Tackle"

player.party[2] = mons["Squirtle"]:new()
player.party[2].moves[1] = "Tail Whip"

player.party[3] = mons["Bulbasaur"]:new()
player.party[3].moves[1] = "Vine Whip"

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

  nextFunc = function(input) return displayPokemon(player.party[tonumber(input)]) end

  return false
end

function displayPokemon(mon)
  if mon ~= nil and mon.name ~= "—" then
    print("----Pokemon----")
    print(mon.name)
    for i = 1, 4 do
      print("[" .. i .. "] " .. mon.moves[i])
    end

    nextFunc = function(input) return displayMove(moves[mon.moves[tonumber(input)]]) end

    return true
  end
  return false
end

function displayMove(move)
  if move ~= nil and move.name ~= "—" then
    print("-----Move------")
    print(move.name)
    print("Type: " .. move.type)
    print("Category: " .. move.category)
    print("Power: " .. move.power)
    print("Accuracy: " .. move.accuracy)
    print("Power Points: " .. move.powerpoints)
    if move.effect ~= "" then
      print("Effect: " .. move.effect)
    end

    nextFunc = function() return false end

    return true
  end
  return false
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

    term.clear()
    local curfunc = nextFunc
    local test = nextFunc(input)
    if test then
      local inp = input
      table.insert(functree, function() return curfunc(inp) end)
    else
      if input == "" then table.remove(functree) end
      if functree[#functree] ~= nil then
        functree[#functree]()
      else
        break
      end
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
