class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        console.log "create Canvas. #{@width} : #{@height}"
        @items = []
        @gridWidth = 30               # グリッド間隔(px)
        @gridWidthHalf = @gridWidth/2 # グリッド間隔の半分
        @drawer = new Drawer(@ctx)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @state = {dragging: false, holder: null}
        console.log "OK."

    # 初期処理
    init: () ->
        console.log Canvas.type
        x = @gridWidthHalf
        y = @gridWidthHalf

        @items.push new Item(x, y, @drawer.drawCircle)
        y += @gridWidth
        @items.push new Item(x, y, @drawer.drawTriangle)
        y += @gridWidth
        @items.push new Item(x, y, @drawer.drawSquare)
        console.log @items

        # イベントをバインド
        @$canvas.mousedown (e) =>
            @onMousedown(e)
        @$canvas.mouseup (e) =>
            @onMouseup(e)
        @$canvas.mouseleave (e) =>
            @onMouseup(e)
        @$canvas.mousemove (e) =>
            @onMousemove(e)

    onMousedown: (e) ->
        return false if @state.dragging

        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        item = @getItemAt(cx, cy)
        if item?
            @state.dragging = true
            @state.holder = item
        return false

    onMouseup: (e) ->
        return false unless @state.dragging

        target = @state.holder
        return false unless target?

        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        cx = @round(cx, 0, @width)
        cy = @round(cy, 0, @height)
        # 中心にセット
        p = @closestCenterPoint(cx, cy)
        target.x = p.x
        target.y = p.y
        @draw()

        @state.dragging = false
        @state.holder = null

        return false

    # 一番近い x, y を返す
    closestCenterPoint: (x, y) ->
        xr = x % @gridWidth
        dx = if (xr < @gridWidthHalf) then (@gridWidthHalf - xr) else (@gridWidthHalf - xr)
        x += dx

        yr = y % @gridWidth
        dy = if (yr < @gridWidthHalf) then (@gridWidthHalf - yr) else (@gridWidthHalf - yr)
        y += dy

        return {x: x, y: y}

    # n が min 以上 max 以下の範囲になるように丸める(ユーティリティ)
    round: (n, min, max) ->
        if n < min
            return min
        if n > max
            return max
        return n

    onMousemove: (e) ->
        return false unless @state.dragging

        target = @state.holder
        return false unless target?

        cx = e.pageX - @offsetX
        cy = e.pageY - @offsetY
        fpp = 3 # frames per pixel (何px動いたら画面更新するか)
        if (Math.abs(cx - target.x) >= fpp || Math.abs(cy - target.y) >= fpp)
            target.x = cx
            target.y = cy
            @draw()

        return false

    getItemAt: (x, y) ->
        d = @gridWidthHalf
        for item in @items
            if ((item.x - d <= x <= item.x + d) && (item.y - d <= y <= item.y + d))
                return item
        return null

    hoge: (e) ->
        console.log "#{e.pageX} : #{e.pageY}"

    # 画面表示
    draw: () ->
        console.log "draw"
        @drawer.clearGrid(@width, @height)
        for item in @items
            item.drawer(item.x, item.y)

