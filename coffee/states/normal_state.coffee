# 通常状態
class NormalState extends AbstractState
    constructor: (@app, @canvas, @data) ->

    onMouseDown: (event) ->
        item = event.target

        if item?
            # item = @data.findBy(fabricObject)
            # @app.itemPropertyViewModel.update(item)
            # item.saveCurrentPosition()
            @app.transit(new ItemSelectedState(@app, @canvas, @data, item))
        # else
        #     @canvas.itemPropertyViewModel.reset()
        #     @canvas.transit(new AreaMovingState(@canvas, @data, x, y))
        return

