class CanvasData
    constructor: () ->
        @items = []

    init: () ->
        @items.length = 0
        return

    # x, y 座標は適切な位置に調整してアイテムを追加
    addItem: (item) ->
        @items.push item
        return
