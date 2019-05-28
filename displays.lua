function displayParty()
  print("-----Party-----")
  for i = 1, 6 do
    local mon = player.party[i]
    if mon ~= nil and mon.name ~= "—" then
      print("[" .. i .. "] " .. mon.name .. " \t[ HP:" .. string.format("%03d",mon.curhp) .. "/" .. string.format("%03d",mon.healthpoints) .. " | Attack:" .. string.format("%03d",mon.attack) .. " | Defence:" .. string.format("%03d",mon.defence) .. " | Sp. Atk:" .. string.format("%03d",mon.specialattack) .. " | Sp. Def:" .. string.format("%03d",mon.specialdefence) .. " | Speed:" .. string.format("%03d",mon.speed) .. " ]")
    else
      print("[" .. i .. "] " .. "—")
    end
  end

  nextFunc = function(input) return displayPokemon(player.party[tonumber(input)]) end

  return true
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

function displayBattle()
  print("----Battle-----")
  print("[1] Fight")
  print("[2] Run")

  nextFunc = function(inp)
    if inp == "1" then
      return displayFight(player.party[battlestate.currentmon])
    end

    input = ""
    return false
  end

  return true
end

function displayMainMenu()
  print("---Main Menu---")
  print("[1] Party")
  print("[2] Battle")

  nextFunc = function(input)
    if input == "1" then
      return displayParty()
    elseif input == "2" then
      return displayBattle()
    end
    return false
  end

  return true
end
