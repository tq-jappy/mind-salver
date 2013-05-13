class Toolbox
    constructor: (@canvas, @data) ->
        @shapes = ["circle", "triangle", "rectangle", "connector", "straightline", "freeline"]
        @selectedShape = null
        @toolboxView = new ToolboxView()

    # 初期化処理
    init: () ->
        $('#add-item-select li[shape="circle"]').on "click", =>
            @switch("circle")
            @canvas.transit(new ItemAddState(@canvas, @data, "circle"))
            return

        $('#add-item-select li[shape="triangle"]').on "click", =>
            @switch("triangle")
            @canvas.transit(new ItemAddState(@canvas, @data, "triangle"))
            return

        $('#add-item-select li[shape="rectangle"]').on "click", =>
            @switch("rectangle")
            @canvas.transit(new ItemAddState(@canvas, @data, "rectangle"))
            return

        $('#add-item-select li[shape="connector"]').on "click", =>
            @switch("connector")
            @canvas.transit(new ConnectorNormalState(@canvas, @data))
            return

        $('#add-item-select li[shape="straightline"]').on "click", =>
            @switch("straightline")
            @canvas.transit(new StraightLineNormalState(@canvas, @data))
            return

        $('#add-item-select li[shape="freeline"]').on "click", =>
            @switch("freeline")
            @canvas.transit(new PaintNormalState(@canvas, @data))
            return


    switch: (shape) ->
        @selectedShape = shape
        @toolboxView.update(@)

    selected: (shape) ->
        return selectedShape? and selectedShape is shape