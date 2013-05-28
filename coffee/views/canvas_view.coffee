class CanvasView
    constructor: (@ctx, @cell, @offsetX, @offsetY) ->
        @pi2 = Math.PI * 2 # 計算用 2π
        @ux = @cell.halfWidth - 5 # 計算用
        @uy = @cell.halfHeight - 5 # 計算用
        @triangleHeightHalf = @uy * Math.tan(Math.PI / 3) / 2 # 計算用

    # 画面表示
    draw: (data) ->
        # log "draw"
        @clean(data.canvasWidth, data.canvasHeight, data.grid, data.offsetX, data.offsetY)

        for item, i in data.items
            switch item.shape
                when "circle"
                    @drawCircle(item.x - data.offsetX, item.y - data.offsetY, item.focused)
                when "triangle"
                    @drawTriangle(item.x - data.offsetX, item.y - data.offsetY, item.focused)
                when "rectangle"
                    @drawRectangle(item.x - data.offsetX, item.y - data.offsetY, item.focused)
                else
                    log "unknown shape #{item.shape}"
            @drawText(item.text, item.element, item.x - data.offsetX, item.y - data.offsetY, i)

        @drawLines(data.lines, data.offsetX, data.offsetY)
        @drawConnectors(data.connectors, data.offsetX, data.offsetY)

    drawText: (text, element, x, y, i) ->
        # fillText だと拡大時にぼやけるので、DOM を移動して表示
        # element.style.visible = "show"
        # element.style.left = "#{@offsetX + x}px"
        # element.style.top = "#{@offsetY + y}px"
        @ctx.fillText(text, x, y)
        return

    drawLines: (lines, offsetX=0, offsetY=0) ->
        @ctx.save()
        @ctx.lineWidth = 2
        @ctx.fillStyle = 'green'
        @ctx.strokeStyle = 'green'

        for line in lines
            points = line.points
            if points.length is 1
                @ctx.beginPath()
                @ctx.arc(points[0].x - offsetX, points[0].y - offsetY, 2, 0, @pi2, false)
                @ctx.fill()
            else if points.length > 1
                @ctx.beginPath()
                for p, i in points
                    if i is 0
                        @ctx.moveTo(p.x - offsetX, p.y - offsetY)
                    if i > 0
                        @ctx.lineTo(p.x - offsetX, p.y - offsetY)
                @ctx.stroke()

        @ctx.restore()
        return

    drawConnectors: (connectors, offsetX=0, offsetY=0) ->
        @ctx.save()
        @ctx.lineWidth = 2
        @ctx.fillStyle = '#960'
        @ctx.strokeStyle = '#960'

        for connector in connectors
            @ctx.beginPath()
            from = connector.from
            @ctx.moveTo(from.x - offsetX, from.y - offsetY)
            if connector.to?
                @ctx.lineTo(connector.to.x - offsetX, connector.to.y - offsetY)
            else
                @ctx.lineTo(connector.x - offsetX, connector.y - offsetY)
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

    drawCircle: (x, y, focused=false) ->
        @ctx.save()
        @ctx.fillStyle = if focused then 'red' else 'green'
        @ctx.beginPath()
        @ctx.arc(x, y, @uy, 0, @pi2, false)
        @ctx.fill()
        @ctx.restore()
        return

    drawRectangle: (x, y, focused=false) ->
        @ctx.save()
        @ctx.fillStyle = if focused then 'red' else 'purple'
        @ctx.beginPath()
        @ctx.moveTo(x - @ux, y - @uy)
        @ctx.lineTo(x - @ux, y + @uy)
        @ctx.lineTo(x + @ux, y + @uy)
        @ctx.lineTo(x + @ux, y - @uy)
        @ctx.closePath()
        @ctx.fill()
        @ctx.restore()
        return

    drawTriangle: (x, y, focused=false) ->
        @ctx.save()
        @ctx.fillStyle  = if focused then 'red' else 'blue'
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
    clean: (width, height, grid=true, offsetX=0, offsetY=0) ->
        @ctx.clearRect(0, 0, width, height)

        return unless grid

        # グリッド表示
        @ctx.save()
        @ctx.globalAlpha = 0.5
        @ctx.strokeStyle = "#000033"
        @ctx.lineWidth = 1
        verticalLineNum = (width / @cell.width) + 3
        horizontalLineNum = (height / @cell.height) + 3
        offsetX = offsetX % @cell.width
        offsetY = offsetY % @cell.height
        for h in [-3..verticalLineNum] # 縦線を引いていく
            @ctx.beginPath()
            x = h * @cell.width - offsetX
            y = -offsetY
            @ctx.moveTo(x, y)
            @ctx.lineTo(x, y + height)
            @ctx.stroke()
        for v in [-3..horizontalLineNum] # 横線を引いていく
            @ctx.beginPath()
            x = -offsetX
            y = v * @cell.height - offsetY
            @ctx.moveTo(x, y)
            @ctx.lineTo(x + width, y)
            @ctx.stroke()
        @ctx.restore()

        return
