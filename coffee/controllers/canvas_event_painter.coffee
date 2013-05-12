# ペイント時のイベント処理
class CanvasEventPainter extends AbstractController
    constructor: (@data) ->
        @init()

    init: () ->

    onMouseDown: (x, y) ->
        @data.lineStart(x, y)

    onMouseUp: (x, y) ->
        @data.lineEnd(x, y)

    onMouseMove: (x, y) ->
        @data.lineKeep(x, y)
