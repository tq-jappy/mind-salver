# 直線初期状態
class ConnectorNormalState extends AbstractState
    constructor: (@canvas, @data) ->
        @target = null

    onMouseDown: (x, y) ->
        item = @data.getItemAt(x, y)
        if item
            connector = new Connector(item)
            @data.addConnector(connector)
            @canvas.transit(new ConnectorDrawingState(@canvas, @data, connector))

    onMouseMove: (x, y) ->
        item = @data.getItemAt(x, y)

        if @target?
            @data.unfocus(@target)

        if item?
            @data.focus(item)
            @target = item