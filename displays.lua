function displayParty()
  print("-----Party-----")
  for i = 1, 6 do
    local mon = player.party[i]
    if mon ~= nil and mon.name ~= "—" then
      print("[" .. i .. "] LV. " .. mon.level .. " " .. mon.name .. " \t[ HP:" .. string.format("%03d",mon.curhp) .. "/" .. string.format("%03d",mon.healthpoints) .. " | Attack:" .. string.format("%03d",mon.attack) .. " | Defence:" .. string.format("%03d",mon.defence) .. " | Sp. Atk:" .. string.format("%03d",mon.specialattack) .. " | Sp. Def:" .. string.format("%03d",mon.specialdefence) .. " | Speed:" .. string.format("%03d",mon.speed) .. " ]")
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

function displayBattle(battlerus, battlerthem)
  mon = battlerus.party[battlestate.currentmon]
  opmon = battlerthem.party[1]
  print("----Battle-----")
  print(battlerthem.name .. "'s " .. opmon.name .. " has " .. opmon.curhp .. "/" .. opmon.healthpoints .. " HP.")
  print(battlerus.name .. "'s " .. mon.name .. " has " .. mon.curhp .. "/" .. mon.healthpoints .. " HP.")
  print("[1] Fight")
  print("[2] Run")

  nextFunc = function(inp)
    if inp == "1" then
      return displayFight(battlerus, battlerthem)
    end

    input = ""
    return false
  end

  return true
end

function displayFight(battlerus, battlerthem)
  mon = battlerus.party[battlestate.currentmon]
  opmon = battlerthem.party[1]
  print("----Battle-----")
  print(battlerthem.name .. "'s " .. opmon.name .. " has " .. opmon.curhp .. "/" .. opmon.healthpoints .. " HP.")
  print(battlerus.name .. "'s " .. mon.name .. " has " .. mon.curhp .. "/" .. mon.healthpoints .. " HP.")
  for i=1,4 do
    print("[" .. i .. "] " .. mon.moves[i])
  end

  nextFunc = function(input) return useMove(battlerus, battlerthem, moves[mon.moves[tonumber(input)]]) end

  return true
end

function useMove(battlerus, battlerthem, move)
  mon = battlerus.party[battlestate.currentmon]
  opmon = battlerthem.party[1]
  if move ~= nil and move.name ~= "—" then
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    if move.accuracy == "—" or tonumber(move.accuracy) >= math.random(1, 100) then
      if move.power ~= "—" then
        local damage = ((((2 * tonumber(mon.level))/5 + 2) * tonumber(move.power) * tonumber(mon.attack) / tonumber(opmon.defence))/50 + 2) * 1
        opmon.curhp = opmon.curhp - math.floor(damage)
      end
    end

    input = ""
    return false
  end

  return false
end

function displayMainMenu()
  print("---Main Menu---")
  print("[1] Party")
  print("[2] Battle")

  nextFunc = function(input)
    if input == "1" then
      return displayParty()
    elseif input == "2" then
      return displayBattle(player, opponent)
    end
    return false
  end

  return true
end
