$ ->
    $canvas = $("#canvas > .canvas")
    ctx = $canvas[0].getContext("2d")
    ctx.lineWidth = 1
    ctx.font = "10pt Arial"
    ctx.textAlign = "center"
    ctx.textBaseline = "middle"
    ctx.globalAlpha = 0.5
    ctx.globalCompositeOperation = "source-over"

    canvas = new Canvas($canvas, ctx, $canvas[0].width, $canvas[0].height)
    canvas.data.addItem(new Item(50, 50, 1, 1, "circle"))
    canvas.data.addItem(new Item(123, 77, 1, 1, "triangle"))
    canvas.data.addItem(new Item(77, 255, 1, 1, "rectangle"))

    panel = new ModePanel($("#modePanel"), canvas, canvas.data)
    panel.init()

    # bindings
    canvasViewModel = new CanvasViewModel(canvas)
    ko.applyBindings(canvasViewModel, $("#canvas")[0])

    itemPropertyViewModel = new ItemPropertyViewModel()
    ko.applyBindings(itemPropertyViewModel, $("#item-property")[0])
    canvas.itemPropertyViewModel = itemPropertyViewModel

    toolbox = new Toolbox(canvas, canvas.data) # TypeSelectPanel($("#modePanel"), canvas, canvas.data)
    ko.applyBindings(new ToolboxViewModel(toolbox), $("#add-item-select")[0])