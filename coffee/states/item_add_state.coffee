# アイテム追加時の初期状態
class ItemAddState extends AbstractState
    constructor: (@canvas, @data, @shape) ->

    onMouseDown: (event) ->
        item = new Item(event.e.offsetX, event.e.offsetY, 1, 1, @shape)
        @data.addItem(item)