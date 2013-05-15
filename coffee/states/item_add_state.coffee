# アイテム追加時の初期状態
class ItemAddState extends AbstractState
    constructor: (@canvas, @data, @shape) ->

    onMouseDown: (x, y) ->
        item = new Item(x, y, 1, 1, @shape)
        @data.addItem(item)