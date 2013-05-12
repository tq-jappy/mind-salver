# ペイント初期状態
class PaintNormalState extends AbstractState
    constructor: (@canvas, @data) ->

    onMouseDown: (x, y) ->
        line = @data.lineStart(x, y)
        @canvas.transit(new PaintDrawingState(@canvas, @data, line))