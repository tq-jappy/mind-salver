class CanvasViewModel
    constructor: (@app) ->
        log "create CanvasViewModel"
        @canvas = @app.canvas
        @x = ko.observable("")
        @y = ko.observable("")
        console.log "canvas"
        console.log @canvas

        # フォーカスされているオブジェクトのみ色を変更
        @canvas.on 'mouse:over', (e) =>
          e.target.setFill('red')
          @canvas.renderAll()
        @canvas.on 'mouse:out', (e) =>
          e.target.setFill('green')
          @canvas.renderAll()

        @canvas.on 'object:selected', (e) =>
          # TODO: not implemented
          log "selected"

        @canvas.on 'object:moving', (e) =>
          # TODO: not implemented
          target = e.target
          log "moving"

        @canvas.on 'object:modified', (e) =>
          # TODO not implemented
          log "modified"
          e.target.set(
            left: Math.round(e.target.left / 50) * 50,
            top: Math.round(e.target.top / 30) * 30
          )
          @canvas.renderAll()

    onDblClick: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @app.state.onDblClick(x, y)
        return false

    onMouseDown: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @app.state.onMouseDown(x, y)
        return false

    onMouseUp: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @app.state.onMouseUp(x, y)
        return false

    onMouseLeave: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @app.state.onMouseLeave(x, y)
        return false

    onMouseMove: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @app.state.onMouseMove(x, y)
        return false

    getEventPoint: (e) ->
        cx = e.pageX - @app.offsetX
        cy = e.pageY - @app.offsetY
        @x(cx)
        @y(cy)
        return [cx, cy]