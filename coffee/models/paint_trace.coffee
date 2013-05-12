# ペイント時の軌道
class PaintTrace
    constructor: (x, y) ->
        @points = []
        @addPoint(x, y)

    addPoint: (x, y) ->
        @points.push {x:x, y:y}