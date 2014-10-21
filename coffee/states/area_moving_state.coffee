class AreaMovingState extends AbstractState
    constructor: (@canvas, @data, @x, @y) ->

    onMouseUp: (event) ->
        @canvas.transit(new NormalState(@canvas, @data))

    # 表示領域を移動
    onMouseMove: (event) ->
        [x, y] = [event.e.offsetX, event.e.offsetY]
        fpp = 1 # frames per pixel (何px動いたら画面更新するか)
        dx = x - @x
        dy = y - @y
        if (Math.abs(dx) >= fpp || Math.abs(dy) >= fpp)
            @data.moveArea(dx, dy)
            @x = x
            @y = y
        return