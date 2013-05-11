$ ->
    $canvas = $("#canvas")
    ctx = $canvas[0].getContext("2d")
    ctx.lineWidth = 1
    ctx.font = "10pt Arial"
    ctx.textAlign = "center"
    ctx.textBaseline = "middle"
    ctx.globalAlpha = 0.5
    ctx.globalCompositeOperation = "source-over"

    canvas = new Canvas($canvas, ctx, $canvas[0].width, $canvas[0].height)
    canvas.init()

    canvas.data.addItem(new Item(50, 50, "circle"))
    canvas.data.addItem(new Item(123, 77, "triangle"))
    canvas.data.addItem(new Item(77, 255, "rectangle"))

    canvas.draw()

    panel = new ModePanel($("#modePanel"), canvas)
    panel.init()
