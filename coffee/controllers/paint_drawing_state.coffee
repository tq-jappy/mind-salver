# ペイント描画状態
class PaintDrawingState extends AbstractState
    constructor: (@canvas, @data, @line) ->

    onMouseUp: (x, y) ->
        @data.lineEnd(@line, x, y)
        @canvas.transit(new PaintNormalState(@canvas, @data))

    onMouseMove: (x, y) ->
        @data.lineKeep(@line, x, y)