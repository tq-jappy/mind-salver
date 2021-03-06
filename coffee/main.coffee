$ ->
    $canvas = $("#canvas")

    log "canvas initializing..."
    canvas = new fabric.Canvas("canvas", { selection: false })

    ctx = $canvas[0].getContext("2d")

    app = new Application(canvas, ctx)
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
