require "pokemon"
require "term"

pokemon = {}

pokemon[1] = Pokemon:new{
  name = "Bulbasaur",
  moves = {
    "Growl","Tackle"
  }
}
pokemon[2] = Pokemon:new()
pokemon[3] = Pokemon:new()
pokemon[4] = Pokemon:new()
pokemon[5] = Pokemon:new()
pokemon[6] = Pokemon:new()

function displayParty()
  print("-----Party-----")
  for i = 1, 6 do
    local mon = pokemon[i]
    print("[" .. i .. "] " .. mon.name)
  end

  nextFunc = function(input) displayPokemon(pokemon[tonumber(input)] or {}) end
end

function displayPokemon(mon)
  print("----Pokemon----")
  print(mon.name)
  for i = 1, 4 do
    print("[" .. i .. "] " .. mon.moves[i])
  end

  nextFunc = function(input) displayMove(moves[mon.moves[tonumber(input)] or "----"]) end
end

function displayMove(move)
  print("-----Move------")
  print(move.name)
  print("Attack: " .. move.attack)
  print("Accuracy: " .. move.accuracy)
  print("Power Points: " .. move.powerpoints)

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


math.randomseed(os.time())
math.random(); math.random(); math.random()
pokeascii = math.random(134)

curascii = io.open(string.format("ascii/%03d.txt", pokeascii))

print(curascii:read("*a")..[[

Thanks for playing!

Have a ]] .. pokenames[pokeascii][2] .. ".")
