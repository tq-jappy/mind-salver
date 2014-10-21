# 曲線始点選択状態
class FreeLineNormalState extends AbstractState
    constructor: (@canvas, @data) ->

    onMouseDown: (event) ->
        line = @data.lineStart(event.e.offsetX, event.e.offsetY)
        @canvas.transit(new FreeLineDrawingState(@canvas, @data, line))