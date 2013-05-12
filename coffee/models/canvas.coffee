class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        log "create Canvas."
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @view = new CanvasView(@ctx, @cell)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @data = new CanvasData(@cell, @width, @height)
        @handlers = {
            explorer: new CanvasEventExplorer(@data)
            painter: new CanvasEventPainter(@data)
        }
        @handler = "explorer"

        @grid = true

    # 初期処理
    init: () ->
        log "init canvas."
        @data.init()

        # イベントをバインド
        @$canvas.dblclick (e) =>
            [x, y] = @getEventPoint(e)
            if @handlers[@handler].onDblClick(x, y)
                @draw()
            return false
        @$canvas.mousedown (e) =>
            [x, y] = @getEventPoint(e)
            if @handlers[@handler].onMouseDown(x, y)
                @draw()
            return false
        @$canvas.mouseup (e) =>
            [x, y] = @getEventPoint(e)
            if @handlers[@handler].onMouseUp(x, y)
                @draw()
            return false
        @$canvas.mouseleave (e) =>
            [x, y] = @getEventPoint(e)
            if @handlers[@handler].onMouseUp(x, y)
                @draw()
            return false
        @$canvas.mousemove (e) =>
            [x, y] = @getEventPoint(e)
            if @handlers[@handler].onMouseMove(x, y)
                @draw()
            return false

    # Canvas 自身のオプションを更新する
    update: (options={}) ->
        if options.grid?
            @grid = options.grid
            @data.grid = options.grid
            @data.updateAll()

        if options.mode?
            @handler = options.mode
            @handlers[@handler].init()

    # イベントが起こった座標をキャンバスの左上を (0,0) として取得
    getEventPoint: (e) ->
        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        return [cx, cy]

    # 画面表示
    draw: () ->
        log "draw"
        @view.clean(@width, @height, @grid)

        for item in @data.items
            switch item.shape
                when "circle"
                    @view.drawCircle(item.x, item.y)
                when "triangle"
                    @view.drawTriangle(item.x, item.y)
                when "rectangle"
                    @view.drawRectangle(item.x, item.y)
            @view.drawText(item.text, item.x, item.y)

        @view.drawTraceLines(@data.paintTraces)
