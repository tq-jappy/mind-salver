# Canvas のメイン
class Canvas
    constructor: (@$canvas, @ctx, @width, @height) ->
        log "create Canvas."
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15, paddingX: 5, paddingY: 5}
        @offsetX = @$canvas.offset().left
        @offsetY = @$canvas.offset().top
        @view = new CanvasView(@ctx, @cell, @offsetX, @offsetY)
        @data = new CanvasData(@cell, @width, @height)
        @grid = true
        @itemPropertyViewModel = null
        @state = new NormalState(@, @data) # 初期状態
        @stateName = ko.observable("")

    transit: (@state) ->
        console.log "transit to #{@state}"
        @stateName(@state.constructor.name)

    # Canvas 自身のオプションを更新する
    update: (options={}) ->
        if options.grid?
            @grid = options.grid
            @data.updateOptions(options.grid)

        @view.draw(@data)
