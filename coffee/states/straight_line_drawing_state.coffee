# 直線描画状態
class StraightLineDrawingState extends AbstractState
    constructor: (@canvas, @data, @line) ->

    onMouseUp: (event) ->
        @canvas.transit(new StraightLineNormalState(@canvas, @data))

    onMouseMove: (event) ->
        @data.lineExpand(@line, event.e.offsetX, event.e.offsetY)