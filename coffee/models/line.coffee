# 線
class Line
    constructor: (x, y) ->
        @points = [] # 描画用の端点の配列（直線は始点と終点の2つだけど、フリーハンドは3つ以上になる）
        @addPoint(x, y)
        @addPoint(x, y)

    addPoint: (x, y) ->
        p = {x:x, y:y}
        @points.push p
        @last = p

    updateLastPoint: (x, y) ->
        @last.x = x
        @last.y = y