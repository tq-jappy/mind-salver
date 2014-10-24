# コネクタ
class Connector
    constructor: (@from) ->
        @x1 = @from.top
        @y1 = @from.left
        log "add connector #{@x1}, #{@y1}"
        @fabricObject = new fabric.Line([@x1, @y1, @x1, @y1], {
          stroke: 'blue',
          fill: 'green',
          strokeWidth: 2
        })

    stroke: (@x, @y) ->
        @fabricObject.set({x1: @x1, y1: @y1, x2: @x, y2: @y})

    connect: (@to) ->
        @fabricObject.set({x1: @x1, y1: @y1, x2: @to.top, y2: @to.left})
