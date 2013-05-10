class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        console.log "create Canvas. #{@width} : #{@height}"
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @drawer = new Drawer(@ctx, @cell)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top

        @items = []
        @grid = true
        @state = {drag: false, holder: null}

    # 初期処理
    init: (options={grid: true}) ->
        console.log "init canvas."
        console.log options

        @items.length = 0
        @grid = options.grid
        @state = {drag: false, holder: null}

        x = @cell.halfWidth
        y = @cell.halfHeight

        @items.push new Item(x, y, @drawer.drawCircle)
        y += @cell.height
        @items.push new Item(x, y, @drawer.drawTriangle)
        y += @cell.height
        @items.push new Item(x, y, @drawer.drawSquare)
        console.log @items

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

    # 指定した (x, y) にアイテムを置く
    putItem: (x, y) ->
        return unless @state.drag

        target = @state.holder
        return unless target?

        x = @round(x, 0, @width)
        y = @round(y, 0, @height)
        p = if @grid then @closestCenterPoint(x, y) else {x: x, y: y}
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

    # n が min 以上 max 以下の範囲になるように丸める(ユーティリティ)
    round: (n, min, max) ->
        if n < min
            return min
        if n > max
            return max
        return n

    # 指定した位置にあるアイテムを取得
    getItemAt: (x, y) ->
        dx = @cell.halfWidth
        dy = @cell.halfHeight
        for item in @items
            if ((item.x - dx <= x <= item.x + dx) && (item.y - dy <= y <= item.y + dy))
                return item
        return null

    # 画面表示
    draw: () ->
        console.log "draw"
        @drawer.clean(@width, @height, @grid)
        for item in @items
            item.drawer(item.x, item.y)

