# 直線初期状態
class ConnectorNormalState extends AbstractState
    constructor: (@canvas, @data) ->
        @target = null

    onMouseDown: (event) ->
        item = @data.getItemAt(event.e.offsetX, event.e.offsetY)
        if item
            connector = new Connector(item)
            @data.addConnector(connector)
            @canvas.transit(new ConnectorDrawingState(@canvas, @data, connector))

    onMouseMove: (event) ->
        item = @data.getItemAt(event.e.offsetX, event.e.offsetY)

        if @target?
            @data.unfocus(@target)

        if item?
            @data.focus(item)
            @target = item