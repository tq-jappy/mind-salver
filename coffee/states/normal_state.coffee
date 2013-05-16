# 通常状態
class NormalState extends AbstractState
    constructor: (@canvas, @data) ->

    onMouseDown: (x, y) ->
        item = @data.getItemAt(x, y)

        if item?
            @canvas.itemPropertyViewModel.update(item)
            item.save()
            @canvas.transit(new ItemSelectedState(@canvas, @data, item))
        else
            @canvas.itemPropertyViewModel.reset()
            @canvas.transit(new AreaMovingState(@canvas, @data, x, y))
        return

