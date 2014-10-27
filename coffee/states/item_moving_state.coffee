# アイテム移動中の状態
class ItemMovingState extends AbstractState
    constructor: (@app, @canvas, @data, @item) ->
      log "moving!"
      log @item

    onMouseUp: (event) ->
        # @data.putItem(@item, event.e.offsetX, event.e.offsetY)
        # @app.itemPropertyViewModel.update(@item)
        [x, y] = [event.e.offsetX, event.e.offsetY]

        # TODO: move connectors

        # setCoords を呼び出してプロパティを更新する
        w = @data.cell.width
        x = Math.floor(x / w) * w + (w / 2)
        h = @data.cell.height
        y = Math.floor(y / h) * h + (h / 2)
        @item.set({left: x, top: y}).setCoords()
        @canvas.renderAll()

        @app.transit(new NormalState(@app, @canvas, @data))

    # ドラッグ中のアイテムを (x, y) に移動する
    onMouseMove: (event) ->
        [x, y] = [event.e.offsetX, event.e.offsetY]
        # @item.set({left: x, top: y})
        @item.setLeft(x).setTop(y)

        # move connectors
        for connector in (@item.outgogings ? [])
            connector.set({ 'x1': x + (@item.currentWidth / 2), 'y1': y });
        for connector in (@item.incomings ? [])
            connector.set({ 'x2': x - (@item.currentWidth / 2), 'y2': y })

        @canvas.renderAll()
        # fpp = 1 # frames per pixel (何px動いたら画面更新するか)
        # if (Math.abs(x - @item.x) >= fpp || Math.abs(y - @item.y) >= fpp)
            # @data.moveItem(@item, x, y)
            # @app.itemPropertyViewModel.update(@item)

        return