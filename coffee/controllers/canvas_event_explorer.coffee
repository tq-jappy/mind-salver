# 移動や表示領域変更時などのイベント処理
class CanvasEventExplorer extends AbstractController
    constructor: (@data) ->
        @init()

    init: () ->
        @state = {drag: false, holder: null}

    onMouseDown: (x, y) ->
        return if @state.drag

        item = @data.getItemAt(x, y)
        if item?
            item.save()
            @state.drag = true
            @state.holder = item
        return

    # 指定した (x, y) にアイテムを置く
    onMouseUp: (x, y) ->
        return unless @state.drag

        target = @state.holder
        return unless target?

        @data.putItem(target, x, y)

        @state.drag = false
        @state.holder = null

    # ドラッグ中のアイテムを (x, y) に移動する
    onMouseMove: (x, y) ->
        return unless @state.drag

        target = @state.holder
        return unless target?

        fpp = 1 # frames per pixel (何px動いたら画面更新するか)
        if (Math.abs(x - target.x) >= fpp || Math.abs(y - target.y) >= fpp)
            @data.moveItem(target, x, y)

        return