$ ->
    $canvas = $("#canvas")

    log "canvas initializing..."
    canvas = new fabric.Canvas("canvas")
    canvas.add(
      new fabric.Rect({width: 20, height: 30, fill: 'blue', left: 50, top: 50})
    )

    ctx = $canvas[0].getContext("2d")

    app = new Application(canvas, ctx, $canvas[0].width, $canvas[0].height)
    app.data.addItem(new Item(50, 50, 1, 1, "circle"))
    app.data.addItem(new Item(123, 77, 1, 1, "triangle"))
    app.data.addItem(new Item(77, 255, 1, 1, "rectangle"))

    panel = new ModePanel($("#modePanel"), app, app.data)
    panel.init()

    # bindings
    canvasViewModel = new CanvasViewModel(app)
    ko.applyBindings(canvasViewModel, $("#canvasContainer")[0])

    itemPropertyViewModel = new ItemPropertyViewModel()
    ko.applyBindings(itemPropertyViewModel, $("#item-property")[0])
    app.itemPropertyViewModel = itemPropertyViewModel

    toolbox = new Toolbox(app, app.data) # TypeSelectPanel($("#modePanel"), canvas, canvas.data)
    ko.applyBindings(new ToolboxViewModel(toolbox), $("#add-item-select")[0])
