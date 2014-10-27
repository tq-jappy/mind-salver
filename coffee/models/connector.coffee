# コネクタ
class Connector
    constructor: (@from) ->
        # オブジェクトの右端に始点を置く
        @x1 = @from.left + (@from.currentWidth / 2)
        @y1 = @from.top
        log "add connector #{@x1}, #{@y1}"
        @fabricObject = new fabric.Line([@x1, @y1, @x1, @y1], {
          stroke: 'blue',
          fill: 'green',
          strokeWidth: 2
        })
        @from.outgoings.push(@fabricObject)

    stroke: (@x, @y) ->
        @fabricObject.set({x1: @x1, y1: @y1, x2: @x, y2: @y})

    connect: (@to) ->
        # オブジェクトの左端に終点を置く
        x = @to.left - (@to.currentWidth / 2)
        y = @to.top
        @to.incomings.push(@fabricObject)
        @fabricObject.set({x1: @x1, y1: @y1, x2: x, y2: y})
