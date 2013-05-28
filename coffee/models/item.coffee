class Item
    @sequence = 0

    constructor: (@x, @y, @sizeX, @sizeY, @shape) ->
        Item.sequence += 1
        @id = Item.sequence
        @focused = false
        @text = "ABC"
        @update(@x, @y)

        # TODO:
        div = document.createElement("span")
        div.appendChild(document.createTextNode(@id))
        div.className = "canvasText"
        # div.style.fontSize = "48px"
        div.style.fontFamily = "メイリオ,sans-serif"
        div.style.fonwWeight = "normal"
        div.style.visible = "hidden"
        div.style.position = "absolute"
        div.style.display = "none"
        @element = div
        $('#canvas').append(div)

    # 元に戻すために保持
    saveCurrentPosition: () ->
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
