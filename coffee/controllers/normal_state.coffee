# 通常状態
class NormalState extends AbstractController
    constructor: (@canvas, @data) ->

    onMouseDown: (x, y) ->
        item = @data.getItemAt(x, y)
        return unless item?

        item.save()
        @canvas.transit(new ItemSelectedState(@canvas, @data, item))
        return

