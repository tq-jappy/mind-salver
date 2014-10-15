# アプリケーションメイン
class Application
    constructor: (@canvas, @ctx) ->
        log "create Canvas."
        log @canvas.getElement()
        @cell = {width: 50, height: 30, halfWidth: 25, halfHeight: 15, paddingX: 5, paddingY: 5}
        @view = new CanvasView(@canvas, @ctx, @cell)
        @data = new CanvasData(@canvas, @cell)
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
