# 直線初期状態
class ConnectorNormalState extends AbstractState
    constructor: (@app, @canvas, @data) ->
        @target = null

    onMouseDown: (event) ->
        # item = @data.getItemAt(event.e.offsetX, event.e.offsetY)
        item = event.target
        if item
            connector = new Connector(item)
            @data.addConnector(connector)
            @app.transit(new ConnectorDrawingState(@app, @canvas, @data, connector))

    onMouseMove: (event) ->
        item = event.target

        # if @target?
            # @data.unfocus(@target)

        # if item?
            # @data.focus(item)
            # @target = item