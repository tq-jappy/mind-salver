class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        console.log "create Canvas."
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @drawer = new Drawer(@ctx, @cell)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top

        @items = []
        @grid = true
        @state = {drag: false, holder: null}

    # 初期処理
    init: () ->
        console.log "init canvas."

        @items.length = 0
        @state = {drag: false, holder: null}

        x = @cell.halfWidth
        y = @cell.halfHeight

        # イベントをバインド
        @$canvas.mousedown (e) =>
            [x, y] = @getEventPoint(e)
            @takeItem(x, y)
            return false
        @$canvas.mouseup (e) =>
            [x, y] = @getEventPoint(e)
            @putItem(x, y)
            return false
        @$canvas.mouseleave (e) =>
            [x, y] = @getEventPoint(e)
            @putItem(x, y)
            return false
        @$canvas.mousemove (e) =>
            [x, y] = @getEventPoint(e)
            @moveItem(x, y)
            return false

    update: (options={grid: true}) ->
        console.log "update"
        @grid = options.grid
        @state = {drag: false, holder: null}
        if @grid
            for item in @items
                p = @getClosestAvailablePoint(item.x, item.y)
                item.update(p.x, p.y)

    # x, y 座標は適切な位置に調整してアイテムを追加
    addItem: (item) ->
        p = @getClosestAvailablePoint(item.x, item.y)
        item.update(p.x, p.y)

        @items.push item

    # 一番近い有効な (x, y) を計算
    getClosestAvailablePoint: (x, y) ->
        x = round(x, 0, @width)
        y = round(y, 0, @height)
        p = if @grid then @closestCenterPoint(x, y) else {x: x, y: y}
        return p

    # イベントが起こった座標をキャンバスの左上を (0,0) として取得
    getEventPoint: (e) ->
        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        return [cx, cy]

    # 指定した (x, y) にあるアイテムをドラッグ可能状態にする
    takeItem: (x, y) ->
        return if @state.drag

        item = @getItemAt(x, y)
        if item?
            @state.drag = true
            @state.holder = item

        # debug
        # a = ({x: item.x, y: item.y} for item in @items when item.shape isnt "triangle")
        # console.log a

    # 指定した (x, y) にアイテムを置く
    putItem: (x, y) ->
        return unless @state.drag

        target = @state.holder
        return unless target?

        p = @getClosestAvailablePoint(x, y)
        target.update(p.x, p.y)
        @draw()

        @state.drag = false
        @state.holder = null

        return

    # ドラッグ中のアイテムを (x, y) に移動する
    moveItem: (x, y) ->
        return unless @state.drag

        target = @state.holder
        return unless target?

        fpp = 3 # frames per pixel (何px動いたら画面更新するか)
        if (Math.abs(x - target.x) >= fpp || Math.abs(y - target.y) >= fpp)
            target.update(x, y)
            @draw()
        return

    # 一番近い x, y を返す
    closestCenterPoint: (x, y) ->
        xr = x % @cell.width
        dx = if (xr < @cell.halfWidth) then (@cell.halfWidth - xr) else (@cell.halfWidth - xr)
        x += dx

        yr = y % @cell.height
        dy = if (yr < @cell.halfHeight) then (@cell.halfHeight - yr) else (@cell.halfHeight - yr)
        y += dy

        x -= @cell.width if x > @width
        y -= @cell.height if y > @height

        return {x: x, y: y}

    # 指定した位置にあるアイテムを取得
    getItemAt: (x, y) ->
        dx = @cell.halfWidth
        dy = @cell.halfHeight
        for item in @items
            if isPointInArea(x, y, item.x, item.y, dx, dy)
                return item
        return null

    # 画面表示
    draw: () ->
        console.log "draw"
        @drawer.clean(@width, @height, @grid)

        for item in @items
            switch item.shape
                when "circle"
                    @drawer.drawCircle(item.x, item.y)
                when "triangle"
                    @drawer.drawTriangle(item.x, item.y)
                when "rectangle"
                    @drawer.drawRectangle(item.x, item.y)
            @drawer.drawText("aaa", item.x, item.y)
