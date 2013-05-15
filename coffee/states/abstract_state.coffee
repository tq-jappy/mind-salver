# 状態（シーン）の基底クラス。サブクラス側で必要なイベント処理だけを実装すればよい。
class AbstractState
    constructor: () ->

    onDblClick: (x, y) ->

    onMouseDown: (x, y) ->

    onMouseUp: (x, y) ->

    onMouseMove: (x, y) ->

    onMouseLeave: (x, y) ->

    toString: () ->
        @constructor.name