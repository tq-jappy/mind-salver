# 直線描画状態
class ConnectorDrawingState extends AbstractState
    constructor: (@canvas, @data, @connector) ->

    onMouseUp: (event) ->
        item = @data.getItemAt(event.e.offsetX, event.e.offsetY)

        if item?
            # アイテムがあれば結ぶ
            @connector.connect(item)
        else
            @data.clearConnector(@connector)
        @canvas.transit(new ConnectorNormalState(@canvas, @data))

    onMouseMove: (event) ->
        [x, y] = [event.e.offsetX, event.e.offsetY]
        @connector.stroke(x, y)

        # 終点になり得るアイテムに focus。それ以外は unfocus
        item = @data.getItemAt(x, y)

        if @prevFocusedItem?
            @data.unfocus(@prevFocusedItem)

        if item?
            @data.focus(item)
            @prevFocusedItem = item