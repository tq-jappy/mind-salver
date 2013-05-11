# ペイント時の軌道
class PaintTrace
    constructor: (x, y) ->
        @points = []
        @points.push {x:x, y:y}

    addPoint: (x, y) ->
        @points.push {x:x, y:y}