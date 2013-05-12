# ペイント時の軌道
class PaintTrace
    constructor: (@view, x, y) ->
        @points = []
        @addPoint(x, y)

    addPoint: (x, y) ->
        @points.push {x:x, y:y}