class ModePanel
    constructor: (@obj, @canvas) ->

    # 初期化処理
    init: () ->
        # イベントをバインド
        @obj.click (e) =>
            gridVal = @obj.find('input[name="grid"]:checked').val()
            grid = if gridVal is "true" then true else false
            if @canvas.grid isnt grid
                @canvas.update({grid: grid})

            mode = @obj.find('input[name="mode"]:checked').val()
            if @canvas.handler isnt mode
                @canvas.update({mode: mode})

            return