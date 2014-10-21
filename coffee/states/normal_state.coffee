# 通常状態
class NormalState extends AbstractState
    constructor: (@canvas, @data) ->

    onMouseDown: (event) ->
        item = @data.getItemAt(event.e.offsetX, event.e.offsetY)

        if item?
            @canvas.itemPropertyViewModel.update(item)
            item.saveCurrentPosition()
            @canvas.transit(new ItemSelectedState(@canvas, @data, item))
        # else
        #     @canvas.itemPropertyViewModel.reset()
        #     @canvas.transit(new AreaMovingState(@canvas, @data, x, y))
        return

