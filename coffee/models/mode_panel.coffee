# 編集モード
class ModePanel
    constructor: (@obj, @app, @data) ->

    # 初期化処理
    init: () ->
        # イベントをバインド
        @obj.click (e) =>
            gridVal = @obj.find('input[name="grid"]:checked').val()
            isGridEnabled = if gridVal is "true" then true else false
            if @app.grid isnt isGridEnabled
                @app.update({grid: isGridEnabled})
            @app.transit(new NormalState(@app, @data))

            return
