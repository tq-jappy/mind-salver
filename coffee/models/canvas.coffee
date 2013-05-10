class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        console.log "create Canvas. #{@width} : #{@height}"
        @items = []
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15}
        @drawer = new Drawer(@ctx, @cell)
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @state = {dragging: false, holder: null}
        console.log "OK."

    # 初期処理
    init: () ->
        console.log Canvas.type
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
        xr = x % @cell.width
        dx = if (xr < @cell.halfWidth) then (@cell.halfWidth - xr) else (@cell.halfWidth - xr)
        x += dx

        yr = y % @cell.height
        dy = if (yr < @cell.halfHeight) then (@cell.halfHeight - yr) else (@cell.halfHeight - yr)
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
        dx = @cell.halfWidth
        dy = @cell.halfHeight
        for item in @items
            if ((item.x - dx <= x <= item.x + dx) && (item.y - dy <= y <= item.y + dy))
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

