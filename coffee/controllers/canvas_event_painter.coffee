# ペイント時のイベント処理
class CanvasEventPainter
    constructor: (@data) ->
        @init()

    init: () ->
        @state = {current: null}

    onDown: (x, y) ->
        unless @state.current?
            @state.current = new PaintTrace(x, y)
            @data.paintTraces.push @state.current

        return true

    onUp: (x, y) ->
        if @state.current?
            @state.current.addPoint(x, y)
            @state.current = null

        return true

    onMove: (x, y) ->
        if @state.current?
            @state.current.addPoint(x, y)
            return true
        else
            return false