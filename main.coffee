c = document.getElementById('draw')
ctx = c.getContext('2d')

delta = 0
now = 0
before = Date.now()
elapsed = 0

# c.width = window.innerWidth
# c.height = window.innerHeight

c.width = 800
c.height = 600

keysDown = {}


window.addEventListener("keydown", (e) ->
    keysDown[e.keyCode] = true
, false)

window.addEventListener("keyup", (e) ->
    delete keysDown[e.keyCode]
, false)

setDelta = ->
    now = Date.now()
    delta = (now - before) / 1000
    before = now;

enemies = []
toSpawn = 2

update = ->
    setDelta()

    toSpawn -= delta
    if toSpawn <= 0
        toSpawn = 2
        enemies.push({
            lane: 1
            x: 800
        })

    elapsed += delta


    for enemy in enemies
        enemy.x -= delta * 50
        console.log enemy.x


    draw(delta)

    window.requestAnimationFrame(update)


draw = (delta) ->
    ctx.clearRect(0, 0, c.width, c.height)

    ctx.save()
    # ctx.translate(ctx.width / 2, ctx.height / 2)
    # ctx.rotate(1)
    # ctx.translate(-ctx.width / 2, -ctx.height / 2)
    ctx.fillRect(0, 0, 800, 20)
    ctx.fillRect(0, 200, 800, 20)
    ctx.fillRect(0, 400, 800, 20)
    ctx.fillRect(0, 580, 800, 20)

    for enemy in enemies
        ctx.fillRect(enemy.x, enemy.lane * 200, 20, 20)

    ctx.restore()


do ->
    w = window
    for vendor in ['ms', 'moz', 'webkit', 'o']
        break if w.requestAnimationFrame
        w.requestAnimationFrame = w["#{vendor}RequestAnimationFrame"]

    if not w.requestAnimationFrame
        targetTime = 0
        w.requestAnimationFrame = (callback) ->
            targetTime = Math.max targetTime + 16, currentTime = +new Date
            w.setTimeout (-> callback +new Date), targetTime - currentTime


update()
