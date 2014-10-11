# Canvas のメイン
class Canvas
    constructor: (@fabricCanvas, @ctx, @width, @height) ->
        log "create Canvas."
        log @fabricCanvas.getElement()
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15, paddingX: 5, paddingY: 5}
        @view = new CanvasView(@fabricCanvas, @ctx, @cell)
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
