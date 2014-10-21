# 状態（シーン）の基底クラス。サブクラス側で必要なイベント処理だけを実装すればよい。
class AbstractState
    constructor: () ->

    onDblClick: (event) ->

    onMouseDown: (event) ->

    onMouseUp: (event) ->

    onMouseMove: (event) ->

    onMouseLeave: (event) ->

    toString: () ->
        @constructor.name