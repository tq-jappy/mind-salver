class Drawer
    constructor: (@ctx) ->
        console.log "1"
        console.log @ctx
        @pi2 = Math.PI * 2            # 2π
        @gridWidth = 30               # グリッド間隔(px)
        @baseLength = @gridWidth / 2 - 5
        @triangleHeightHalf = @baseLength * Math.tan(Math.PI / 3) / 2

        @drawCircle = (x, y) =>
            @ctx.save()
            @ctx.fillStyle = 'green'
            @ctx.beginPath()
            @ctx.arc(x, y, @baseLength, 0, @pi2, false)
            @ctx.fill()
            @ctx.restore()

        @drawSquare = (x, y) =>
            @ctx.save()
            @ctx.fillStyle = 'purple'
            @ctx.beginPath()
            @ctx.moveTo(x - @baseLength, y - @baseLength)
            @ctx.lineTo(x - @baseLength, y + @baseLength)
            @ctx.lineTo(x + @baseLength, y + @baseLength)
            @ctx.lineTo(x + @baseLength, y - @baseLength)
            @ctx.closePath()
            @ctx.fill()
            @ctx.restore()

        @drawTriangle = (x, y) =>
            @ctx.save()
            @ctx.fillStyle = 'blue'
            @ctx.beginPath()
            @ctx.moveTo(x, y - @triangleHeightHalf)
            @ctx.lineTo(x - @baseLength, y + @triangleHeightHalf)
            @ctx.lineTo(x + @baseLength, y + @triangleHeightHalf)
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
            for h in [0..10]
                @ctx.beginPath()
                @ctx.moveTo(h * @gridWidth, 0)
                @ctx.lineTo(h * @gridWidth, height)
                @ctx.stroke()
            for v in [0..10]
                @ctx.beginPath()
                @ctx.moveTo(0, v * @gridWidth)
                @ctx.lineTo(width, v * @gridWidth)
                @ctx.stroke()
            @ctx.restore()