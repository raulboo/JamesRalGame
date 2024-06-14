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

require("legacy.graphic")
require("legacy.controls")
require("legacy.player")
require("legacy.utilities")
require("legacy.tiles")
require("legacy.geometry")

require("ecs")
require("utilities")

-- GLOBAL CONSTANTS --------------------------------

TILE_SIZE = 16

-- MODULES

World = require("World")
Stage = require("Stage")

--------------------------------

world = World.new()
stage = nil


function love.load() 
     -- Load entire sprite sheet
    spriteSheet = love.graphics.newImage("images/spriteSheet.png")

    -- Crete tiles
    for i = 0, 32 do
        addTile(0, 0, i, 16)
    end

    for i = 0, 8 do
        addTile(0, 0, i + 3, 12)
    end

    addTile(0, 0, 16, 10)
    addTile(0, 0, 16, 11)
    addTile(0, 0, 16, 12)
    addTile(0, 0, 16, 13)
    addTile(0, 0, 16, 14)

    -- creating a player for test
   addPlayer(100, 100)
   addPlayer(200, 100)

    table.insert(world, {
        type   = "player",
        pos    = {x = 120, y = 120},
        sprite = love.graphics.newQuad(0, 16, 16, 16, spriteSheet)
    })
end

function love.update(dt)
    controls(dt) -- prototype where the all player moveents will be made ?

    detectTiles()

    updateObject(playerTable)
    updateObject(tileTable)
end

function love.draw()
    -- systems


    -- Every draw code need to be between startCanvas and endCanvas to adapt correct to the game pixel size.
    startCanvas({0.5, 0.5, 0.5, 1})

        drawObject(tileTable)
        drawObject(playerTable)

        displaySprites(world)

    endCanvas()
end

displaySprites = system({"pos", "sprite"},
    function(e)
        love.graphics.draw(spriteSheet, e.sprite, e.pos.x, e.pos.y)
    end
)
