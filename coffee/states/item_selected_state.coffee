# アイテム選択直後の状態
class ItemSelectedState extends AbstractState
    constructor: (@canvas, @data, @item) ->

    onMouseUp: (x, y) ->
        @canvas.transit(new NormalState(@canvas, @data))

    onMouseMove: (x, y) ->
        @canvas.transit(new ItemMovingState(@canvas, @data, @item))