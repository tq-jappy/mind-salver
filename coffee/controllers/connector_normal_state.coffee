# 直線初期状態
class ConnectorNormalState extends AbstractState
    constructor: (@canvas, @data) ->
        @target = null

    onMouseMove: (x, y) ->
        item = @data.getItemAt(x, y)

        if @target?
            @data.unfocus(@target)

        if item?
            @data.focus(item)
            @target = item

    onMouseDown: (x, y) ->
        item = @data.getItemAt(x, y)
        if item
            line = @data.lineStart(x, y)
            @canvas.transit(new ConnectorDrawingState(@canvas, @data, line))