class Drawer
    constructor: (@ctx, @cell) ->
        console.log "1"
        console.log @ctx
        @pi2 = Math.PI * 2            # 2π

        @ux = @cell.halfWidth - 5
        @uy = @cell.halfHeight - 5
        @triangleHeightHalf = @uy * Math.tan(Math.PI / 3) / 2

        @drawCircle = (x, y) =>
            @ctx.save()
            @ctx.fillStyle = 'green'
            @ctx.beginPath()
            @ctx.arc(x, y, @uy, 0, @pi2, false)
            @ctx.fill()
            @ctx.restore()

        @drawSquare = (x, y) =>
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

        @drawTriangle = (x, y) =>
            @ctx.save()
            @ctx.fillStyle = 'blue'
            @ctx.beginPath()
            @ctx.moveTo(x, y - @triangleHeightHalf)
            @ctx.lineTo(x - @ux, y + @triangleHeightHalf)
            @ctx.lineTo(x + @ux, y + @triangleHeightHalf)
            @ctx.fill()
            @ctx.restore()

        # 画面を初期化
        @clearGrid = (width, height) =>
            @ctx.clearRect(0, 0, width, height)
            # グリッド表示
            @ctx.save()
            @ctx.globalAlpha = 0.5
            @ctx.strokeStyle = "#000033"
            @ctx.lineWidth = 1
            for h in [0..10] # 縦線
                @ctx.beginPath()
                @ctx.moveTo(h * @cell.width, 0)
                @ctx.lineTo(h * @cell.width, height)
                @ctx.stroke()
            for v in [0..10]
                @ctx.beginPath()
                @ctx.moveTo(0, v * @cell.height)
                @ctx.lineTo(width, v * @cell.height)
                @ctx.stroke()
            @ctx.restore()