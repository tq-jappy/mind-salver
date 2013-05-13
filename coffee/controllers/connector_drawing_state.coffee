# 直線描画状態
class ConnectorDrawingState extends AbstractState
    constructor: (@canvas, @data, @line) ->
        @target = null

    onMouseUp: (x, y) ->
        item = @data.getItemAt(x, y)

        if item?
            @data.lineExpand(@line, x, y)
        else
            log "clear"
            a = @data.lines.length
            @data.lineClear(@line)
            b = @data.lines.length
            log "#{a} -> #{b}"
        @canvas.transit(new ConnectorNormalState(@canvas, @data))


    onMouseMove: (x, y) ->
        @data.lineExpand(@line, x, y)

        # 終点になり得るアイテムに focus。それ以外は unfocus
        item = @data.getItemAt(x, y)

        if @target?
            @data.unfocus(@target)

        if item?
            @data.focus(item)
            @target = item