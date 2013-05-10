# デバッグ用
hello = ->
    console.log "hello"
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