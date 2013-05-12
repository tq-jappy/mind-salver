class Item
    @id = 0

    constructor: (@x, @y, @w, @h, @shape) ->
        Item.id += 1
        @id = Item.id
        @text = "ABC"
        @update(@x, @y)

    # 元に戻すために保持
    save: () ->
        @saveX = @x
        @saveY = @y

    # 元に戻す
    restore: () ->
        if @saveX? and @saveY?
            @update(@saveX, @saveY)
            @saveX = null
            @saveY = null

    # 異動確定時に保持していた値をクリア
    clear: () ->
        @saveX = null
        @saveY = null

    update: (@x, @y) ->

