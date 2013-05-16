class AreaMovingState extends AbstractState
    constructor: (@canvas, @data, @x, @y) ->

    onMouseUp: (x, y) ->
        @canvas.transit(new NormalState(@canvas, @data))

    # 表示領域を移動
    onMouseMove: (x, y) ->
        fpp = 1 # frames per pixel (何px動いたら画面更新するか)
        if (Math.abs(x - @x) >= fpp || Math.abs(y - @y) >= fpp)
            @data.moveArea(x - @x, y - @y)
        return