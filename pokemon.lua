Pokemon = {
  name = "—",
  moves = {"—", "—", "—", "—"},
  healthpoints = "—",
  curhp = "—",
  attack = "—",
  defence = "—",
  specialattack = "—",
  specialdefence = "—",
  speed = "—",
  level = "—"
}

Move = {
  name = "—",
  type = "—",
  category = "—",
  power = "—",
  accuracy = "—",
  powerpoints = "—",
  effect = "—"
}

Trainer = {
  name = "—",
  party = {}
}

function initnames()
  local asciidex = io.open("pokedex.txt")
  local lines = {}
  local fileread = asciidex:read("*l")
  while fileread ~= nil do
    table.insert(lines, fileread)
    fileread = asciidex:read("*l")
  end

  for i, line in ipairs(lines) do
    local words = {}
    for word in line:gmatch("%S+") do table.insert(words, word) end
    lines[i] = words
  end

  return lines
end

function initmoves()
  local movedex = io.open("movedex.txt")
  local lines = {}
  local fileread = movedex:read("*l")
  while fileread ~= nil do
    table.insert(lines, fileread)
    fileread = movedex:read("*l")
  end

  local movestemp = {}

  for i, line in ipairs(lines) do
    local words = {}
    for word in line:gmatch("%S+") do
      table.insert(words, word)
    end

    local continue = false
    if #words < 6 then
      continue = true
    end

    if not continue then
      local namelen = 1

      while words[namelen] ~= words[namelen]:upper() do
        namelen = namelen + 1
      end

      local movetemp = Move:new{type = words[namelen], category = words[namelen + 1], power = words[namelen + 2], accuracy = words[namelen + 3], powerpoints = words[namelen + 4]}

      movetemp.name = ""
      for i = 1, namelen - 1 do
        movetemp.name = movetemp.name .. words[i] .. " "
      end
      movetemp.name = movetemp.name:sub(1,-2)

      movetemp.effect = ""
      for i = namelen + 5, #words do
        movetemp.effect = movetemp.effect .. words[i] .. " "
      end
      movetemp.effect = movetemp.effect:sub(1,-2)

      movestemp[movetemp.name] = movetemp
    end
  end

  local movetemp = Move:new()
  movestemp[movetemp.name] = movetemp

  return movestemp
end

function genStat(p, stat)
  if stat ~= "healthpoints" then
    return math.floor(math.floor((2 * p[stat] + 63 + 0) * p.level / 100 + 5) * 1)
  else
    return math.floor((2 * p[stat]  + 63 + 0) * p.level / 100 + p.level + 10)
  end
end

function Pokemon:new(p)
  p = p or {}
  p.moves = p.moves or {}

  setmetatable(p, self)
  self.__index = self

  setmetatable(p.moves, self.moves)
  self.moves.__index = self.moves

  if self.name ~= "—" then
    p.healthpoints = genStat(p, "healthpoints")
    p.attack = genStat(p, "attack")
    p.defence = genStat(p, "defence")
    p.specialattack = genStat(p, "specialattack")
    p.specialdefence = genStat(p, "specialdefence")
    p.speed = genStat(p, "speed")
  end

  p.curhp = p.healthpoints

  return p
end

function Trainer:new(t)
  t = t or {}
  t.party = t.party or {}

  setmetatable(t, self)
  self.__index = self

  setmetatable(t.party, self.party)
  self.party.__index = self.party

  return t
end

function Move:new(m)
  m = m or {}

  setmetatable(m, self)
  self.__index = self

  return m
end

pokenames = initnames()

mons = {}
for _, name in pairs(pokenames) do
  mons[name[2]] = Pokemon:new{
    name = name[2],
    healthpoints = name[3],
    attack = name[4],
    defence = name[5],
    specialattack = name[6],
    specialdefence = name[7],
    speed = name[8]
  }
end

moves = initmoves()
