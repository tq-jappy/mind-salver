# 曲線描画状態
class FreeLineDrawingState extends AbstractState
    constructor: (@canvas, @data, @line) ->

    onMouseUp: (x, y) ->
        @data.lineEnd(@line, x, y)
        @canvas.transit(new FreeLineNormalState(@canvas, @data))

    onMouseMove: (x, y) ->
        @data.lineKeep(@line, x, y)