# Canvas のメインコントローラ
class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        log "create Canvas."
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @view = new CanvasView(@ctx, @cell)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @data = new CanvasData(@view, @cell, @width, @height)
        # @handlers = {
        #     explorer: new CanvasEventExplorer(@, @data)
        #     painter: new CanvasEventPainter(@, @data)
        # }
        @handler = "explorer"

        @grid = true

    transit: (@state) ->
        console.log "transit to #{@state}"

    # 初期処理
    init: () ->
        log "init canvas."
        @state = new NormalState(@, @data)

        # イベントをバインド
        @$canvas.dblclick (e) =>
            [x, y] = @getEventPoint(e)
            @state.onDblClick(x, y)
            return false
        @$canvas.mousedown (e) =>
            [x, y] = @getEventPoint(e)
            @state.onMouseDown(x, y)
            return false
        @$canvas.mouseup (e) =>
            [x, y] = @getEventPoint(e)
            @state.onMouseUp(x, y)
            return false
        @$canvas.mouseleave (e) =>
            [x, y] = @getEventPoint(e)
            @state.onMouseUp(x, y)
            return false
        @$canvas.mousemove (e) =>
            [x, y] = @getEventPoint(e)
            @state.onMouseMove(x, y)
            return false

    # Canvas 自身のオプションを更新する
    update: (options={}) ->
        if options.grid?
            @grid = options.grid
            @data.grid = options.grid
            @data.updateAll()

        @view.draw(@data)

    # イベントが起こった座標をキャンバスの左上を (0,0) として取得
    getEventPoint: (e) ->
        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        return [cx, cy]

