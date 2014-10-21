# 直線初期状態
class StraightLineNormalState extends AbstractState
    constructor: (@canvas, @data) ->

    onMouseDown: (event) ->
        line = @data.lineStart(event.e.offsetX, event.e.offsetY)
        @canvas.transit(new StraightLineDrawingState(@canvas, @data, line))
