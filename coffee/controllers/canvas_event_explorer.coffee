# 移動や表示領域変更時などのイベント処理
class CanvasEventExplorer
    constructor: (@data) ->
        @init()

    init: () ->
        @state = {drag: false, holder: null}

    onDown: (x, y) ->
        return false if @state.drag

        item = @data.getItemAt(x, y)
        if item?
            item.save()
            @state.drag = true
            @state.holder = item
        return false

    # 指定した (x, y) にアイテムを置く
    onUp: (x, y) ->
        return false unless @state.drag

        target = @state.holder
        return false unless target?

        @data.updateItem(target, x, y)

        @state.drag = false
        @state.holder = null

        return true

    # ドラッグ中のアイテムを (x, y) に移動する
    onMove: (x, y) ->
        return false unless @state.drag

        target = @state.holder
        return false unless target?

        fpp = 1 # frames per pixel (何px動いたら画面更新するか)
        if (Math.abs(x - target.x) >= fpp || Math.abs(y - target.y) >= fpp)
            target.update(x, y)
            return true
        else
            return false