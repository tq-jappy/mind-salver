$ ->
    $canvas = $("#canvas")
    ctx = $canvas[0].getContext("2d")
    ctx.lineWidth = 1
    ctx.globalAlpha = 0.5
    ctx.globalCompositeOperation = "source-over"

    canvas = new Canvas($canvas, ctx, $canvas[0].width, $canvas[0].height)
    canvas.init()
    canvas.draw()

    panel = new ModePanel($("#modePanel"), canvas)
    panel.init()
