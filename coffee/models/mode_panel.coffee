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

            mode = @obj.find('input[name="mode"]:checked').val()
            switch mode
                when "explorer"
                    @canvas.transit(new NormalState(@canvas, @data))
                when "painter"
                    @canvas.transit(new PaintNormalState(@canvas, @data))

            return