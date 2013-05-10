class Canvas
    constructor: (@ctx, @width, @height) ->
        console.log "create Canvas. #{@width} : #{@height}"
        @items = []
        @gridWidth = 30               # グリッド間隔(px)
        @gridWidthHalf = @gridWidth/2 # グリッド間隔の半分
        @drawer = new Drawer(@ctx)
        console.log "drawer"
        console.log @drawer

    # 初期処理
    init: () ->
        console.log Canvas.type
        x = @gridWidthHalf
        y = @gridWidthHalf

        @items.push new Item(x, y, @drawer.drawCircle)
        y += @gridWidth
        @items.push new Item(x, y, @drawer.drawTriangle)
        y += @gridWidth
        @items.push new Item(x, y, @drawer.drawSquare)
        console.log @items

    # 画面表示
    draw: () ->
        @drawer.clearGrid(@width, @height)
        for item in @items
            item.drawer(item.x, item.y)

