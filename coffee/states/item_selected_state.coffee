# アイテム選択直後の状態
class ItemSelectedState extends AbstractState
    constructor: (@app, @canvas, @data, @item) ->

    onMouseUp: (event) ->
        @app.transit(new NormalState(@app, @canvas, @data))

    onMouseMove: (event) ->
        @app.transit(new ItemMovingState(@app, @canvas, @data, @item))