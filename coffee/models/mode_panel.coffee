class ModePanel
    constructor: (@obj, @canvas) ->

    # 初期化処理
    init: () ->
        # イベントをバインド
        @obj.click (e) =>
            val = @obj.find('input[name="grid"]:checked').val()
            grid = if val is "true" then true else false
            if @canvas.grid isnt grid
                @canvas.init({grid: grid})
                @canvas.draw()
            return