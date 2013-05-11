class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        log "create Canvas."
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @drawer = new Drawer(@ctx, @cell)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @data = new CanvasData(@cell, @width, @height)
        @handlers = {
            explorer: new CanvasEventExplorer(@data)
        }
        @handler = @handlers.explorer

        @grid = true

    # 初期処理
    init: () ->
        log "init canvas."

        # イベントをバインド
        @$canvas.mousedown (e) =>
            [x, y] = @getEventPoint(e)
            if @handler.onDown(x, y)
                @draw()
            return false
        @$canvas.mouseup (e) =>
            [x, y] = @getEventPoint(e)
            if @handler.onUp(x, y)
                @draw()
            return false
        @$canvas.mouseleave (e) =>
            [x, y] = @getEventPoint(e)
            if @handler.onUp(x, y)
                @draw()
            return false
        @$canvas.mousemove (e) =>
            [x, y] = @getEventPoint(e)
            if @handler.onMove(x, y)
                @draw()
            return false

    # Canvas 自身のオプションを更新する
    update: (options={grid: true}) ->
        @grid = options.grid
        @data.grid = options.grid

        @data.updateAll()

    # イベントが起こった座標をキャンバスの左上を (0,0) として取得
    getEventPoint: (e) ->
        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        return [cx, cy]

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
