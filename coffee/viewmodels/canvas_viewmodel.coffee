class CanvasViewModel
    constructor: (@app) ->
        log "create CanvasViewModel"
        @x = ko.observable("")
        @y = ko.observable("")

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