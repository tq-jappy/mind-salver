class CanvasView
    constructor: (@ctx, @cell) ->
        @pi2 = Math.PI * 2 # 計算用 2π
        @ux = @cell.halfWidth - 5 # 計算用
        @uy = @cell.halfHeight - 5 # 計算用
        @triangleHeightHalf = @uy * Math.tan(Math.PI / 3) / 2 # 計算用

    # 画面表示
    draw: (data) ->
        log "draw"
        @clean(data.canvasWidth, data.canvasHeight, data.grid)

        for item in data.items
            switch item.shape
                when "circle"
                    @drawCircle(item.x, item.y)
                when "triangle"
                    @drawTriangle(item.x, item.y)
                when "rectangle"
                    @drawRectangle(item.x, item.y)
            @drawText(item.text, item.x, item.y)

        @drawTraceLines(data.paintTraces)

    drawText: (text, x, y) ->
        @ctx.fillText(text, x, y)
        return

    drawTraceLines: (pointTraces) ->
        @ctx.save()
        @ctx.lineWidth = 2
        @ctx.fillStyle = 'green'
        @ctx.strokeStyle = 'green'

        for trace in pointTraces
            points = trace.points
            if points.length is 1
                @ctx.beginPath()
                @ctx.arc(points[0].x, points[0].y, 2, 0, @pi2, false)
                @ctx.fill()
            else if points.length > 1
                @ctx.beginPath()
                for p, i in points
                    if i is 0
                        @ctx.moveTo(p.x, p.y)
                    if i > 1
                        @ctx.lineTo(p.x, p.y)
                @ctx.stroke()

        @ctx.restore()
        return

    drawLine: (x, y) ->
        @ctx.save()
        @ctx.fillStyle = 'green'
        @ctx.beginPath()
        @ctx.arc(x, y, 2, 0, @pi2, false)
        @ctx.fill()
        @ctx.restore()
        return

    drawCircle: (x, y) ->
        @ctx.save()
        @ctx.fillStyle = 'green'
        @ctx.beginPath()
        @ctx.arc(x, y, @uy, 0, @pi2, false)
        @ctx.fill()
        @ctx.restore()
        return

    drawRectangle: (x, y) ->
        @ctx.save()
        @ctx.fillStyle = 'purple'
        @ctx.beginPath()
        @ctx.moveTo(x - @ux, y - @uy)
        @ctx.lineTo(x - @ux, y + @uy)
        @ctx.lineTo(x + @ux, y + @uy)
        @ctx.lineTo(x + @ux, y - @uy)
        @ctx.closePath()
        @ctx.fill()
        @ctx.restore()
        return

    drawTriangle: (x, y) ->
        @ctx.save()
        @ctx.fillStyle = 'blue'
        @ctx.beginPath()
        @ctx.moveTo(x, y - @triangleHeightHalf)
        @ctx.lineTo(x - @ux, y + @triangleHeightHalf)
        @ctx.lineTo(x + @ux, y + @triangleHeightHalf)
        @ctx.fill()
        #@ctx.beginPath()
        #x += @cell.width
        #@ctx.moveTo(x, y - @triangleHeightHalf)
        #@ctx.lineTo(x - @ux, y + @triangleHeightHalf)
        #@ctx.lineTo(x + @ux, y + @triangleHeightHalf)
        #@ctx.fill()
        @ctx.restore()
        return

    # 画面を初期化
    clean: (width, height, grid=true) ->
        @ctx.clearRect(0, 0, width, height)

        return unless grid

        # グリッド表示
        @ctx.save()
        @ctx.globalAlpha = 0.5
        @ctx.strokeStyle = "#000033"
        @ctx.lineWidth = 1
        verticalLineNum = width / @cell.width
        horizontalLineNum = height / @cell.height
        for h in [0..verticalLineNum]
            @ctx.beginPath()
            @ctx.moveTo(h * @cell.width, 0)
            @ctx.lineTo(h * @cell.width, height)
            @ctx.stroke()
        for v in [0..horizontalLineNum]
            @ctx.beginPath()
            @ctx.moveTo(0, v * @cell.height)
            @ctx.lineTo(width, v * @cell.height)
            @ctx.stroke()
        @ctx.restore()

        return