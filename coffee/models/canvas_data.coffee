class CanvasData
    constructor: (@cell, @canvasWidth, @canvasHeight, @grid=true) ->
        @items = []
        @paintTraces = []
        log "data init."

    init: () ->
        @items.length = 0
        @paintTraces.length = 0
        return

    # 全てのアイテムを更新
    updateAll: () ->
        for item in @items
            @updateItem(item, item.x, item.y)

    # アイテムを追加
    addItem: (item) ->
        @updateItem(item, item.x, item.y)
        @items.push item
        return

    # x, y 座標を調整しつつアイテムを更新
    updateItem: (item, x, y) ->
        if @grid
            p = @getClosestAvailablePoint(x, y)
            x = p.x
            y = p.y
        else
            # 重なる場合
            for other in @items
                if item.shape isnt other.shape
                    # 衝突判定
                    if (item.isHit(other))
                        item.restore()
                        return

        item.update(x, y)
        item.clear()
        return

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