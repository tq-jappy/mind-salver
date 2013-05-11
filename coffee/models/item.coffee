class Item
    constructor: (@x, @y, @shape) ->
        @text = "ABC"
        @update(@x, @y)

    # 元に戻すために保持
    save: () ->
        @saveX = @x
        @saveY = @y

    # 元に戻す
    restore: () ->
        if @saveX? and @saveY?
            @update(@saveX, @saveY)
            @saveX = null
            @saveY = null

    # 異動確定時に保持していた値をクリア
    clear: () ->
        @saveX = null
        @saveY = null

    update: (@x, @y) ->
        # 衝突判定用の矩形領域も更新
        @cornerPoint = {cx1: @x-10, cy1: @y-10, cx2: @x+10, cy2: @y+10}

    # 他のアイテムとの衝突判定
    isHit: (other) ->
        if (@cornerPoint.cx1 < other.cornerPoint.cx2 and other.cornerPoint.cx1 < @cornerPoint.cx2 and @cornerPoint.cy1 < other.cornerPoint.cy2 and other.cornerPoint.cy1 < @cornerPoint.cx2)
            return true
        else
            return false
