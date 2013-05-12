# デバッグ用
hello = ->
    console.log "hello"
    return

log = (message) ->
    console.log message
    return

warn = (message) ->
    alert message
    return

# n が min 以上 max 以内の範囲になるように変換して返す。
round = (n, min, max) ->
    if n < min
        return min
    if n > max
        return max
    return n

# 座標(x, y) が (targetX, targetY) を中心とする矩形領域の中に含まれるか調べる。
isPointInArea = (x, y, targetX, targetY, deltaX, deltaY) ->
    if ((targetX - deltaX <= x <= targetX + deltaX) && (targetY - deltaY <= y <= targetY + deltaY))
        return true
    else
        return false

# 当たり判定
isHit = (x1, y1, w1, h1, x2, y2, w2, h2) ->
    if \
    (x1 - w1 < x2 + w2) and
    (x1 + w1 > x2 - w2) and
    (y1 - h1 < y2 + h2) and
    (y1 + h1 > y2 - h2)
        return true
    else
        return false