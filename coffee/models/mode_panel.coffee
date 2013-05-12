class ModePanel
    constructor: (@obj, @canvas, @data) ->

    # 初期化処理
    init: () ->
        # イベントをバインド
        @obj.click (e) =>
            gridVal = @obj.find('input[name="grid"]:checked').val()
            grid = if gridVal is "true" then true else false
            if @canvas.grid isnt grid
                @canvas.update({grid: grid})

            return
