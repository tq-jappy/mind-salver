class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        console.log "create Canvas."
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @drawer = new Drawer(@ctx, @cell)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @data = new CanvasData(@cell, @width, @height)

        @grid = true
        @state = {drag: false, holder: null}

    # 初期処理
    init: () ->
        console.log "init canvas."

        @state = {drag: false, holder: null}

        # イベントをバインド
        @$canvas.mousedown (e) =>
            [x, y] = @getEventPoint(e)
            @onDown(x, y)
            return false
        @$canvas.mouseup (e) =>
            [x, y] = @getEventPoint(e)
            @onUp(x, y)
            return false
        @$canvas.mouseleave (e) =>
            [x, y] = @getEventPoint(e)
            @onUp(x, y)
            return false
        @$canvas.mousemove (e) =>
            [x, y] = @getEventPoint(e)
            @onMove(x, y)
            return false

    update: (options={grid: true}) ->
        console.log "update"
        @grid = options.grid
        @data.grid = options.grid
        @state = {drag: false, holder: null}

        @data.updateAll()

    # イベントが起こった座標をキャンバスの左上を (0,0) として取得
    getEventPoint: (e) ->
        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        return [cx, cy]

    onDown: (x, y) ->
        return if @state.drag

        item = @data.getItemAt(x, y)
        if item?
            @state.drag = true
            @state.holder = item

    # 指定した (x, y) にアイテムを置く
    onUp: (x, y) ->
        return unless @state.drag

        target = @state.holder
        return unless target?

        @data.updateItem(target, x, y)
        @draw()

        @state.drag = false
        @state.holder = null

        return

    # ドラッグ中のアイテムを (x, y) に移動する
    onMove: (x, y) ->
        return unless @state.drag

        target = @state.holder
        return unless target?

        fpp = 3 # frames per pixel (何px動いたら画面更新するか)
        if (Math.abs(x - target.x) >= fpp || Math.abs(y - target.y) >= fpp)
            target.update(x, y)
            @draw()
        return

    # 画面表示
    draw: () ->
        console.log "draw"
        @drawer.clean(@width, @height, @grid)

        for item in @data.items
            switch item.shape
                when "circle"
                    @drawer.drawCircle(item.x, item.y)
                when "triangle"
                    @drawer.drawTriangle(item.x, item.y)
                when "rectangle"
                    @drawer.drawRectangle(item.x, item.y)
            @drawer.drawText(item.text, item.x, item.y)
