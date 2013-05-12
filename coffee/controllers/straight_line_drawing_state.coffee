# 直線描画状態
class StraightLineDrawingState extends AbstractState
    constructor: (@canvas, @data, @line) ->

    onMouseUp: (x, y) ->
        @canvas.transit(new StraightLineNormalState(@canvas, @data))

    onMouseMove: (x, y) ->
        @data.lineExpand(@line, x, y)