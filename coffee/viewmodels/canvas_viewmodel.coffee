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
          # log "moving"

        @canvas.on 'object:modified', (e) =>
          # TODO not implemented
          log "modified"
          e.target.set(
            left: Math.round(e.target.left / 50) * 50,
            top: Math.round(e.target.top / 30) * 30
          )
          @canvas.renderAll()

        @canvas.on 'mouse:up', (e) =>
          @app.state.onMouseUp(e.e.offsetX, e.e.offsetY)
          return false

        @canvas.on 'mouse:down', (e) =>
          @app.state.onMouseDown(e.e.offsetX, e.e.offsetY)
          return false

        @canvas.on 'mouse:move', (e) =>
          @app.state.onMouseMove(e.e.offsetX, e.e.offsetY)
          return false

        # TODO: double click and mouse leave events