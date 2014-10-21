# 曲線描画状態
class FreeLineDrawingState extends AbstractState
    constructor: (@canvas, @data, @line) ->

    onMouseUp: (event) ->
        @data.lineEnd(@line, event.e.offsetX, event.e.offsetY)
        @canvas.transit(new FreeLineNormalState(@canvas, @data))

    onMouseMove: (event) ->
        @data.lineKeep(@line, event.e.offsetX, event.e.offsetY)