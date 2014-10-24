# アイテム移動中の状態
class ItemMovingState extends AbstractState
    constructor: (@app, @canvas, @data, @item) ->
      log "moving!"
      log @item

    onMouseUp: (event) ->
        # @data.putItem(@item, event.e.offsetX, event.e.offsetY)
        # @app.itemPropertyViewModel.update(@item)
        [x, y] = [event.e.offsetX, event.e.offsetY]
        # setCoords を呼び出してプロパティを更新する
        @item.set({left: x, top: y}).setCoords()
        @canvas.renderAll()

        @app.transit(new NormalState(@app, @canvas, @data))

    # ドラッグ中のアイテムを (x, y) に移動する
    onMouseMove: (event) ->
        [x, y] = [event.e.offsetX, event.e.offsetY]
        # @item.set({left: x, top: y})
        @item.setLeft(x).setTop(y)
        @canvas.renderAll()
        # fpp = 1 # frames per pixel (何px動いたら画面更新するか)
        # if (Math.abs(x - @item.x) >= fpp || Math.abs(y - @item.y) >= fpp)
            # @data.moveItem(@item, x, y)
            # @app.itemPropertyViewModel.update(@item)

        return