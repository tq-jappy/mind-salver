# 直線初期状態
class StraightLineNormalState extends AbstractState
    constructor: (@canvas, @data, @line) ->

    onMouseDown: (x, y) ->
        line = @data.lineStart(x, y)
        @canvas.transit(new StraightLineDrawingState(@canvas, @data, line))