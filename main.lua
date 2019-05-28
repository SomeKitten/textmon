require "pokemon"
require "term"
require "displays"

battlestate = {
  currentmon = 1
}

player = Trainer:new()

player.party[1] = mons["Bulbasaur"]:new()
player.party[1].moves[1] = "Tackle"

player.party[2] = mons["Squirtle"]:new()
player.party[2].moves[1] = "Tail Whip"

player.party[3] = mons["Bulbasaur"]:new()
player.party[3].moves[2] = "Vine Whip"
player.party[3].curhp = 35

opponent = Trainer:new()

opponent.party[1] = mons["Charmander"]:new()
opponent.party[1].moves[1] = "Scratch"

function start()
  functree = {}

  term.clear()

  nextFunc = displayMainMenu
  table.insert(functree, nextFunc)
  nextFunc()

  while true do
    io.write("> ")
    input = io.read()

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
