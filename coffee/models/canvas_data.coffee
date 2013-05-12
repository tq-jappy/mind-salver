# Canvas 内のデータを管理するクラス
class CanvasData
    constructor: (@view, @cell, @canvasWidth, @canvasHeight, @grid=true) ->
        @items = []
        @currentPaintTrace = null
        @paintTraces = []
        log "data init."

    lineStart: (x, y) ->
        # TODO: このクラス（モデル）側で状態管理してしまっているのがいけてない
        @currentPaintTrace = new PaintTrace(x, y)
        @paintTraces.push(@currentPaintTrace)
        @view.draw(@)
        return

    lineEnd: (x, y) ->
        if @currentPaintTrace?
            @currentPaintTrace.addPoint(x, y)
            @currentPaintTrace = null
        @view.draw(@)
        return

    lineKeep: (x, y) ->
        if @currentPaintTrace?
            @currentPaintTrace.addPoint(x, y)
        @view.draw(@)
        return

    # 全てのアイテムを更新
    updateAll: () ->
        for item in @items
            @putItem(item, item.x, item.y)

    # アイテムを追加
    addItem: (item) ->
        @putItem(item, item.x, item.y)
        @items.push item
        @view.draw(@)
        return

    # x, y 座標を調整しつつアイテムを更新
    moveItem: (item, x, y) ->
        @view.draw(@) if item.x isnt x or item.y isnt y
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
            @view.draw(@)
        else if item.x isnt x or item.y isnt y
            item.update(x, y)
            @view.draw(@)
            item.clear()

        return

    # 重なる場合
    detectHit: (x, y, item) ->
        for other in @items
            if item.shape isnt other.shape # 判定は自分以外のものと行う
                # 衝突判定
                if (isHit(x, y, item.w, item.h, other.x, other.y, other.w, other.h))
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