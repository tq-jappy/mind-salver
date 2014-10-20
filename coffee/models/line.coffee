# 線
class Line
    constructor: (x, y) ->
        @points = [] # 描画用の端点の配列（直線は始点と終点の2つだけど、フリーハンドは3つ以上になる）
        @x1 = x
        @y1 = y
        @fabricObject = new fabric.Line([x, y, x, y], {
          stroke: 'blue',
          fill: 'green',
          strokeWidth: 2
        })

    addPoint: (x, y) ->
        p = {x:x, y:y}
        @points.push p
        @last = p

    updateLastPoint: (x, y) ->
        @fabricObject.set({x1: @x1, y1: @y1, x2: x, y2: y})