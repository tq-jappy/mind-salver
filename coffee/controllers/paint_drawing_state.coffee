# ペイント描画状態
class PaintDrawingState extends AbstractController
    constructor: (@canvas, @data, @line) ->

    onMouseUp: (x, y) ->
        @data.lineEnd(x, y)
        @canvas.transit(new PaintNormalState(@canvas, @data))

    onMouseMove: (x, y) ->
        @data.lineKeep(x, y)