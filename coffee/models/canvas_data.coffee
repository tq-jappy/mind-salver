# Canvas 内のデータを管理するクラス
class CanvasData
    constructor: (@canvas, @cell, @grid=true) ->
        @items = []
        @lines = []
        @connectors = []
        @offsetX = 0
        @offsetY = 0
        log "data init."

        # TODO: グリッド情報を作成。こっちで管理するなら、
        # CanvasData という名前が微妙かも。
        lineOptions = { stroke: '#000033', strokeWidth: 1, selectable: false }
        gridLines = []
        for x in [0..@canvas.width / @cell.width]
          _x = x * @cell.width
          line = new fabric.Line([_x, 0, _x, @canvas.height], lineOptions)
          gridLines.push(line)
        for y in [0..@canvas.height / @cell.height]
          _y = y * @cell.height
          line = new fabric.Line([0, _y, @canvas.width, _y], lineOptions)
          gridLines.push(line)

        # @canvas.add(new fabric.Group(gridLines, { left: 5, top: 5 }))
        @canvas.add.apply(@canvas, gridLines)

    focus: (item) ->
        item.focused = true

    moveArea: (dx, dy) ->
        log "moveArea (x, y) = (#{dx}, #{dy})"
        @offsetX += dx
        @offsetY += dy

    unfocus: (item) ->
        item.focused = false

    # Polylineを書き始める
    lineStart: (x, y) ->
        line = new Line(x, y)
        @canvas.add(line.fabricObject)
        log @lines
        @lines.push(line)
        return line

    # Polylineを書き終える
    lineEnd: (line, x, y) ->
        line.addPoint(x, y)
        return

    # Polyline中の最後の設定の位置を変更する
    lineExpand: (line, x, y) ->
        line.updateLastPoint(x, y)
        @canvas.renderAll()
        return

    # Polylineに接点を一つ加える
    lineKeep: (line, x, y) ->
        line.addPoint(x, y)
        return

    lineClear: (line) ->
        line.points = []

        newLines = []
        for line in @lines
            newLines.push(line) if line.points.length > 0
        @lines = newLines
        return

    addConnector: (connector) ->
        @connectors.push connector
        @canvas.add(connector.fabricObject)
        return

    clearConnector: () ->
        @connectors.pop()
        return

    # 全てのアイテムを更新
    updateOptions: (grid) ->
        @grid = grid
        if @grid?
            @cell.paddingX = 5
            @cell.paddingY = 5
        else
            @cell.paddingX = 0
            @cell.paddingY = 0

        for item in @items
            @putItem(item, item.x, item.y)

    # アイテムを追加
    addItem: (item) ->
        if @putItem(item, item.x, item.y)
            @items.push item
            @canvas.add(item.fabricObject)
        else
            warn "cannot add item: #{item.shape}#{item.id}"
        return

    # x, y 座標を調整しつつアイテムを更新
    moveItem: (item, x, y) ->
        item.update(x, y)
        return

    # x, y 座標を調整しつつアイテムを更新
    putItem: (item, x, y) ->
        if @grid
            p = @getClosestAvailablePoint(x, y)
            x = p.x
            y = p.y

        # 衝突判定
        if (@detectHit(x, y, item))
            item.restore()
            return false
        else if item.x isnt x or item.y isnt y
            item.update(x, y)
            item.clear()

        return true

    # 重なる場合
    detectHit: (x, y, item) ->
        for other in @items
            if item.id isnt other.id
                # 衝突判定
                # TODO: item.sizeX, item.sizeY を考慮
                # item が sizeHalfWidth みたいなプロパティをもつようにする
                # w1 = (item.sizeX * @cell.width - (@cell.paddingX * 2)) / 2
                w1 = @cell.halfWidth - @cell.paddingX
                h1 = @cell.halfHeight - @cell.paddingY
                if (isHit(x, y, w1, h1, other.x, other.y, w1, h1))
                    log "item hit (#{other.x}, #{other.y})"
                    return true
        return false

    # 一番近い有効な (x, y) を計算
    getClosestAvailablePoint: (x, y) ->
        x = round(x, 0, @width)
        y = round(y, 0, @height)
        p = if @grid then @closestCenterPoint(x, y) else {x: x, y: y}
        return p

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
        for item in @items
            if isPointInArea(x, y, item.x, item.y, @cell.halfWidth, @cell.halfHeight)
                return item
        return null