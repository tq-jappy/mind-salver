class Drawer
    constructor: (@ctx, @cell) ->
        @pi2 = Math.PI * 2 # 計算用 2π
        @ux = @cell.halfWidth - 5 # 計算用
        @uy = @cell.halfHeight - 5 # 計算用
        @triangleHeightHalf = @uy * Math.tan(Math.PI / 3) / 2 # 計算用

        @drawText = (text, x, y) =>
            @ctx.fillText(text, x, y)
            return

        @drawCircle = (x, y) =>
            @ctx.save()
            @ctx.fillStyle = 'green'
            @ctx.beginPath()
            @ctx.arc(x, y, @uy, 0, @pi2, false)
            @ctx.fill()
            @ctx.restore()
            return

        @drawRectangle = (x, y) =>
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

        @drawTriangle = (x, y) =>
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
        @clean = (width, height, grid=true) =>
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