---@diagnostic disable: undefined-global, lowercase-global


-- STYLE GUIDE DO CÓDIGO
-- Uma sugestão baseada nos códigos que eu escrevi/li ao longo do tempo
-- Só pra termos um padrão no código e não nos confundirmos com o tempo 
-- Me baseei nisso principalmente: https://github.com/luarocks/lua-style-guide
-- (pulei algumas regras, pq 3 espaços é absurdo x.x)

-- VARIÁVEIS
-- Sempre que possível, usar "local" (exceto para variáveis propositalmente globais)
-- Nomear usando snake_case 
-- Nomes = substantivos 
-- ex: local total_time = relative_time + dt


-- FUNÇÕES
-- Nomear usando camelCase
-- Funções privadas ou restritas apenas ao .lua em que é declarado -> usar "local function" (para não poluir o global namespace ao usar require)
-- Funções privadas -> nomear começando com underscore (ex: local function _functionFoo())
-- Nomear com frases no imperativo (começando com verbos) -> ex: renderMap, executeMemory, killEntity
-- para se saber exatamente o efeito que a função tem sobre o jogo

-- Outras sugestões de nomenclatura:
-- > Funções que não modificam o machine state, só retornam algo -> getAlgo()
-- > O mesmo de cima, que retorna apenas bool -> isAlgoAlgumaCoisa()
-- > Funções que são chamadas após determinado evento -> onAlgo() (ex: onLoad(), onSave(), onDeath())

-- Com exceção de funções complexas como moveX/moveY, não é bom que funções tenham mais que 30 linhas de código. 
-- Se for o caso, tente dividir em 2+ funções, fracionando o problema em vários passos

-- Se vc tiver de bom humor, pode até fazer uma documententaçãozinha acima da função :3
-- seguindo esse padrão:

-- Função não utilizada, que só serve para demonstrar o modelo de documentação padrão do lua
-- @param foo integer: um número aleatório
-- @return integer: retorna foo adicionado a 1
local function _test(foo) return foo+1 end

-- MÓDULOS
-- Você pode criar uma table contendo funções e variáveis
-- Normalmente ela seria uma variavel normal (snake_case), mas gosto de organizar os sistemas em "Módulos" (ver /systems/)
-- Pra diferenciar, gosto de escrevê-las em PascalCase (tipo classes no c++)
-- Para ficar mais organizado, eu gosto de ir declarando as funções fora da tbl do modulo, uma vez que ele já está definido

-- ex: 
-- (RenderSystems.lua)
-- local RenderSystems = {}
-- RenderSystems.renderMap =      system(...)
-- RenderSystems.renderEntities = system(...)
-- RenderSystems.renderRest =     system(...)
-- function RenderSystems:_reset() ... end
-- return RenderSystems (isso é no final, para retornar a table modulo no require("RenderSystems.lua"))

-- quando for dar require, dá então para fazer:
-- (main.lua)
-- local Systems = {
--      Render = require("/systems/RenderSystems.lua"),
-- }


-- CONSTANTES 
-- Nomear usando SCREAMING_SNAKE_CASE
-- Geralmente não precisa do "local" (pq vai ser global)
-- Não use underscore + SCREAMING_SNAKE_CASE pq essas constantes são reservadas pelo Lua (ex: _G, _ENV)


-- OUTLINE
-- /
-- /main.lua      -> World, Stage, world, stage, love.load(), love.update(), love.draw()
-- /ecs.lua       -> _has(), system()
-- /conf.lua      -> love.conf()
-- /World.lua     -> ENTITY_LABEL_TABLE, World, World.new(), World:spawn(label,x,y)
-- /Stage.lua     -> STAGE_LABEL_TABLE, Stage, Stage.load(label), Stage:update(), Stage:draw()
-- /utilities.lua -> Vec2, isBoxInBox, isPointInBox
-- /picoAPI.lua   -> (por enquanto n precisa) spr(), print()

-- /systems
-- /systems/RenderSystems.lua  -> renderMap(tiles), renderSprites()
-- /systems/PhysicsSystems.lua -> moveActorX(), moveActorY(), pullGravity()
-- /systems/InputSystems.lua   -> walkPlayer(), jumpPlayer(), makePunchPlayer()

-- /entities 
-- /entities/ENTITY_LABEL_TABLE.lua
-- /entities/000-MODEL.lua 
-- /entities/001-placeholder-pc.lua ["pc"]

-- /stages
-- /stages/STAGE_LABEL_TABLE.lua 
-- /stages/000-MODEL.lua -> {edges, tiled_export, display_name, respawn_point, onLoad()}
-- /stages/001-test.lua  -> ["test"]
-- /stages/001-test-tiles.lua (export do tiled -> considerar manter apenas os exports do tiled em /stages)

-- /gfx
-- /gfx/globalSpriteSheet.png

-- /lib (os plugins externos)
-- /lib/sti (plugin pra importar mapas do Tiled)

----------------------------------------------------

require("ecs")
require("utilities")
require("picoAPI")
require("input")

-- GLOBAL VARIABLES --------------------------------

deltaTime = nil

-- GLOBAL CONSTANTS --------------------------------

DEBUG = true
TILE_SIZE = 16
Gravity = 0.2

math.randomseed(os.time())

-- MODULES

World = require("World")
Stage = require("Stage")

DebugSystems = require("debug.DebugSystems")

Systems = {
    Render  = require("systems.RenderSystems"),
    Physics = require("systems.PhysicsSystems"),
    Input   = require("systems.InputSystems"),
    Life    = require("systems.LifeSystems"),
}

--------------------------------

world = World.new()
stage = nil


function love.load()
    loadPicoSpritesheet("images/spriteSheet.png", TILE_SIZE, TILE_SIZE)
    stage = Stage.load("test")

    -- Load Sounds
    picoAddSfx("jump", "sfx/jump.wav")
    picoAddSfx("punch", "sfx/punch.wav", 0.5)
    picoAddSfx("hurt", "sfx/hurt.wav", 0.5)

    -- Load players
    local p1 = world:spawn("test_player", pickRandom(stage.respawn_points))
    p1.controls = {
        walk_left  = "left",
        walk_right = "right",
        jump       = "up",
        punch      = ",",
        special    = "."
    }
    p1.player_controlling = 1

    local p2 = world:spawn("test_player", pickRandom(stage.respawn_points))
    p2.controls = {
        walk_left  = "a",
        walk_right = "d",
        jump       = "w",
        punch      = "f",
        special    = "g"
    }
    p1.player_controlling = 2
end

function love.draw()
    startCanvas({0.0, 0.0, 0.0, 1}) -- Color used to clean background

    if DEBUG then
        if love.keyboard.isDown("lshift") then DebugSystems.displayAllAabb(world) end
    end

    stage:drawTiles()
    Systems.Render.renderSprites(world)

    endCanvas()
    
    if DEBUG then love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 1, 1) end
end

function love.update(dt)
    deltaTime = dt

    Systems.Physics.moveActorX   (world)
    Systems.Physics.moveActorY   (world)
    Systems.Physics.pullGravity  (world)
    Systems.Physics.applyFriction(world)

    Systems.Input.walkPlayer     (world)
    Systems.Input.jumpPlayer     (world)
    Systems.Input.makePunchPlayer(world)

    Systems.Physics.applyCollisionEffects(world)

    Systems.Life.decay                 (world)
    Systems.Life.deathOutsideBoudaries (world)
    Systems.Life.respawn               (world)
    Systems.Life.die                   (world)
end