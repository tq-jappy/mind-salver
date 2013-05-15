# アイテム移動中の状態
class ItemMovingState extends AbstractState
    constructor: (@canvas, @data, @item) ->

    onMouseUp: (x, y) ->
        @data.putItem(@item, x, y)
        @canvas.transit(new NormalState(@canvas, @data))

    # ドラッグ中のアイテムを (x, y) に移動する
    onMouseMove: (x, y) ->
        fpp = 1 # frames per pixel (何px動いたら画面更新するか)
        if (Math.abs(x - @item.x) >= fpp || Math.abs(y - @item.y) >= fpp)
            @data.moveItem(@item, x, y)

        return