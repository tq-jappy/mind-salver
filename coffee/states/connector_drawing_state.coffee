# 直線描画状態
class ConnectorDrawingState extends AbstractState
    constructor: (@app, @canvas, @data, @connector) ->

    onMouseUp: (event) ->
        item = event.target

        if item?
            # アイテムがあれば結ぶ
            @connector.connect(item)
        else
            @canvas.remove(@connector.fabricObject)
            @data.clearConnector(@connector)
        @app.transit(new ConnectorNormalState(@app, @canvas, @data))

    onMouseMove: (event) ->
        [x, y] = [event.e.offsetX, event.e.offsetY]
        @connector.stroke(x, y)
        @canvas.renderAll()

        # 終点になり得るアイテムに focus。それ以外は unfocus
        item = @data.getItemAt(x, y)

        if @prevFocusedItem?
            @data.unfocus(@prevFocusedItem)

        if item?
            @data.focus(item)
            @prevFocusedItem = item