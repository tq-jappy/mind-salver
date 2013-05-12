# Canvas のメインコントローラ
class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        log "create Canvas."
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @view = new CanvasView(@ctx, @cell, @offsetX, @offsetY)
        @data = new CanvasData(@view, @cell, @width, @height)
        @grid = true

    transit: (@state) ->
        console.log "transit to #{@state}"

    # 初期処理
    init: () ->
        log "init canvas."
        @state = new NormalState(@, @data)

        # イベントをバインド
        @$canvas.parent().dblclick (e) =>
            [x, y] = @getEventPoint(e)
            @state.onDblClick(x, y)
            return false
        @$canvas.parent().mousedown (e) =>
            [x, y] = @getEventPoint(e)
            @state.onMouseDown(x, y)
            return false
        @$canvas.parent().mouseup (e) =>
            [x, y] = @getEventPoint(e)
            @state.onMouseUp(x, y)
            return false
        @$canvas.parent().mouseleave (e) =>
            [x, y] = @getEventPoint(e)
            @state.onMouseUp(x, y)
            return false
        @$canvas.parent().mousemove (e) =>
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

