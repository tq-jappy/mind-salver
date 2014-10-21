# アイテム選択直後の状態
class ItemSelectedState extends AbstractState
    constructor: (@canvas, @data, @item) ->

    onMouseUp: (event) ->
        @canvas.transit(new NormalState(@canvas, @data))

    onMouseMove: (event) ->
        @canvas.transit(new ItemMovingState(@canvas, @data, @item))