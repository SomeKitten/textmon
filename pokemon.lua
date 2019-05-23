Pokemon = {
  name = "----",
  moves = {"----", "----", "----", "----"}
}

Move = {
  name = "----",
  attack = "--",
  accuracy = "--",
  powerpoints = "--"
}

function initnames()
  local asciidex = io.open("ascii/pokedex.txt")
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

function Pokemon:new(p)
  p = p or {}
  p.moves = p.moves or {}

  setmetatable(p, self)
  self.__index = self

  setmetatable(p.moves, self.moves)
  self.moves.__index = self.moves

  return p
end

function Move:new(m)
  m = m or {}

  setmetatable(m, self)
  self.__index = self

  return m
end

pokenames = initnames()

moves = {}
moves["----"] = Move:new()
moves["Growl"] = Move:new{name = "Growl", powerpoints = 40, accuracy = 100}
moves["Tackle"] = Move:new{name = "Tackle", powerpoints = 35, attack = 40, accuracy = 100}
