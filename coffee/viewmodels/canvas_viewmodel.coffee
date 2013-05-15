class CanvasViewModel
    constructor: (@canvas) ->
        log "create CanvasViewModel"
        @x = ko.observable("")
        @y = ko.observable("")

    onDblClick: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @canvas.state.onDblClick(x, y)
        return false

    onMouseDown: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @canvas.state.onMouseDown(x, y)
        return false

    onMouseUp: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @canvas.state.onMouseUp(x, y)
        return false

    onMouseLeave: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @canvas.state.onMouseLeave(x, y)
        return false

    onMouseMove: (obj, e) =>
        [x, y] = @getEventPoint(e)
        @canvas.state.onMouseMove(x, y)
        return false

    getEventPoint: (e) ->
        cx = e.pageX - @canvas.offsetX
        cy = e.pageY - @canvas.offsetY
        @x(cx)
        @y(cy)
        return [cx, cy]