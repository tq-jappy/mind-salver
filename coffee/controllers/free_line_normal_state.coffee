# 曲線始点選択状態
class FreeLineNormalState extends AbstractState
    constructor: (@canvas, @data) ->

    onMouseDown: (x, y) ->
        line = @data.lineStart(x, y)
        @canvas.transit(new FreeLineDrawingState(@canvas, @data, line))