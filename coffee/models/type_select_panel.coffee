class TypeSelectPanel
    constructor: (@obj, @canvas, @data) ->

    # 初期化処理
    init: () ->
        $('#add-item-select li[shape="circle"]').on "click", =>
            @canvas.transit(new ItemAddState(@canvas, @data, "circle"))
            $('#add-item-select li[shape="circle"]').addClass("selected")
            $('#add-item-select li[shape="triangle"]').removeClass("selected")
            $('#add-item-select li[shape="rectangle"]').removeClass("selected")
            return

        $('#add-item-select li[shape="triangle"]').on "click", =>
            @canvas.transit(new ItemAddState(@canvas, @data, "triangle"))
            $('#add-item-select li[shape="circle"]').removeClass("selected")
            $('#add-item-select li[shape="triangle"]').addClass("selected")
            $('#add-item-select li[shape="rectangle"]').removeClass("selected")
            return

        $('#add-item-select li[shape="rectangle"]').on "click", =>
            @canvas.transit(new ItemAddState(@canvas, @data, "rectangle"))
            $('#add-item-select li[shape="circle"]').removeClass("selected")
            $('#add-item-select li[shape="triangle"]').removeClass("selected")
            $('#add-item-select li[shape="rectangle"]').addClass("selected")
            return